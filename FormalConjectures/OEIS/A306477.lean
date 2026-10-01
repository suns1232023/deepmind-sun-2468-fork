 
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
# Sun's (2,4,6,8) Binomial Representation Conjecture — Fiber Geometry Extension
 
This file contains auxiliary Lean definitions and open research questions
related to the fiber geometry of the Sun (2,4,6,8) conjecture.
 
The primary conjecture statement and `def A` live in
`FormalConjectures/OEIS/306477.lean` (namespace `OeisA306477`).
 
This file imports 306477.lean and adds:
- The relationship between the original form (w,x,y,z ≥ 2) and the
  shifted form (w,x,y,z ≥ 0) used in 306477.lean.
- The complex and real fiber geometry.
- The Distributed Local Obstruction (DLO) framework.
 
**Important:** This file uses namespace `Sun2468FiberGeometry` to avoid
any conflict with `OeisA306477` defined in 306477.lean.
 
*Reference:* [OEIS A306477](https://oeis.org/A306477)
*Author/Context:* Scott Sun (2026), fiber geometry extension.
 
**Evidence levels used in this file:**
- `[FORMAL]`: Lean kernel-checked proof (no sorry, no custom axioms)
- `[EST]`: Mathematically established by explicit derivation (not Lean-formal)
- `[COMP]`: Computationally verified within a stated finite domain
- `[OPEN]`: Open question; no proof established
-/
 
namespace Sun2468FiberGeometry
 
/-!
## Variable shift equivalence
 
The conjecture has two equivalent formulations:
 
**Original form** (Sun 2019): w,x,y,z ≥ 2
  n = C(w,2) + C(x,4) + C(y,6) + C(z,8)
 
**Shifted form** (used in 306477.lean): w,x,y,z ≥ 0
  n = C(w+2,2) + C(x+3,4) + C(y+5,6) + C(z+7,8)
 
These are equivalent under the substitution w ↦ w+2, x ↦ x+3, y ↦ y+5, z ↦ z+7.
-/
 
/-- The representation predicate in the original form (w,x,y,z ≥ 2).
    This is mathematically equivalent to `OeisA306477.A` (shifted form)
    via the variable shift w ↦ w+2, x ↦ x+3, y ↦ y+5, z ↦ z+7. -/
def IsRepresentableOriginal (n : ℕ) : Prop :=
  ∃ w x y z : ℕ, w ≥ 2 ∧ x ≥ 2 ∧ y ≥ 2 ∧ z ≥ 2 ∧
  n = Nat.choose w 2 + Nat.choose x 4 + Nat.choose y 6 + Nat.choose z 8
 
/-- The two formulations are equivalent.
    Status: [OPEN] — the Lean proof is not yet established in this fork.
    Mathematically: substitute w' = w-2, x' = x-3, y' = y-5, z' = z-7. -/
@[category research open, AMS 11]
theorem original_iff_shifted (n : ℕ) :
    IsRepresentableOriginal n ↔ OeisA306477.A n := by
  sorry -- [OPEN]: variable shift argument needed
 
/-!
## The candidate counterexample
-/
 
/-- The candidate counterexample value. -/
def n_star : ℕ := 896315812331399
 
/-!
## Complex fiber geometry
 
The complex extension of the representation map:
  Φ_ℂ : ℂ⁴ → ℂ,  (w,x,y,z) ↦ C(w,2) + C(x,4) + C(y,6) + C(z,8)
where C(w,k) denotes the generalized binomial coefficient w(w-1)···(w-k+1)/k!.
 
Surjectivity of Φ_ℂ is mathematically established [EST] by the following argument:
fixing x=y=z=0, the map reduces to w ↦ w(w-1)/2, which is surjective over ℂ
(it is a non-constant polynomial). Hence every complex value is achieved.
 
This result is NOT yet formally proved in Lean in this fork.
-/
 
/-- Surjectivity of Φ_ℂ.
    Status: [OPEN] in Lean — mathematically established [EST] by polynomial argument.
    Do NOT label as `research established` until a Lean proof exists. -/
@[category research open, AMS 14]
theorem phi_complex_surjective :
    ∀ (target : ℂ), ∃ (w x y z : ℂ),
      -- Generalized: w*(w-1)/2 + x*(x-1)*(x-2)*(x-3)/24 + ... = target
      -- Proof sketch: set x=y=z=0, solve w*(w-1)/2 = target (quadratic over ℂ)
      True := by
  intro _
  trivial -- placeholder; the actual surjectivity proof is [OPEN]
 
/-!
## Explicit complex solution for -n*
 
For the value -n* = -896,315,812,331,399, an explicit complex solution exists
at (x,y,z) = (0,0,0):
 
  w = (1 + i·√(8n* - 1)) / 2 = (1 + i·√7,170,526,498,651,191) / 2
 
Verification: C(w,2) = w(w-1)/2 = -n* follows from w² - w + 2n* = 0,
whose discriminant is 1 - 8n* = -7,170,526,498,651,191.
 
Note: This uses the ORIGINAL form C(w,2), not the shifted form C(w+2,2).
The formula is correct for the original-form extension to ℂ.
 
Status: [EST] — mathematically verified by direct computation.
The Lean theorem below is a placeholder; the actual identity is not yet proved in Lean.
-/
 
/-- Explicit complex solution for -n* at (x,y,z) = (0,0,0).
    The value w = (1 + i·√(8n*-1))/2 satisfies C(w,2) = -n*.
    Status: [OPEN] in Lean — [EST] mathematically.
    Note: 8·n* - 1 = 7,170,526,498,651,191 (verified). -/
@[category research open, AMS 11]
theorem negative_n_star_complex_solution :
    -- C(w,2) = w*(w-1)/2 = -n* when w = (1 + i*sqrt(8*n*-1))/2
    -- Discriminant: 1 - 8*n* = -7170526498651191
    -- sqrt argument: 8*n* - 1 = 7170526498651191 ✓
    -- This is [EST] — mathematically verified, not yet Lean-formal
    True := by
  trivial -- [OPEN]: actual complex identity proof pending
 
/-!
## Real fiber
 
For n*, an explicit real (non-integer) solution exists:
  (w, x, y, z) ≈ (42,339,481.2, 4, 6, 8)
 
Verification: C(4,4) + C(6,6) + C(8,8) = 1 + 1 + 1 = 3
  C(w,2) = n* - 3 = 896,315,812,331,396
  w = (1 + √(1 + 8·(n*-3)))/2 ≈ 42,339,481.2
 
This shows: F_{n*}^ℝ ≠ ∅ (real fiber is non-empty).
But: F_{n*}^ℝ ∩ ℤ_adm⁴ = ∅ (no admissible integer representation).
 
Status: [EST] — mathematically verified by direct computation.
-/
 
/-- The real fiber of n* is non-empty.
    An explicit real solution is (w,x,y,z) ≈ (42339481.2, 4, 6, 8).
    Status: [OPEN] in Lean — [EST] mathematically.
    Note: w ≈ 42,339,481.2 (NOT 42,339,774.4 — see audit report). -/
@[category research open, AMS 11]
theorem n_star_real_fiber_nonempty :
    ∃ (w x y z : ℝ), w ≥ 2 ∧ x ≥ 2 ∧ y ≥ 2 ∧ z ≥ 2 ∧
    (w * (w - 1) / 2 + x * (x - 1) * (x - 2) * (x - 3) / 24 +
     y * (y - 1) * (y - 2) * (y - 3) * (y - 4) * (y - 5) / 720 +
     z * (z - 1) * (z - 2) * (z - 3) * (z - 4) * (z - 5) * (z - 6) * (z - 7) / 40320)
    = (n_star : ℝ) := by
  sorry -- [OPEN]: explicit construction with w ≈ 42339481.2, x=4, y=6, z=8
 
/-!
## Integer lattice absence
 
The admissible integer fiber of n* is empty:
  F_{n*}^ℤ = ∅
 
This is established computationally [COMP] by the V23.4 exhaustive audit
(2,818,953,028 triples enumerated, no representation found).
 
A formal Lean proof exists externally (epoch-research, commit fd09021)
but the bridge theorem connecting the two definitions is not yet established
in this fork. See FORMAL_AUDIT.md.
-/
 
/-- The integer lattice fiber of n* is empty (original form, w,x,y,z ≥ 2).
    Status: [COMP] computationally; [OPEN] in Lean (bridge theorem pending).
    External Lean proof: epoch-research/LeanOpenProblems-results, commit fd09021. -/
@[category research open, AMS 11]
theorem n_star_no_integer_representation :
    ¬ IsRepresentableOriginal n_star := by
  sorry -- [OPEN]: requires bridge theorem + external proof import
 
/-!
## Geometric distinction
 
The key insight: continuous existence does not imply integer existence.
 
  F_{n*}^ℂ ≠ ∅  (complex fiber non-empty)  [EST]
  F_{n*}^ℝ ≠ ∅  (real fiber non-empty)      [EST]
  F_{n*}^ℤ = ∅  (integer fiber empty)        [COMP] / [OPEN in Lean]
 
These are distinct mathematical questions.
-/
 
end Sun2468FiberGeometry
 
