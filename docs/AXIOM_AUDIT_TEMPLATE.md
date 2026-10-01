# Axiom Audit Record — oeis_306477_conjecture_1.disproof

## Purpose

This document records the results of the `#print axioms` audit for the external Lean disproof of A306477. It must be completed before assigning `[FORMAL]` status to the disproof in this fork.

**Status: PENDING — requires execution in a Lean environment.**

---

## How to Complete This Audit

### Step 1: Set up the environment

```bash
# Clone the external proof repository
git clone https://github.com/epoch-research/LeanOpenProblems-results
cd LeanOpenProblems-results
git checkout fd09021e79869476ef83cda231312f1a2a89c8d7

# Navigate to the submission
cd runs/oeis-open-lite-fable51-wm0v421z5ygi8f6b/oeis_306477_conjecture_1
```

### Step 2: Check the Lean version

```bash
cat lean-toolchain
# Expected: leanprover/lean4:v4.27.0 (or similar)
```

Record actual output here:
```
[PENDING — paste lean-toolchain content here]
```

### Step 3: Build the proof

```bash
lake build
```

Record result:
```
[PENDING — paste build output here]
Build status: [ ] PASS  [ ] FAIL
```

### Step 4: Run `#print axioms`

Add the following to `Submission/Spec.lean` or a new file in the project:

```lean
#print axioms oeis_306477_conjecture_1.disproof
```

Record the complete output here:
```
[PENDING — paste #print axioms output here]
```

### Step 5: Check for `sorryAx`

```bash
# Search for sorry in the proof files
grep -rn "sorry" Submission/
```

Record result:
```
[PENDING — paste grep output here]
sorryAx present: [ ] YES  [ ] NO
```

### Step 6: Check for `native_decide`

```bash
grep -rn "native_decide" Submission/
```

Record result:
```
[PENDING — paste grep output here]
native_decide used: [ ] YES  [ ] NO
```

### Step 7: Verify counterexample value

```lean
-- In Lean, verify the counterexample value
#eval D2468.n0
-- Expected: 896315812331399
```

Record result:
```
[PENDING — paste #eval output here]
n0 value confirmed: [ ] YES  [ ] NO
```

---

## Audit Summary Table

| Check | Expected | Actual | Status |
|-------|----------|--------|--------|
| Lean version | 4.27.0 | [PENDING] | ⏳ |
| Build result | PASS | [PENDING] | ⏳ |
| `#print axioms` output | Standard axioms only | [PENDING] | ⏳ |
| `sorryAx` present | NO | [PENDING] | ⏳ |
| `native_decide` used | NO (preferred) | [PENDING] | ⏳ |
| Counterexample $n_0$ | 896315812331399 | [PENDING] | ⏳ |
| Bridge theorem established | YES | [PENDING] | ⏳ |

**Overall audit status: PENDING**

---

## Expected `#print axioms` Output

For a clean Lean proof using only standard axioms, the expected output is:

```
oeis_306477_conjecture_1.disproof depends on axioms:
  propext
  Classical.choice
  Quot.sound
```

Any additional axioms (especially `sorryAx` or custom axioms) would require explanation.

---

## If `native_decide` Is Found

If `native_decide` is used in the proof, note that:

- `native_decide` compiles the decision procedure to native code and runs it outside the Lean kernel.
- It is faster than `decide` but does not provide the same kernel-level guarantee.
- Its use should be documented explicitly.
- The proof would still be considered a strong computational verification, but the `[FORMAL]` label should note the use of `native_decide`.

---

## After Completing the Audit

Once all checks are complete:

1. Fill in the actual values in the table above.
2. Update [FORMAL_AUDIT.md](FORMAL_AUDIT.md) with the results.
3. Update [RESEARCH_STATUS.md](RESEARCH_STATUS.md) to reflect the audit outcome.
4. If all checks pass, update the `[FORMAL]` status entries in RESEARCH_STATUS.md.
5. If any check fails, document the issue and determine the appropriate evidence level.

---

## Audit Completion Record

```
Audit performed by: [NAME]
Date: [YYYY-MM-DD]
Lean environment: [local / CI / other]
Lean version used: [VERSION]
Mathlib version used: [VERSION]
Result: [ ] PASS  [ ] FAIL  [ ] PARTIAL
Notes: [any additional observations]
```

---

## References

- External proof: [epoch-research/LeanOpenProblems-results, commit fd09021](https://github.com/epoch-research/LeanOpenProblems-results/blob/fd09021e79869476ef83cda231312f1a2a89c8d7/runs/oeis-open-lite-fable51-wm0v421z5ygi8f6b/oeis_306477_conjecture_1/Submission/Spec.lean)
- FORMAL_AUDIT.md: [FORMAL_AUDIT.md](FORMAL_AUDIT.md)
- TOOLCHAIN_COMPATIBILITY.md: [TOOLCHAIN_COMPATIBILITY.md](TOOLCHAIN_COMPATIBILITY.md)
- RESEARCH_STATUS.md: [RESEARCH_STATUS.md](RESEARCH_STATUS.md)
