 
/-
Copyright 2026 The Formal Conjectures Authors.
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
 
    https://www.apache.org/licenses/LICENSE-2.0
 
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-/
import FormalConjecturesUtil
import FormalConjectures.OEIS.«306477»
 
/-!
# Bridge Theorem — A306477 Definition Correspondence
 
This file establishes the formal correspondence between two equivalent
definitions of representability for the Sun (2,4,6,8) conjecture.
 
## The two definitions
 
**Definition 1** — `OeisA306477.A` (in 306477.lean, shifted form):
  `A n := ∃ w x y z : ℕ, n = C(w+2,2) + C(x+3,4) + C(y+5,6) + C(z+7,8)`
  Variables: w, x, y, z ≥ 0
 
**Definition 2** — External disproof (epoch-research, counting function):
  `A306477 n := #{(w,x,y,z) : C(w+2,2)+C(x+3,4)+C(y+5,6)+C(z+7,8) = n}`
  (same shifted form, but returns a count rather than a Prop)
 
## Why this matters
 
The external Lean disproof (epoch-research/LeanOpenProblems-results,
commit fd09021) proves:
  `¬ ∀ n : ℕ, 0 < n → 0 < A306477 n`
 
The main theorem in 306477.lean states:
  `¬ ∀ n : ℕ, 0 < n → A n`
 
These are mathematically equivalent via:
  `A n ↔ 0 < A306477 n`
 
This file establishes that bridge.
 
## Status
 
All theorems in this file have `sorry` placeholders.
Status: [OPEN] — requires Lean proof.
See FORMAL_AUDIT.md for the full audit checklist.
-/
 
namespace Sun2468Bridge
 
open OeisA306477
 
/-!
## Counting function (matches external disproof definition)
-/
 
/-- The representation counting function.
    Counts the number of (w,x,y,z) tuples with w,x,y,z ∈ {0,...,n}
    such that C(w+2,2)+C(x+3,4)+C(y+5,6)+C(z+7,8) = n.
 
    This matches the definition used in the external Lean disproof:
    epoch-research/LeanOpenProblems-results, commit fd09021. -/
def RepresentationCount (n : ℕ) : ℕ :=
  let R := Finset.range (n + 1)
  R.sum (fun w =>
  R.sum (fun x =>
  R.sum (fun y =>
  R.sum (fun z =>
  if (w + 2).choose 2 + (x + 3).choose 4 +
     (y + 5).choose 6 + (z + 7).choose 8 = n
  then 1 else 0))))
 
/-!
## Bridge theorem
-/
 
/-- The existential predicate `A n` is equivalent to the counting function
    being positive.
 
    Proof sketch:
    (→) If ∃ w x y z, n = C(w+2,2)+..., then the tuple (w,x,y,z) contributes
        1 to RepresentationCount n, so the count is positive.
        Requires: w,x,y,z ≤ n (follows from C(w+2,2) ≤ n, so w+2 ≤ ...).
    (←) If RepresentationCount n > 0, some term in the sum is 1,
        meaning some (w,x,y,z) satisfies the equation.
 
    Status: [OPEN] — sorry placeholder. -/
theorem A_iff_count_pos (n : ℕ) :
    A n ↔ 0 < RepresentationCount n := by
  constructor
  · intro ⟨w, x, y, z, h⟩
    simp only [RepresentationCount]
    -- Need: w, x, y, z ∈ Finset.range (n + 1)
    -- i.e., w ≤ n, x ≤ n, y ≤ n, z ≤ n
    -- This follows from C(w+2,2) ≤ n (since C(w+2,2) is one term of the sum = n)
    sorry -- [OPEN]: bound argument + Finset.sum_pos
  · intro h
    simp only [RepresentationCount] at h
    -- Extract witness from the positive sum
    sorry -- [OPEN]: Finset.sum_pos_iff extraction
 
/-!
## Corollaries
-/
 
/-- The conjecture in existential form (matches 306477.lean). -/
def Conjecture_Prop : Prop :=
  ∀ n : ℕ, 0 < n → A n
 
/-- The conjecture in counting form (matches external disproof). -/
def Conjecture_Count : Prop :=
  ∀ n : ℕ, 0 < n → 0 < RepresentationCount n
 
/-- The two formulations of the conjecture are equivalent.
    Status: [OPEN] — follows from A_iff_count_pos once that is proved. -/
theorem conjecture_equiv :
    Conjecture_Prop ↔ Conjecture_Count := by
  simp only [Conjecture_Prop, Conjecture_Count]
  constructor
  · intro h n hn; exact (A_iff_count_pos n).mp (h n hn)
  · intro h n hn; exact (A_iff_count_pos n).mpr (h n hn)
 
/-- The negations are also equivalent.
    Status: [OPEN] — follows from conjecture_equiv. -/
theorem conjecture_neg_equiv :
    ¬ Conjecture_Prop ↔ ¬ Conjecture_Count :=
  not_congr conjecture_equiv
 
/-- If the external disproof establishes ¬ Conjecture_Count,
    then ¬ Conjecture_Prop follows.
    Status: [OPEN] — conditional on bridge theorem and external proof import. -/
theorem conjecture_false_from_external
    (h_external : ¬ Conjecture_Count) :
    ¬ Conjecture_Prop :=
  conjecture_neg_equiv.mpr h_external
 
/-!
## The counterexample
-/
 
/-- The candidate counterexample. -/
def n_star : ℕ := 896315812331399
 
/-- n* has no admissible representation.
    Status: [OPEN] in Lean — [COMP] computationally (V23.4 audit).
    External Lean proof: epoch-research, commit fd09021. -/
theorem n_star_not_representable :
    ¬ A n_star := by
  rw [A_iff_count_pos]
  -- Equivalent to: RepresentationCount n_star = 0
  -- Established by external Lean proof via exhaustive search + kernel verification
  sorry -- [OPEN]: requires A_iff_count_pos + external proof
 
end Sun2468Bridge
 
/-!
## Audit notes
 
To complete this bridge:
 
1. Prove `A_iff_count_pos`:
   Forward: show w,x,y,z ≤ n when C(w+2,2)+...+C(z+7,8) = n
   Backward: extract witness from Finset.sum > 0
 
2. Verify RepresentationCount matches A306477 in external proof
   (same variable bounds, same if-condition, same summation order)
 
3. Run `#print axioms Sun2468Bridge.A_iff_count_pos` after proof
 
4. Run `#print axioms Sun2468Bridge.conjecture_false_from_external`
 
See FORMAL_AUDIT.md for the complete audit checklist.
-/
 
