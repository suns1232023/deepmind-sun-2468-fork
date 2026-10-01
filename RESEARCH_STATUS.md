# Research Status
 
## Purpose
 
This document records the evidentiary status of all results in the Sun (2,4,6,8) research extension. It is intended for mathematical reviewers and provides a precise account of what has been established, at what level of evidence, and within what scope.
 
This document is the authoritative reference for evidence levels. README.md provides a summary for general readers; this document provides the full record.
 
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
 
- `[EST]` does **not** imply `[FORMAL]`. An established result has an explicit derivation but may not have a Lean proof.
- `[COMP]` is **always domain-bounded**. A computational absence result is not a global theorem.
- A local obstruction is **not** a global obstruction unless the logical implication has been established.
- A complex or real solution is **not** an integer representation.
 
---
 
## The Sun (2,4,6,8) Conjecture
 
**Conjecture.** Every positive integer $n$ can be written as
 
$$n = \binom{w}{2} + \binom{x}{4} + \binom{y}{6} + \binom{z}{8}, \qquad w,x,y,z \geq 0.$$
 
**Status:** `[OPEN]` — The conjecture is unresolved. No proof or disproof has been established.
 
**Reference:** OEIS [A306477](https://oeis.org/A306477).
 
---
 
## Current Results
 
### 1. Algebraic Structure
 
| Result | Status | Evidence | Scope |
|--------|--------|----------|-------|
| Definition of $\Phi: \mathbb{Z}_{\geq 0}^4 	o \mathbb{Z}_{>0}$ | `[FORMAL]` | Lean 4 definition | All non-negative integers |
| Polynomial form of $\Phi$ | `[EST]` | Explicit computation | All non-negative integers |
 
---
 
### 2. Complex Fiber
 
| Result | Status | Evidence | Scope |
|--------|--------|----------|-------|
| Surjectivity of $\Phi_{\mathbb{C}}: \mathbb{C}^4 	o \mathbb{C}$ | `[EST]` | Explicit derivation | $\mathbb{C}^4 	o \mathbb{C}$ |
| Complex fiber $\mathcal{F}_n^{\mathbb{C}}$ is non-empty for all $n \in \mathbb{C}$ | `[EST]` | Follows from surjectivity | All $n$ |
| Complex dimension of $\mathcal{F}_n^{\mathbb{C}}$ at regular points | `[EST]` | Regular value theorem | Regular points of level set |
 
**Scope note.** The complex dimension result applies at regular (non-singular) points of the level set. Singular points require separate analysis.
 
**Important.** Non-emptiness of $\mathcal{F}_n^{\mathbb{C}}$ does **not** imply non-emptiness of $\mathcal{F}_n^{\mathbb{Z}}$.
 
---
 
### 3. Real Fiber
 
| Result | Status | Evidence | Scope |
|--------|--------|----------|-------|
| Real fiber $\mathcal{F}_n^{\mathbb{R}}$ is non-empty for sufficiently large $n$ | `[EST]` | Continuity argument | Sufficiently large $n$ |
| Explicit real solution exists | `[EST]` | Explicit construction | Stated $n$ |
 
**Important.** Non-emptiness of $\mathcal{F}_n^{\mathbb{R}}$ does **not** imply non-emptiness of $\mathcal{F}_n^{\mathbb{Z}}$.
 
---
 
### 4. Integer Lattice — Candidate Counterexample
 
$$n^* = 896{,}315{,}812{,}331{,}399$$
 
| Result | Status | Evidence | Scope |
|--------|--------|----------|-------|
| No admissible representation of $n^*$ found | `[COMP]` | V23.4 computational audit | Stated finite search domain |
| Search domain completeness | `[COMP]` | Explicit bound derivation | Stated bounds |
| Exact integer arithmetic used | `[COMP]` | Audit specification | All enumerated triples |
| $2{,}818{,}953{,}028$ triples enumerated | `[COMP]` | Audit log | Stated domain |
| Independent verification | `[OPEN]` | Not yet performed | — |
| Global non-existence theorem | `[OPEN]` | Not established | — |
 
**Classification.** $n^*$ is a **computational counterexample candidate**. It is not a confirmed counterexample.
 
**Domain statement.** The computational audit operates within explicit finite bounds on $w$, $x$, $y$, $z$ derived from the conjecture structure. The result $R_{\mathbb{Z}}(n^*) = 0$ holds within this stated domain. It should not be interpreted as a global non-existence theorem unless a domain-completeness argument has been established and independently verified.
 
---
 
### 5. Distributed Local Obstruction (DLO)
 
| Result | Status | Evidence | Scope |
|--------|--------|----------|-------|
| Local obstruction certificates at specified primes | `[COMP]` | Computational certificates | Stated primes |
| DLO framework definition | `[EST]` | Mathematical derivation | As defined |
| Global non-existence from DLO | `[OPEN]` | Not established | — |
 
**Important.** Individual local obstruction certificates do not constitute a global proof. The logical implication from a collection of local certificates to global non-existence must be established separately.
 
---
 
### 6. Geometric Distinction
 
| Result | Status | Evidence | Scope |
|--------|--------|----------|-------|
| $\mathcal{F}_n^{\mathbb{C}} 
eq \emptyset 
ot\Rightarrow \mathcal{F}_n^{\mathbb{Z}} 
eq \emptyset$ | `[EST]` | Explicit example | General |
| $\mathcal{F}_n^{\mathbb{R}} 
eq \emptyset 
ot\Rightarrow \mathcal{F}_n^{\mathbb{Z}} 
eq \emptyset$ | `[EST]` | Explicit example | General |
| Continuous solution $
ot\Rightarrow$ integer representation | `[EST]` | Mathematical argument | General |
 
---
 
## Evidence Chain
 
The following diagram shows the logical structure of the research programme:
 
```
Conjecture: every n is representable
        |
        | [OPEN]
        v
Complex surjectivity [EST]
        |
        | does NOT imply
        v
Real solution exists [EST]
        |
        | does NOT imply
        v
Integer representation exists [OPEN]
        |
        | computational search
        v
R_Z(n*) = 0 within stated domain [COMP]
        |
        | does NOT imply (without domain-completeness argument)
        v
Global non-existence theorem [OPEN]
```
 
---
 
## What Has Not Been Established
 
The following results are **not** established as of the current version:
 
| Claim | Status | Reason |
|-------|--------|--------|
| $n^*$ is a confirmed counterexample | `[OPEN]` | No global non-existence theorem |
| DLO provides a global proof | `[OPEN]` | Local-to-global implication not established |
| The conjecture is false | `[OPEN]` | No proof |
| The conjecture is true | `[OPEN]` | No proof |
| Independent verification of V23.4 audit | `[OPEN]` | Not yet performed |
 
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
 
---
 
## Maintenance
 
This document should be updated whenever:
 
- A result's evidence level changes.
- A new result is added to the research programme.
- A computational audit is updated or independently verified.
- A Lean formalisation is completed or corrected.
 
The evidence levels in this document take precedence over any summary in README.md in case of discrepancy.
 

