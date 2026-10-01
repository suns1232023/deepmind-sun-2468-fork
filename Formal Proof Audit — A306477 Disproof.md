# Formal Proof Audit — A306477 Disproof

## Purpose

This document records the formal proof provenance for the disproof of the Sun (2,4,6,8) conjecture (OEIS A306477). It is intended to provide a precise, auditable record of the Lean-level correspondence between the theorem statement in this fork and the externally hosted formal disproof.

---

## The Core Correspondence Problem

This fork defines the representability predicate as a **Prop** (existential proposition):

```lean
def A (n : ℕ) : Prop :=
  ∃ w x y z : ℕ,
  n =
    (w + 2).choose 2 +
    (x + 3).choose 4 +
    (y + 5).choose 6 +
    (z + 7).choose 8
```

The external Lean disproof (epoch-research/LeanOpenProblems-results) defines the representability count as a **Nat** (counting function):

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

These two definitions are mathematically equivalent:

$$A_{\mathrm{Prop}}(n) \iff A_{\mathrm{count}}(n) > 0.$$

However, Lean formal proof provenance requires a stricter standard than mathematical equivalence. The `formal_proof` annotation in this fork should link to a proof that directly establishes the negation of the **same** Lean proposition, or to a bridge theorem that formally connects the two definitions.

### Required bridge theorem

```lean
theorem A_iff_count_pos (n : ℕ) :
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

The external proof establishes:

1. **`A_zero`**: $A_{306477}(n^*) = 0$ — the counting function returns zero for $n^* = 896{,}315{,}812{,}331{,}399$.
2. **Bounds**: Explicit finite bounds on all four variables $w, x, y, z$.
3. **Local tables**: 23-prime local obstruction tables.
4. **Chunk verification**: 19 $z$-chunks, each verified using `decide` + kernel.
5. **Disproof**: Derives $\neg\, \forall n > 0,\; 0 < A_{306477}(n)$.

---

## Audit Checklist

The following items must be independently verified before assigning `[FORMAL]` status to the disproof in this fork:

| # | Check | Status |
|---|-------|--------|
| 1 | Exact Lean declaration confirmed | ✅ Confirmed (see above) |
| 2 | Counterexample value confirmed: $n^* = 896{,}315{,}812{,}331{,}399$ | ✅ Confirmed |
| 3 | `#print axioms oeis_306477_conjecture_1.disproof` output | ⏳ Not yet recorded |
| 4 | Absence of `sorryAx` in proof dependency chain | ⏳ Not yet confirmed |
| 5 | `native_decide` usage checked | ⏳ Not yet confirmed |
| 6 | Lean toolchain version compatibility (fork: 4.33.1 vs external: 4.27.0) | ⏳ Not yet resolved |
| 7 | Bridge theorem `A_iff_count_pos` established | ❌ Not yet established |
| 8 | `formal_proof` annotation links to correct theorem | ⏳ Pending bridge theorem |

**Overall audit status: PENDING**

---

## Lean Toolchain Version Note

This fork uses:

```
lean-toolchain: leanprover/lean4:v4.33.1
```

The external disproof was developed with:

```
Lean 4.27.0 / Mathlib v4.27.0
```

This version difference does not invalidate the proof, but it means the external proof cannot be directly imported into this fork without compatibility verification. The `formal_proof` annotation currently links to the external proof as a reference; it does not constitute a build-verified import.

---

## Recommended Next Steps

### Priority 0 (required before `[FORMAL]` status)

1. **Establish bridge theorem** `A_iff_count_pos` in this fork, formally connecting `A : Prop` and `A306477 : ℕ`.
2. **Record `#print axioms`** output for `oeis_306477_conjecture_1.disproof`.
3. **Confirm absence of `sorryAx`** in the full proof dependency chain.
4. **Check `native_decide` usage** — if used, document whether it satisfies kernel-checking requirements.
5. **Resolve toolchain compatibility** — either verify the proof builds under Lean 4.33.1, or document the version gap explicitly.

### Priority 1 (recommended)

6. Consider adopting the counting-function definition `A306477 : ℕ` as the primary definition in this fork, to eliminate the need for a bridge theorem.
7. Add `IsRepresentable` and `RepresentationCount` as named definitions for clarity.

---

## Proposed Clean Definition Structure

```lean
-- Primary counting definition (matches external proof)
def RepresentationCount (n : ℕ) : ℕ :=
  (Finset.range (n + 1)).sum (fun w =>
  (Finset.range (n + 1)).sum (fun x =>
  (Finset.range (n + 1)).sum (fun y =>
  (Finset.range (n + 1)).sum (fun z =>
  if (w + 2).choose 2 + (x + 3).choose 4 +
     (y + 5).choose 6 + (z + 7).choose 8 = n
  then 1 else 0))))

-- Derived existential predicate
def IsRepresentable (n : ℕ) : Prop :=
  ∃ w x y z : ℕ,
  n = (w + 2).choose 2 + (x + 3).choose 4 +
      (y + 5).choose 6 + (z + 7).choose 8

-- Bridge theorem (to be proved)
theorem isRepresentable_iff_count_pos (n : ℕ) :
    IsRepresentable n ↔ 0 < RepresentationCount n := by
  sorry -- [OPEN]

-- Main conjecture (negation)
theorem conjecture_false :
    ¬ ∀ n : ℕ, 0 < n → 0 < RepresentationCount n := by
  -- Links directly to external disproof via RepresentationCount
  sorry -- [FORMAL] pending bridge + audit
```

---

## Current Status Summary

| Claim | Status |
|-------|--------|
| External Lean disproof exists | ✅ Confirmed |
| Counterexample $n^* = 896{,}315{,}812{,}331{,}399$ | ✅ Confirmed |
| Bridge theorem `A_iff_count_pos` | ❌ Not established |
| `#print axioms` recorded | ⏳ Pending |
| `sorryAx` absence confirmed | ⏳ Pending |
| Toolchain compatibility | ⏳ Pending |
| `[FORMAL]` status in this fork | ⏳ **PENDING AUDIT** |

---

## References

- External disproof: [epoch-research/LeanOpenProblems-results, commit fd09021](https://github.com/epoch-research/LeanOpenProblems-results/blob/fd09021e79869476ef83cda231312f1a2a89c8d7/runs/oeis-open-lite-fable51-wm0v421z5ygi8f6b/oeis_306477_conjecture_1/Submission/Spec.lean)
- This fork: [suns1232023/deepmind-sun-2468-fork](https://github.com/suns1232023/deepmind-sun-2468-fork)
- OEIS A306477: [https://oeis.org/A306477](https://oeis.org/A306477)
- Upstream formal-conjectures PR #1570: [github.com/google-deepmind/formal-conjectures/pull/1570](https://github.com/google-deepmind/formal-conjectures/pull/1570)
