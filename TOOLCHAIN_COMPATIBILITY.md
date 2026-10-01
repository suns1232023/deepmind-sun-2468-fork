# Toolchain Compatibility Analysis

## Summary

| Item | This Fork | External Disproof |
|------|-----------|-------------------|
| Lean version | 4.33.1 | 4.27.0 |
| Mathlib version | (follows lean-toolchain) | v4.27.0 |
| Status | Current | Older release |

---

## The Compatibility Question

The external Lean disproof (epoch-research/LeanOpenProblems-results, commit fd09021) was developed with **Lean 4.27.0 / Mathlib v4.27.0**.

This fork uses **Lean 4.33.1**.

The question is: does the external proof still build and verify correctly under Lean 4.33.1?

---

## Why This Matters

The `formal_proof` annotation in this fork links to the external proof as a reference. For this annotation to be fully justified:

1. The external proof must build without errors under the referenced toolchain.
2. The proof must not rely on any axioms or tactics that changed semantics between 4.27.0 and 4.33.1.
3. The `decide` and kernel-checking steps must produce the same result.

---

## Risk Assessment

### Low risk

- **Core logic**: The mathematical content (binomial coefficients, Finset operations, `decide` for finite computations) is stable across Lean 4.x releases.
- **`decide` tactic**: The `decide` tactic calls the kernel evaluator, which is highly stable. The 19 chunk verifications using `decide + kernel` are unlikely to be affected by minor version changes.
- **Mathlib API**: The basic Finset and Nat.choose APIs used in the proof are stable.

### Medium risk

- **`native_decide`**: If the external proof uses `native_decide` (which compiles to native code), results may differ across versions due to compiler changes. The external proof appears to use `decide` (kernel-checked), not `native_decide`, which reduces this risk.
- **Elaboration changes**: Minor elaboration changes between 4.27.0 and 4.33.1 could cause type-checking failures in edge cases.

### Mitigation options

Three options are available:

---

## Option A: Pin to external proof's toolchain (Recommended for audit)

Temporarily downgrade this fork's `lean-toolchain` to match the external proof:

```
leanprover/lean4:v4.27.0
```

Then verify the external proof builds:

```bash
# In a local clone of epoch-research/LeanOpenProblems-results
cd runs/oeis-open-lite-fable51-wm0v421z5ygi8f6b/oeis_306477_conjecture_1
lake build
# Expected: success
#print axioms oeis_306477_conjecture_1.disproof
# Expected: no sorryAx, standard axioms only
```

**Advantage**: Direct verification of the external proof as-is.
**Disadvantage**: Requires downgrading this fork temporarily.

---

## Option B: Re-verify under current toolchain

Import or re-implement the external proof under Lean 4.33.1:

```lean
-- In this fork, under Lean 4.33.1
-- Re-implement the key steps from Spec.lean
theorem n_star_count_zero :
    RepresentationCount n_star = 0 := by
  native_decide  -- or decide, depending on feasibility
```

**Advantage**: Verifies compatibility directly.
**Disadvantage**: `decide` on a computation of this scale (2.8 billion triples) may be infeasible without the chunking strategy from the external proof.

---

## Option C: Document the version gap explicitly (Current approach)

Record the version difference in FORMAL_AUDIT.md and RESEARCH_STATUS.md, and note that:

- The external proof was verified under Lean 4.27.0.
- Compatibility with Lean 4.33.1 has not been independently verified.
- The `formal_proof` annotation is a reference, not a build-verified import.

**Advantage**: Honest and auditable.
**Disadvantage**: Leaves the compatibility question open.

---

## Recommended Action

**For the bridge theorem audit (P0):**

1. Use **Option A** — temporarily pin to Lean 4.27.0 to verify the external proof directly.
2. Record the `#print axioms` output.
3. Confirm absence of `sorryAx` and `native_decide`.
4. Then restore Lean 4.33.1 for this fork.

**For the `formal_proof` annotation:**

Add a note to the annotation clarifying the toolchain version:

```lean
@[category research solved, AMS 11,
  formal_proof using lean4 at
    "https://github.com/epoch-research/LeanOpenProblems-results/...Spec.lean#L793",
  note := "External proof verified under Lean 4.27.0 / Mathlib v4.27.0. \
           Compatibility with Lean 4.33.1 pending verification."]
theorem conjecture : ¬ ∀ n : ℕ, 0 < n → A n := by
  sorry
```

---

## Checklist

| Task | Status |
|------|--------|
| Identify external proof toolchain version | ✅ Lean 4.27.0 / Mathlib v4.27.0 |
| Identify this fork's toolchain version | ✅ Lean 4.33.1 |
| Assess risk of version difference | ✅ Low-to-medium (see above) |
| Verify external proof under Lean 4.27.0 | ⏳ Pending |
| Record `#print axioms` output | ⏳ Pending |
| Confirm no `sorryAx` | ⏳ Pending |
| Confirm no `native_decide` | ⏳ Pending |
| Verify or re-implement under Lean 4.33.1 | ⏳ Pending |

---

## Commands to Run (Lean environment required)

```bash
# Step 1: Clone the external proof repository
git clone https://github.com/epoch-research/LeanOpenProblems-results
cd LeanOpenProblems-results
git checkout fd09021e79869476ef83cda231312f1a2a89c8d7

# Step 2: Navigate to the relevant submission
cd runs/oeis-open-lite-fable51-wm0v421z5ygi8f6b/oeis_306477_conjecture_1

# Step 3: Check the Lean version used
cat lean-toolchain

# Step 4: Build the proof
lake build

# Step 5: In Lean, check axioms
-- Add to Spec.lean or a new file:
#print axioms oeis_306477_conjecture_1.disproof

# Step 6: Check for sorry
grep -r "sorry" Submission/

# Step 7: Check for native_decide
grep -r "native_decide" Submission/
```

---

## References

- External proof: [epoch-research/LeanOpenProblems-results, commit fd09021](https://github.com/epoch-research/LeanOpenProblems-results/blob/fd09021e79869476ef83cda231312f1a2a89c8d7/runs/oeis-open-lite-fable51-wm0v421z5ygi8f6b/oeis_306477_conjecture_1/Submission/Spec.lean)
- This fork lean-toolchain: [suns1232023/deepmind-sun-2468-fork/lean-toolchain](https://raw.githubusercontent.com/suns1232023/deepmind-sun-2468-fork/main/lean-toolchain)
- Lean release notes: [leanprover/lean4/releases](https://github.com/leanprover/lean4/releases)
- FORMAL_AUDIT.md: [FORMAL_AUDIT.md](FORMAL_AUDIT.md)
