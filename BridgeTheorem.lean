/-
  BridgeTheorem.lean
  Sun (2,4,6,8) Conjecture — A306477
  ===================================
 
  This file establishes the formal bridge between two equivalent
  definitions of representability used in this fork and in the
  external Lean disproof (epoch-research/LeanOpenProblems-results).
 
  Definition A (this fork):
    A : Prop — existential proposition
    A n := ∃ w x y z : ℕ, n = (w+2).choose 2 + ...
 
  Definition A306477 (external disproof):
    A306477 : ℕ → ℕ — counting function
    A306477 n := #{(w,x,y,z) : Φ(w,x,y,z) = n}
 
  Bridge theorem:
    A n ↔ 0 < A306477 n
 
  Once this bridge is established, the external disproof of
    ¬ ∀ n > 0, 0 < A306477 n
  directly implies
    ¬ ∀ n > 0, A n
  which is the negation of the conjecture as stated in this fork.
 
  Status: [OPEN] — sorry placeholders mark unproved steps.
  Lean version: 4.33.1 (this fork)
-/
 
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Sum
 
namespace Sun2468Bridge
 
/-!
## The polynomial map Φ
-/
 
/-- The binomial representation sum for given w, x, y, z ≥ 0.
    Uses the shifted form: C(w+2,2) + C(x+3,4) + C(y+5,6) + C(z+7,8). -/
def phi (w x y z : ℕ) : ℕ :=
  (w + 2).choose 2 +
  (x + 3).choose 4 +
  (y + 5).choose 6 +
  (z + 7).choose 8
 
/-!
## Definition A: Existential proposition (this fork)
-/
 
/-- `IsRepresentable n` holds iff n can be written as
    C(w+2,2) + C(x+3,4) + C(y+5,6) + C(z+7,8) for some w,x,y,z : ℕ. -/
def IsRepresentable (n : ℕ) : Prop :=
  ∃ w x y z : ℕ, n = phi w x y z
 
/-!
## Definition A306477: Counting function (external disproof)
 
This matches the definition used in:
  epoch-research/LeanOpenProblems-results
  commit fd09021e79869476ef83cda231312f1a2a89c8d7
  Submission/Spec.lean
-/
 
/-- `RepresentationCount n` counts the number of (w,x,y,z) tuples
    with w,x,y,z ∈ {0,...,n} such that Φ(w,x,y,z) = n.
 
    Note: The bound n+1 on each variable is a sufficient upper bound
    since C(n+2,2) > n for all n ≥ 1, so any valid w satisfies w ≤ n.
    A tighter bound can be used for efficiency. -/
def RepresentationCount (n : ℕ) : ℕ :=
  let R := Finset.range (n + 1)
  R.sum (fun w =>
  R.sum (fun x =>
  R.sum (fun y =>
  R.sum (fun z =>
  if phi w x y z = n then 1 else 0))))
 
/-!
## Bridge theorem: IsRepresentable n ↔ 0 < RepresentationCount n
-/
 
/-- The existential predicate is equivalent to the counting function
    being positive. This is the key bridge between the two definitions. -/
theorem isRepresentable_iff_count_pos (n : ℕ) :
    IsRepresentable n ↔ 0 < RepresentationCount n := by
  constructor
  · -- Forward: ∃ w x y z, n = phi w x y z → 0 < count
    intro ⟨w, x, y, z, h⟩
    simp only [RepresentationCount]
    -- The tuple (w, x, y, z) contributes 1 to the sum
    -- Need: w, x, y, z ∈ Finset.range (n + 1)
    -- This requires showing w ≤ n, x ≤ n, y ≤ n, z ≤ n
    -- which follows from phi w x y z = n and the growth of binomial coefficients
    sorry -- [OPEN]: bound argument needed
  · -- Backward: 0 < count → ∃ w x y z, n = phi w x y z
    intro h
    simp only [RepresentationCount] at h
    -- Extract a witness from the sum
    -- If the sum is positive, some term is positive, i.e., some if-branch fires
    sorry -- [OPEN]: Finset.sum_pos extraction needed
 
/-!
## Corollary: The conjecture is equivalent in both formulations
-/
 
/-- The conjecture in existential form. -/
def Conjecture_Prop : Prop :=
  ∀ n : ℕ, 0 < n → IsRepresentable n
 
/-- The conjecture in counting form (matches external disproof target). -/
def Conjecture_Count : Prop :=
  ∀ n : ℕ, 0 < n → 0 < RepresentationCount n
 
/-- The two formulations of the conjecture are equivalent. -/
theorem conjecture_equiv :
    Conjecture_Prop ↔ Conjecture_Count := by
  simp only [Conjecture_Prop, Conjecture_Count]
  constructor
  · intro h n hn
    exact (isRepresentable_iff_count_pos n).mp (h n hn)
  · intro h n hn
    exact (isRepresentable_iff_count_pos n).mpr (h n hn)
 
/-- The negation of the conjecture is also equivalent. -/
theorem conjecture_neg_equiv :
    ¬ Conjecture_Prop ↔ ¬ Conjecture_Count :=
  not_congr conjecture_equiv
 
/-!
## The counterexample
-/
 
/-- The candidate counterexample value. -/
def n_star : ℕ := 896315812331399
 
/-- If the external disproof establishes ¬ Conjecture_Count,
    then ¬ Conjecture_Prop follows by conjecture_neg_equiv.
 
    The external disproof (epoch-research, commit fd09021) proves:
      ¬ ∀ n : ℕ, 0 < n → 0 < A306477 n
    which corresponds to ¬ Conjecture_Count.
 
    Assuming the external proof is valid and the definitions match,
    this gives ¬ Conjecture_Prop. -/
theorem conjecture_false_from_external
    (h_external : ¬ Conjecture_Count) :
    ¬ Conjecture_Prop :=
  conjecture_neg_equiv.mpr h_external
 
/-!
## Specific counterexample statement
-/
 
/-- The specific claim: n_star has no admissible representation.
    This is what the external Lean proof establishes via A_zero. -/
theorem n_star_not_representable :
    ¬ IsRepresentable n_star := by
  rw [isRepresentable_iff_count_pos]
  -- Equivalent to: RepresentationCount n_star = 0
  -- This is established by the external Lean proof via exhaustive search
  -- and kernel-checked chunk verification
  sorry -- [OPEN]: requires importing or re-proving the external result
 
end Sun2468Bridge
 
/-!
## Audit notes
 
To complete this bridge:
 
1. Prove `isRepresentable_iff_count_pos`:
   - Forward direction: show w, x, y, z ≤ n when phi w x y z = n
     (follows from C(w+2,2) ≤ phi w x y z = n, so w+2 ≤ ... )
   - Backward direction: extract witness from Finset.sum > 0
 
2. Verify that `RepresentationCount` matches `A306477` in the external proof
   (same variable bounds, same if-condition, same summation order)
 
3. Run `#print axioms isRepresentable_iff_count_pos` after proof is complete
 
4. Run `#print axioms conjecture_false_from_external` to check full dependency
 
Status: sorry placeholders at lines marked [OPEN]
-/
 
