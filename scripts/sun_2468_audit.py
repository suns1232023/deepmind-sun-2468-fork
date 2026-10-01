# Comprehensive Audit Report
## deepmind-sun-2468-fork — Sun (2,4,6,8) Formal Conjectures Fork

**Audit date:** 2026-10-01  
**Repository:** https://github.com/suns1232023/deepmind-sun-2468-fork/tree/main  
**Auditor:** Office Agent  
**Scope:** Directory structure, Lean files, mathematical claims, documentation consistency

---

## A. Executive Summary

**Assessment: Significant restructuring recommended**

The repository contains valuable research but has several consistency problems that must be resolved before the fork can be considered stable. The most critical issues are:

1. **Two conflicting Lean files** define the same conjecture with different variable domains, different categories, and different theorem names.
2. **The real fiber value in README is numerically incorrect** by approximately 293 units.
3. **Several root-level files are misplaced** (BridgeTheorem.lean, AXIOM_AUDIT_TEMPLATE.md, TOOLCHAIN_COMPATIBILITY.md, "Formal Proof Audit — A306477 Disproof.md").
4. **A306477.lean contains theorems with `sorry`** that are labelled `@[category research established]` — this is a category misuse.
5. **The bridge theorem between the two A306477 definitions is not yet established.**

None of these issues affect the underlying mathematics. They are documentation, formalization, and structural consistency problems.

---

## B. Directory Audit

| Path | Purpose | Assessment | Recommendation |
|------|---------|------------|----------------|
| `FormalConjectures/OEIS/306477.lean` | Primary A306477 Lean statement | ✅ Correct location | Keep; fix sorry/category |
| `FormalConjectures/OEIS/A306477.lean` | Secondary A306477 file (fork-added) | ❌ Conflicts with 306477.lean | Rename or merge; resolve conflict |
| `BridgeTheorem.lean` | Bridge theorem between two A definitions | ❌ Wrong location (root) | Move to `FormalConjectures/OEIS/` or `FormalConjecturesForMathlib/` |
| `AXIOM_AUDIT_TEMPLATE.md` | Audit template for external proof | ❌ Wrong location (root) | Move to `docs/` or `research/` |
| `TOOLCHAIN_COMPATIBILITY.md` | Lean version analysis | ❌ Wrong location (root) | Move to `docs/` |
| `Formal Proof Audit — A306477 Disproof.md` | Formal audit record | ❌ Filename has spaces and em-dash | Rename to `FORMAL_AUDIT.md`; move to `docs/` |
| `RESEARCH_STATUS.md` | Evidence status register | ✅ Acceptable at root | Keep |
| `AGENTS.md` | AI agent guidelines | ✅ Acceptable at root | Keep |
| `CONTRIBUTING.md` | Contribution guidelines | ✅ Acceptable at root | Keep |
| `README.md` | Main documentation | ✅ Acceptable at root | Fix mathematical errors (see §E) |
| `scripts/sun_2468_audit.py` | Computational audit script | ✅ Correct location | Keep |
| `FormalConjectures/` | Upstream conjecture statements | ✅ Correct | Keep upstream files unchanged |
| `FormalConjecturesForMathlib/` | Mathlib-upstreamable code | ✅ Correct | Keep |

---

## C. Lean Audit

### C.1 FormalConjectures/OEIS/306477.lean

| Field | Value |
|-------|-------|
| Namespace | `OeisA306477` |
| Definition | `def A (n : ℕ) : Prop := ∃ w x y z : ℕ, n = C(w+2,2)+C(x+3,4)+C(y+5,6)+C(z+7,8)` |
| Variable domain | `w, x, y, z ≥ 0` (shifted non-negative form) |
| Main theorem | `theorem conjecture : ¬ ∀ n : ℕ, 0 < n → A n` |
| Category | `@[category research solved]` |
| Formal proof | Links to epoch-research/LeanOpenProblems-results commit fd09021 |
| Proof body | `sorry` |
| Status | Statement formalized; proof body is `sorry`; external proof linked |

**Issues:**
- The `sorry` in the proof body means this is NOT a kernel-checked proof in this fork.
- The `formal_proof` annotation links to an external proof that uses a different definition (`A306477 : ℕ` counting function vs `A : Prop` existential).
- The bridge theorem connecting these two definitions is not established.

**Assessment:** The statement formalization is correct. The `research solved` category is justified by the external proof, but the bridge theorem gap must be documented.

---

### C.2 FormalConjectures/OEIS/A306477.lean (fork-added)

| Field | Value |
|-------|-------|
| Namespace | `Sun2468Conjecture` |
| Main theorem | `theorem sun_2468_conjecture (n : ℕ) (hn : n > 0) : ∃ w x y z, w≥2 ∧ x≥2 ∧ y≥2 ∧ z≥2 ∧ n = C(w,2)+C(x,4)+C(y,6)+C(z,8)` |
| Variable domain | `w, x, y, z ≥ 2` (original form) |
| Category | `@[category research open]` |
| Proof body | `sorry` |

**Additional theorems in this file:**

| Theorem | Category | Status | Issues |
|---------|----------|--------|--------|
| `phi_complex_surjective` | `research established` | `sorry` | **CRITICAL: `sorry` + `established` is contradictory** |
| `negative_n_star_complex_solution` | `research established` | `trivial` | Proves `True`, not the actual identity |
| `n_star_lattice_absence_paradox` | `research open` | `sorry` | Acceptable |

**Critical conflicts with 306477.lean:**

| Dimension | 306477.lean | A306477.lean |
|-----------|-------------|--------------|
| Variable domain | `w,x,y,z ≥ 0` | `w,x,y,z ≥ 2` |
| Category | `research solved` | `research open` |
| Theorem name | `conjecture` | `sun_2468_conjecture` |
| Namespace | `OeisA306477` | `Sun2468Conjecture` |

**Assessment:** This file creates a direct conflict with 306477.lean. The two files must be reconciled. The `phi_complex_surjective` theorem uses `@[category research established]` with `sorry` — this is a category misuse and must be corrected.

---

### C.3 BridgeTheorem.lean (root — misplaced)

| Field | Value |
|-------|-------|
| Location | Root (incorrect) |
| Purpose | Bridge between `A : Prop` and `A306477 : ℕ` |
| Key theorem | `isRepresentable_iff_count_pos` |
| Status | `sorry` |

**Assessment:** Correct mathematical content; wrong location. Should be in `FormalConjectures/OEIS/` or `FormalConjecturesForMathlib/NumberTheory/`.

---

## D. Candidate n* Audit

$$n^* = 896{,}315{,}812{,}331{,}399$$

| Occurrence | Claim | Verification | Status |
|------------|-------|--------------|--------|
| 306477.lean | `n = 896315812331399` is counterexample | Consistent with external proof | ✅ |
| A306477.lean | `n_star_lattice_absence_paradox` with `sorry` | Not proved in this fork | ⚠️ |
| README | `R_Z(n*) = 0` computationally | V23.4 audit, 2,818,953,028 triples | ✅ `[COMP]` |
| README | External Lean proof establishes `R_Z(n*) = 0` | External proof exists; bridge theorem pending | ⚠️ `[FORMAL]` pending |
| RESEARCH_STATUS.md | `[FORMAL]` pending bridge theorem audit | Correctly documented | ✅ |

**Assessment:** The counterexample value is consistent throughout. The distinction between `[COMP]` and `[FORMAL]` is correctly documented in RESEARCH_STATUS.md.

---

## E. Real Fiber Claim Audit

**README claims:** $(w, x, y, z) = (42{,}339{,}774.4,\ 4,\ 6,\ 8)$ is a real solution.

**Independent verification:**

Using the formula $C(w,2) + C(x,4) + C(y,6) + C(z,8) = n^*$ with $x=4, y=6, z=8$:

$$C(4,4) + C(6,6) + C(8,8) = 1 + 1 + 1 = 3$$

$$C(w,2) = n^* - 3 = 896{,}315{,}812{,}331{,}396$$

$$w = \frac{1 + \sqrt{1 + 8 \times 896{,}315{,}812{,}331{,}396}}{2} \approx 42{,}339{,}481.18$$

**Finding: The README value $w = 42{,}339{,}774.4$ is INCORRECT. The correct value is $w \approx 42{,}339{,}481.2$, a discrepancy of approximately 293 units.**

The value $42{,}339{,}774.4$ does not satisfy the equation under any standard interpretation of the formula.

**Recommendation:** Replace with the correct value $w \approx 42{,}339{,}481.2$ and note that this is a decimal approximation, not an exact integer.

---

## F. Complex Fiber Claim Audit

**README claims:** For $-n^*$, the complex solution at $(x,y,z)=(0,0,0)$ is:

$$w = \frac{1 + i\sqrt{7{,}170{,}526{,}498{,}651{,}191}}{2}$$

**Independent verification:**

Setting $C(w,2) = -n^*$ (original form, $x=y=z=0$ gives $C(0,4)=C(0,6)=C(0,8)=0$):

$$\frac{w(w-1)}{2} = -n^* \implies w^2 - w + 2n^* = 0$$

$$w = \frac{1 \pm \sqrt{1 - 8n^*}}{2} = \frac{1 \pm i\sqrt{8n^* - 1}}{2}$$

$$8n^* - 1 = 8 \times 896{,}315{,}812{,}331{,}399 - 1 = 7{,}170{,}526{,}498{,}651{,}191 \checkmark$$

**Finding: The complex solution formula is CORRECT.** The sqrt argument $7{,}170{,}526{,}498{,}651{,}191 = 8n^* - 1$ is verified.

**However:** The Lean theorem `negative_n_star_complex_solution` in A306477.lean proves only `True` (via `trivial`), not the actual identity. This is a placeholder, not a proof.

---

## G. Surjectivity of $\Phi_{\mathbb{C}}$ Audit

**A306477.lean claims:** `@[category research established]` for `phi_complex_surjective`.

**Finding:** The theorem body is `sorry`. Using `@[category research established]` with `sorry` is a **category misuse** — it implies the result is established when it is not proved in Lean.

**Mathematical status:** Surjectivity of $\Phi_{\mathbb{C}}: \mathbb{C}^4 \to \mathbb{C}$ is mathematically straightforward (the map is a non-constant polynomial, hence surjective by the fundamental theorem of algebra applied to one variable). It is `[EST]` — mathematically established by derivation — but not `[FORMAL]` in this fork.

**Recommendation:** Change category to `@[category research open]` or remove the theorem until it is actually proved. Do not use `research established` with `sorry`.

---

## H. DLO Audit

**Finding:** DLO (Distributed Local Obstruction) appears in:
- README (described as a framework)
- A306477.lean (`n_star_lattice_absence_paradox` with `sorry`)
- RESEARCH_STATUS.md (correctly labelled `[COMP]` for certificates, `[OPEN]` for global theorem)

**Assessment:** DLO is correctly classified in RESEARCH_STATUS.md. The Lean theorem `n_star_lattice_absence_paradox` has `sorry` and is correctly labelled `@[category research open]`. No overclaiming detected in the formal files.

---

## I. Conflicts with Other Lean Formalizations

| Formalization | File | Statement | Domain | Category | Relation |
|---------------|------|-----------|--------|----------|----------|
| Upstream (original) | `FormalConjectures/OEIS/306477.lean` (pre-fork) | `∀ n>0, A n` (positive direction) | `w,x,y,z ≥ 0` | `research open` | Original statement |
| Fork (306477.lean) | `FormalConjectures/OEIS/306477.lean` | `¬ ∀ n>0, A n` (negation) | `w,x,y,z ≥ 0` | `research solved` | Disproof of original |
| Fork (A306477.lean) | `FormalConjectures/OEIS/A306477.lean` | `∀ n>0, ∃ w,x,y,z ≥ 2, ...` | `w,x,y,z ≥ 2` | `research open` | **CONFLICTS with 306477.lean** |

**The two fork files are not contradictory mathematically** (the shifted and original forms are equivalent), but they are **inconsistent in category** (`research solved` vs `research open`) and create confusion about which is the canonical formulation.

---

## J. README Audit (Selected Claims)

| Claim | Classification | Assessment |
|-------|---------------|------------|
| "formally established as surjective" | `[EST]` | ⚠️ Should be "mathematically established" — not Lean-formal |
| "real non-integer solution $(42{,}339{,}774.4, 4, 6, 8)$" | `[NUM]` | ❌ **INCORRECT value** — correct is $w \approx 42{,}339{,}481.2$ |
| "complex solution $w = (1+i\sqrt{7{,}170{,}526{,}498{,}651{,}191})/2$" | `[EST]` | ✅ Correct |
| "$R_{\mathbb{Z}}(n^*) = 0$" | `[COMP]` | ✅ Correctly labelled |
| "computational counterexample candidate" | `[COMP]` | ✅ Appropriately conservative |
| "DLO local certificates" | `[COMP]` | ✅ Correctly labelled |
| "not automatically a global proof" | — | ✅ Correct disclaimer |
| "This is not an official Google product" | — | ✅ Present |
| "independent fork" | — | ✅ Present |

---

## K. CONTRIBUTING.md Audit

**Finding:** CONTRIBUTING.md is well-structured with Part I (upstream rules) and Part II (Sun extension rules). No major issues found.

**Minor issues:**
- The Sun-specific section references `@[category research established]` as a valid category. Given the misuse in A306477.lean, this should be clarified.
- The DLO section correctly states "not automatically a global proof."

---

## L. Reproducibility Audit

**scripts/sun_2468_audit.py:** Only 23 lines — appears to be a stub or partial script. Does not provide full reproducibility for the V23.4 audit (2,818,953,028 triples).

**Recommendation:** Either expand the script to be fully reproducible, or add a README in `scripts/` pointing to the full computational audit repository (sun-2468-conjecture).

---

## M. Duplicate/Conflicting Sources of Truth

| Concept | Canonical location | Conflict |
|---------|-------------------|---------|
| A306477 definition | `306477.lean` (shifted form) | `A306477.lean` uses original form |
| Conjecture category | `306477.lean` (research solved) | `A306477.lean` (research open) |
| Real fiber value | README ($w = 42{,}339{,}774.4$) | **Incorrect** — correct is $w \approx 42{,}339{,}481.2$ |
| Evidence status | `RESEARCH_STATUS.md` | Consistent with `FORMAL_AUDIT.md` |
| Bridge theorem | `BridgeTheorem.lean` (root) | Should be in `FormalConjectures/OEIS/` |

---

## N. Priority Recommendations

### P0 — Must fix before any freeze

1. **Resolve the two-file conflict:** Either delete `A306477.lean` and merge its content into `306477.lean`, or clearly separate them with different purposes and consistent categories.
2. **Fix the real fiber value in README:** Change $w = 42{,}339{,}774.4$ to $w \approx 42{,}339{,}481.2$.
3. **Fix `phi_complex_surjective` category:** Change from `@[category research established]` to `@[category research open]` (since it has `sorry`).
4. **Move misplaced root files:** `BridgeTheorem.lean` → `FormalConjectures/OEIS/`; `AXIOM_AUDIT_TEMPLATE.md`, `TOOLCHAIN_COMPATIBILITY.md`, `Formal Proof Audit — A306477 Disproof.md` → `docs/`.
5. **Rename the file with spaces:** `Formal Proof Audit — A306477 Disproof.md` → `FORMAL_AUDIT.md`.

### P1 — Should fix before publication

6. **Establish bridge theorem** `isRepresentable_iff_count_pos` in Lean.
7. **Expand `scripts/sun_2468_audit.py`** or add a pointer to the full computational audit.
8. **Change "formally established" to "mathematically established"** in README for surjectivity claim.
9. **Fix `negative_n_star_complex_solution`** to prove the actual identity, not `True`.

### P2 — Recommended improvements

10. Create a `docs/` directory for audit and compatibility documents.
11. Add `#print axioms` output to `FORMAL_AUDIT.md` once available.
12. Verify toolchain compatibility (Lean 4.33.1 vs 4.27.0).

---

## O. Summary Table

| Issue | Severity | File(s) | Type |
|-------|----------|---------|------|
| Two conflicting A306477 Lean files | **Critical** | 306477.lean, A306477.lean | Formalization |
| Real fiber value incorrect ($w$ off by ~293) | **Critical** | README.md | Mathematical |
| `phi_complex_surjective` has `sorry` + `established` | **Critical** | A306477.lean | Category misuse |
| BridgeTheorem.lean at root | **Major** | BridgeTheorem.lean | Structure |
| Filename with spaces and em-dash | **Major** | "Formal Proof Audit..." | Structure |
| AXIOM_AUDIT_TEMPLATE.md at root | **Minor** | AXIOM_AUDIT_TEMPLATE.md | Structure |
| TOOLCHAIN_COMPATIBILITY.md at root | **Minor** | TOOLCHAIN_COMPATIBILITY.md | Structure |
| Bridge theorem not established | **Major** | BridgeTheorem.lean | Formalization |
| `negative_n_star_complex_solution` proves `True` | **Major** | A306477.lean | Formalization |
| scripts/sun_2468_audit.py is a stub | **Minor** | scripts/ | Reproducibility |
| "formally established" for surjectivity | **Minor** | README.md | Terminology |

---

## P. Verified Correct Claims

The following claims were independently verified and are correct:

- $n^* = 896{,}315{,}812{,}331{,}399$ (consistent throughout)
- Complex solution sqrt argument: $8n^* - 1 = 7{,}170{,}526{,}498{,}651{,}191$ ✅
- $C(4,4) + C(6,6) + C(8,8) = 3$ ✅
- The shifted form ($w,x,y,z \geq 0$) and original form ($w,x,y,z \geq 2$) are mathematically equivalent ✅
- RESEARCH_STATUS.md evidence levels are internally consistent ✅
- DLO is correctly classified as `[COMP]` for certificates, `[OPEN]` for global theorem ✅
- The fork disclaimer ("not an official Google product") is present ✅
