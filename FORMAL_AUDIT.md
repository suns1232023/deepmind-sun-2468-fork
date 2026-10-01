# Formal Proof Audit — A306477 Disproof

## Purpose

This document records the formal proof provenance for the disproof of the Sun (2,4,6,8) conjecture (OEIS A306477). It provides a precise, auditable record of the Lean-level correspondence between the theorem statement in this fork and the externally hosted formal disproof.

---

## The Core Correspondence Problem

### Definition in this fork — Existential Prop

```lean
def A (n : ℕ) : Prop :=
  ∃ w x y z : ℕ,
  n =
    (w + 2).choose 2 +
    (x + 3).choose 4 +
    (y + 5).choose 6 +
    (z + 7).choose 8
```

### Definition in external disproof — Counting function

Source: epoch-research/LeanOpenProblems-results, commit fd09021

```lean
def A306477 (n : ℕ) : ℕ :=
  let R := Finset.range (n + 1)
  R.sum (fun w =>
  R.sum (fun x =>
  R.sum (fun y =>
  R.sum (fun z =>
  if
    (w + 2).choose 2 +
    (x + 3).choose 4 +
    (y + 5).choose 6 +
    (z + 7).choose 8 = n
  then 1
  else 0))))
```

### Mathematical equivalence

$$A_{\mathrm{Prop}}(n) \iff A_{\mathrm{count}}(n) > 0.$$

These two definitions are mathematically equivalent. However, Lean formal proof provenance requires a stricter standard: the `formal_proof` annotation should link to a proof that directly establishes the negation of the **same** Lean proposition, or to a bridge theorem that formally connects the two definitions.

### Required bridge theorem

```lean
theorem isRepresentable_iff_count_pos (n : ℕ) :
    A n ↔ 0 < A306477 n := by
  ...
```

**Status: `[OPEN]` — bridge theorem not yet established in this fork.**

---

## External Disproof Record

| Field | Value |
|-------|-------|
| Repository | epoch-research/LeanOpenProblems-results |
| Commit | `fd09021e79869476ef83cda231312f1a2a89c8d7` |
| File | `runs/oeis-open-lite-fable51-wm0v421z5ygi8f6b/oeis_306477_conjecture_1/Submission/Spec.lean` |
| Theorem | `oeis_306477_conjecture_1.disproof` |
| Counterexample | `n0 = 896315812331399` |
| Lean version (external) | 4.27.0 |
| Mathlib version (external) | v4.27.0 |

### Theorem statement (external)

```lean
theorem oeis_306477_conjecture_1.disproof :
    ¬ (type_of% @oeis_306477_conjecture_1) := by
  ...
  have := h D2468.n0 (by decide)
  rw [D2468.A_zero] at this
  exact lt_irrefl 0 this
```

### Proof structure (external)

1. **`A_zero`**: $A_{306477}(n^*) = 0$ — the counting function returns zero for $n^* = 896{,}315{,}812{,}331{,}399$.
2. **Bounds**: Explicit finite bounds on all four variables $w, x, y, z$.
3. **Local tables**: 23-prime local obstruction tables.
4. **Chunk verification**: 19 $z$-chunks, each verified using `decide` + kernel.
5. **Disproof**: Derives $\neg\, \forall n > 0,\; 0 < A_{306477}(n)$.

---

## Lean Toolchain Version Note

| Item | Version |
|------|---------|
| This fork | Lean 4.33.1 |
| External disproof | Lean 4.27.0 / Mathlib v4.27.0 |

This version difference does not invalidate the proof, but compatibility has not yet been independently verified. See [TOOLCHAIN_COMPATIBILITY.md](TOOLCHAIN_COMPATIBILITY.md) for the full analysis.

---

## Audit Checklist

| # | Check | Status |
|---|-------|--------|
| 1 | Exact Lean declaration confirmed | ✅ Confirmed (see above) |
| 2 | Counterexample value confirmed: $n^* = 896{,}315{,}812{,}331{,}399$ | ✅ Confirmed |
| 3 | `#print axioms oeis_306477_conjecture_1.disproof` output recorded | ⏳ Pending |
| 4 | Absence of `sorryAx` in proof dependency chain | ⏳ Pending |
| 5 | `native_decide` usage checked | ⏳ Pending |
| 6 | Lean toolchain version compatibility verified | ⏳ Pending |
| 7 | Bridge theorem `isRepresentable_iff_count_pos` established | ❌ Not yet established |
| 8 | `formal_proof` annotation links to correct theorem | ⏳ Pending bridge theorem |

**Overall audit status: PENDING**

---

## Commands to Run (Lean environment required)

```bash
# Step 1: Clone the external proof repository
git clone https://github.com/epoch-research/LeanOpenProblems-results
cd LeanOpenProblems-results
git checkout fd09021e79869476ef83cda231312f1a2a89c8d7

# Step 2: Navigate to the submission
cd runs/oeis-open-lite-fable51-wm0v421z5ygi8f6b/oeis_306477_conjecture_1

# Step 3: Build
lake build

# Step 4: In Lean, check axioms
#print axioms oeis_306477_conjecture_1.disproof

# Step 5: Check for sorry
grep -rn "sorry" Submission/

# Step 6: Check for native_decide
grep -rn "native_decide" Submission/
```

---

## Recommended Next Steps

### Priority 0 (required before `[FORMAL]` status)

1. Establish bridge theorem `isRepresentable_iff_count_pos` in this fork.
2. Record `#print axioms` output for `oeis_306477_conjecture_1.disproof`.
3. Confirm absence of `sorryAx` in the full proof dependency chain.
4. Check `native_decide` usage.
5. Resolve toolchain compatibility (Lean 4.33.1 vs 4.27.0).

### Priority 1 (recommended)

6. Consider adopting the counting-function definition `A306477 : ℕ` as the primary definition in this fork, to eliminate the need for a bridge theorem.

---

## References

- External disproof: [epoch-research/LeanOpenProblems-results, commit fd09021](https://github.com/epoch-research/LeanOpenProblems-results/blob/fd09021e79869476ef83cda231312f1a2a89c8d7/runs/oeis-open-lite-fable51-wm0v421z5ygi8f6b/oeis_306477_conjecture_1/Submission/Spec.lean)
- This fork: [suns1232023/deepmind-sun-2468-fork](https://github.com/suns1232023/deepmind-sun-2468-fork)
- OEIS A306477: [https://oeis.org/A306477](https://oeis.org/A306477)
- Upstream PR #1570: [github.com/google-deepmind/formal-conjectures/pull/1570](https://github.com/google-deepmind/formal-conjectures/pull/1570)
- Bridge theorem code: [BridgeTheorem.lean](BridgeTheorem.lean)
