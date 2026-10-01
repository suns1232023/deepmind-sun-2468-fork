# Research Status

## Purpose

This document records the evidentiary status of all results in the Sun (2,4,6,8) research extension. It is the authoritative reference for evidence levels. README.md provides a summary for general readers; this document provides the full record.

**Last updated:** 2026-10-01

---

## Evidence Levels

| Label | Definition | Lean required? | Scope |
|-------|-----------|----------------|-------|
| `[FORMAL]` | Lean 4 kernel-checked proof. `#print axioms` confirms no unexpected axioms. No `sorry`. | Yes | As stated in theorem |
| `[EST]` | Explicit mathematical derivation. Proof steps are written out and checkable by a mathematician. | Not necessarily | As stated in derivation |
| `[COMP]` | Computationally verified within an explicitly stated finite domain. Reproducible script provided. | No | Stated finite domain only |
| `[NUM]` | Numerical experiment, heuristic, or approximate evidence. | No | As stated |
| `[OPEN]` | Open question. No proof or computational verification established. | — | — |

### Critical distinctions

- `[EST]` does **not** imply `[FORMAL]`.
- `[COMP]` is **always domain-bounded**. A computational absence result is not a global theorem.
- A local obstruction is **not** a global obstruction unless the logical implication has been established.
- A complex or real solution is **not** an integer representation.
- `lake build` success does **not** imply a theorem is proved.

---

## The Sun (2,4,6,8) Conjecture

**Conjecture (Sun, 2019).** Every positive integer $n$ can be written as

$$n = \binom{w}{2} + \binom{x}{4} + \binom{y}{6} + \binom{z}{8}, \qquad w,x,y,z \geq 0.$$

**Upstream Lean formulation (OEIS A306477, PR #1570):**

$$\forall n > 0,\; \exists\, w,x,y,z \in \mathbb{N},\; \binom{w+2}{2} + \binom{x+3}{4} + \binom{y+5}{6} + \binom{z+7}{8} = n.$$

**Reference:** OEIS [A306477](https://oeis.org/A306477).

---

## Current Results

### 1. Algebraic Structure

| Result | Status | Evidence | Scope |
|--------|--------|----------|-------|
| Definition of $\Phi: \mathbb{Z}_{\geq 0}^4 \to \mathbb{Z}_{>0}$ | `[FORMAL]` | Lean 4 definition | All non-negative integers |
| Polynomial form of $\Phi$ | `[EST]` | Explicit computation | All non-negative integers |

---

### 2. Complex Fiber

| Result | Status | Evidence | Scope |
|--------|--------|----------|-------|
| Surjectivity of $\Phi_{\mathbb{C}}: \mathbb{C}^4 \to \mathbb{C}$ | `[EST]` | Explicit derivation | $\mathbb{C}^4 \to \mathbb{C}$ |
| Complex fiber $\mathcal{F}_n^{\mathbb{C}}$ non-empty for all $n$ | `[EST]` | Follows from surjectivity | All $n$ |
| Complex dimension at regular points | `[EST]` | Regular value theorem | Regular points of level set |

**Important.** Non-emptiness of $\mathcal{F}_n^{\mathbb{C}}$ does **not** imply non-emptiness of $\mathcal{F}_n^{\mathbb{Z}}$.

---

### 3. Real Fiber

| Result | Status | Evidence | Scope |
|--------|--------|----------|-------|
| Real fiber non-empty for sufficiently large $n$ | `[EST]` | Continuity argument | Sufficiently large $n$ |
| Explicit real solution for $n^*$ | `[EST]` | Explicit construction | $n^*$ only |

**Important.** Non-emptiness of $\mathcal{F}_n^{\mathbb{R}}$ does **not** imply non-emptiness of $\mathcal{F}_n^{\mathbb{Z}}$.

---

### 4. Integer Lattice — Counterexample

$$n^* = 896{,}315{,}812{,}331{,}399$$

| Claim | Evidence | Status |
|-------|----------|--------|
| Original A306477 statement | Lean formalization (upstream PR #1570) | `[FORMAL]` statement |
| $n^*$ has no admissible representation: computational search | V23.4 exhaustive audit, 2,818,953,028 triples | `[COMP]` |
| $n^*$ has no admissible representation: Lean kernel proof | External Lean disproof (epoch-research, commit fd09021) | `[FORMAL]` — pending bridge theorem audit |
| A306477 is false | External Lean disproof | `[FORMAL]` — pending bridge theorem audit |
| Bridge theorem `A_iff_count_pos` | Not yet established in this fork | `[OPEN]` |
| `#print axioms` recorded for external disproof | Not yet performed | `[OPEN]` |
| Independent verification of V23.4 audit | Not yet performed | `[OPEN]` |

**Note on `[FORMAL]` status.** The external Lean disproof (epoch-research/LeanOpenProblems-results, commit fd09021) uses a counting-function definition `A306477 : ℕ`, while this fork uses an existential proposition `A : Prop`. These are mathematically equivalent, but a formal bridge theorem has not yet been established in this fork. See [FORMAL_AUDIT.md](FORMAL_AUDIT.md) for the full audit checklist.

**Note on toolchain.** This fork uses Lean 4.33.1; the external disproof was developed with Lean 4.27.0 / Mathlib v4.27.0. Compatibility has not yet been verified.

---

### 5. Distributed Local Obstruction (DLO)

| Result | Status | Evidence | Scope |
|--------|--------|----------|-------|
| Local obstruction certificates at specified primes | `[COMP]` | Computational certificates | Stated primes |
| DLO framework definition | `[EST]` | Mathematical derivation | As defined |
| Global non-existence from DLO | `[OPEN]` | Not established | — |

**Important.** Individual local obstruction certificates do not constitute a global proof.

---

### 6. Geometric Distinction

| Result | Status | Evidence | Scope |
|--------|--------|----------|-------|
| $\mathcal{F}_n^{\mathbb{C}} \neq \emptyset \not\Rightarrow \mathcal{F}_n^{\mathbb{Z}} \neq \emptyset$ | `[EST]` | Explicit example | General |
| $\mathcal{F}_n^{\mathbb{R}} \neq \emptyset \not\Rightarrow \mathcal{F}_n^{\mathbb{Z}} \neq \emptyset$ | `[EST]` | Explicit example | General |
| Continuous solution $\not\Rightarrow$ integer representation | `[EST]` | Mathematical argument | General |

---

### 7. Open Problems

| Problem | Status |
|---------|--------|
| Bridge theorem `A_iff_count_pos` (Prop ↔ count > 0) | `[OPEN]` |
| Analytic proof that $R(n^*) = 0$, independent of computation | `[OPEN]` |
| Second counterexample search | `[OPEN]` |
| DLO global theorem | `[OPEN]` |
| `#print axioms` audit of external disproof | `[OPEN]` |
| Toolchain compatibility verification | `[OPEN]` |

---

## Evidence Chain

```
Conjecture: every n is representable
        |
        | [FORMAL] statement (upstream PR #1570)
        v
Lean formalization of A306477
        |
        | geometric analysis
        v
Complex surjectivity [EST]
Real solution exists [EST]
        |
        | does NOT imply
        v
Integer representation exists
        |
        | computational search
        v
R(n*) = 0 within stated domain [COMP]
        |
        | external Lean kernel proof
        v
R(n*) = 0 formally [FORMAL] — pending bridge theorem audit
        |
        | therefore
        v
A306477 is false [FORMAL] — pending bridge theorem audit
        |
        | remains open
        v
Analytic explanation of why n* has no representation [OPEN]
Second counterexample search [OPEN]
```

---

## What Has Not Been Established

| Claim | Status | Reason |
|-------|--------|--------|
| Bridge theorem `A_iff_count_pos` | `[OPEN]` | Not yet proved in this fork |
| `#print axioms` clean for external disproof | `[OPEN]` | Not yet recorded |
| Toolchain compatibility (4.33.1 vs 4.27.0) | `[OPEN]` | Not yet verified |
| Analytic proof that $R(n^*) = 0$ | `[OPEN]` | Independent of computation |
| Second counterexample | `[OPEN]` | Search ongoing |
| DLO global theorem | `[OPEN]` | Local-to-global implication not established |

---

## Relationship to the Upstream A306477 Formalization

The upstream Formal Conjectures repository (google-deepmind/formal-conjectures, PR #1570) formalizes the statement of the Sun (2,4,6,8) conjecture as a Lean proposition with `@[category research open]`.

This fork has updated the category to `@[category research solved]` and added a `formal_proof` annotation linking to the external disproof. This update reflects the existence of an external Lean disproof, but is conditional on the bridge theorem audit being completed (see [FORMAL_AUDIT.md](FORMAL_AUDIT.md)).

### Variable shift note

The Lean formulation uses the shifted non-negative-variable form

$$\binom{w+2}{2}+\binom{x+3}{4}+\binom{y+5}{6}+\binom{z+7}{8}, \qquad w,x,y,z\in\mathbb{N},$$

which is equivalent to the original $w,x,y,z \geq 2$ formulation under the corresponding variable shift.

---

## Three-Layer Research Structure

**Layer 1 — Formal statement (DeepMind / upstream)**

$$C: \quad \forall n>0,\; \mathcal{F}_n^{\mathbb{Z}} \neq \varnothing$$

Formalized as a Lean statement. An external Lean disproof of $\neg C$ has been reported.

**Layer 2 — Fiber geometry (this fork)**

Studies the continuous algebraic structure:

$$\Phi_{\mathbb{C}}: \mathbb{C}^4 \to \mathbb{C}, \qquad \mathcal{F}_n^{\mathbb{C}} = \{x \in \mathbb{C}^4 : \Phi(x) = n\}.$$

**Layer 3 — Integer counterexample**

$$\mathcal{F}_n^{\mathbb{Z}} = \mathcal{F}_n^{\mathbb{R}} \cap \mathbb{Z}_{\mathrm{adm}}^4.$$

The conjecture requires $\mathcal{F}_n^{\mathbb{Z}} \neq \varnothing$ for all $n > 0$.

Research chain:

$$\text{formal statement} \to \text{geometric analysis} \to \text{computational discovery} \to \text{formal disproof (pending bridge audit)}$$

---

## Versioning

| Version | Date | Change |
|---------|------|--------|
| V23.4 | 2026-08-28 | Final computational audit of $n^*$ |
| V13.1 | 2026 | Triangular witness trajectories framework |

---

## References

- OEIS A306477: [https://oeis.org/A306477](https://oeis.org/A306477)
- Zenodo archive (V23.4): [10.5281/zenodo.22139197](https://doi.org/10.5281/zenodo.22139197)
- OSF Hub: [10.17605/OSF.IO/CAQXH](https://doi.org/10.17605/OSF.IO/CAQXH)
- Scott Sun ORCID: [0009-0002-1095-6228](https://orcid.org/0009-0002-1095-6228)
- Upstream PR #1570: [github.com/google-deepmind/formal-conjectures/pull/1570](https://github.com/google-deepmind/formal-conjectures/pull/1570)
- External disproof: [epoch-research/LeanOpenProblems-results, commit fd09021](https://github.com/epoch-research/LeanOpenProblems-results/blob/fd09021e79869476ef83cda231312f1a2a89c8d7/runs/oeis-open-lite-fable51-wm0v421z5ygi8f6b/oeis_306477_conjecture_1/Submission/Spec.lean)
- Formal Audit: [FORMAL_AUDIT.md](FORMAL_AUDIT.md)

---

## Maintenance

This document should be updated whenever:

- A result's evidence level changes.
- The bridge theorem audit is completed.
- A new result is added to the research programme.
- A computational audit is updated or independently verified.

The evidence levels in this document take precedence over any summary in README.md in case of discrepancy.

