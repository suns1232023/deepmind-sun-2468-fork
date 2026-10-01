# Contributing to Formal Conjectures — Sun (2,4,6,8) Research Extension

> **This repository is an independent fork and is not an official Google DeepMind project.**

Thank you for your interest in contributing. This document covers two areas:

- **Part I** — Upstream contribution rules (how to contribute conjecture statements following the upstream format).
- **Part II** — Sun (2,4,6,8) research extension rules (how to contribute to the independent research programme).

---

# Part I: Upstream Contribution Guidelines

These rules follow the [google-deepmind/formal-conjectures](https://github.com/google-deepmind/formal-conjectures) contribution guidelines and should remain compatible with the upstream project.

## Before You Begin

By submitting a contribution, you agree that it may be used under the terms of the [Apache License 2.0](LICENSE) (code) and [Creative Commons Attribution 4.0](LICENSE.md) (mathematical content).

The upstream project requires contributors to sign the [Google Contributor Licence Agreement (CLA)](https://cla.developers.google.com/) before contributions can be accepted upstream. This fork preserves that requirement for contributions intended to remain compatible with the upstream contribution model.

## Ways to Contribute

1. **Add a new conjecture** — a mathematical problem statement formalised in Lean 4.
2. **Improve an existing statement** — clarify, correct, or strengthen a conjecture.
3. **Add a formal proof** — provide a kernel-checked Lean 4 proof of a stated conjecture.
4. **Fix a misformalisation** — correct a statement that does not accurately capture the intended mathematics.
5. **Improve documentation** — clarify comments, references, or metadata.

## Contribution Process

1. Open an issue describing the proposed contribution.
2. Fork the repository and create a branch.
3. Make your changes following the style guidelines below.
4. Run `lake build` to verify the build succeeds.
5. Submit a pull request referencing the issue.

## Getting Started with Lean 4

Install [Lean 4](https://leanprover.github.io/) and [Mathlib](https://leanprover-community.github.io/mathlib4_docs/):

```bash
curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh
lake update
lake build
```

## Choosing a Folder and Category

Place new conjectures in the appropriate subfolder of `FormalConjectures/`. Use the `@[category]` attribute to classify the mathematical area.

## File Structure Conventions

Each conjecture file should contain:

- A module docstring with the conjecture name, source, and AMS classification.
- The `@[category]` attribute.
- The `@[AMS]` attribute with the relevant MSC code.
- The conjecture statement as a `theorem` or `def`.
- If a formal proof exists, the `@[formal_proof]` attribute.

## The `@[formal_proof]` Attribute

A result may only carry `@[formal_proof]` if:

- The Lean kernel accepts the proof without `sorry`.
- No custom axioms beyond Lean's standard axioms are used.
- `#print axioms` confirms the axiom set.

A successful `lake build` alone does not establish that a theorem is proved. Check for `sorryAx` and custom axioms explicitly.

## The `@[AMS]` Attribute

Use the [Mathematics Subject Classification (MSC)](https://mathscinet.ams.org/mathscinet/msc/msc2020.html) code most relevant to the conjecture.

## The `answer()` Convention

For conjectures with a known answer, use `answer(value)` as a placeholder. Do not use `sorry` for the answer itself.

## Style Guidelines

- Use standard Mathlib naming conventions.
- Prefer `theorem` over `lemma` for conjecture statements.
- Include a reference to the original source (paper, OEIS, etc.) in the docstring.
- Keep lines under 100 characters where possible.

## Code Reviews

All pull requests require at least one review. Reviewers will check:

- Mathematical correctness of the statement.
- Lean syntax and style.
- Appropriate use of `@[formal_proof]`, `@[category]`, and `@[AMS]`.
- Absence of `sorry` in formal proofs.

## Managing Labels

Use GitHub labels to indicate the status of issues and pull requests:

- `conjecture` — new conjecture statement
- `formal-proof` — adds or improves a formal proof
- `misformalisation` — corrects an incorrect statement
- `documentation` — documentation improvement

---

# Part II: Sun (2,4,6,8) Research Extension

This section covers contributions to the independent Sun (2,4,6,8) research programme. These rules supplement (and do not replace) the upstream rules above.

## Scope

The Sun extension covers:

- Fiber geometry of the map $\Phi: \mathbb{Z}_{\geq 0}^4 \to \mathbb{Z}_{>0}$
- Complex, real, and integer fiber analysis
- Computational audit of the candidate counterexample $n^* = 896{,}315{,}812{,}331{,}399$
- Distributed Local Obstruction (DLO) framework
- Lean 4 formalisations of fiber geometry results

## Research-Status Labels

All results in the Sun extension must carry an explicit evidence label. See [README.md](README.md) for the full label definitions.

| Label | Meaning |
|-------|---------|
| `[FORMAL]` | Lean 4 kernel-checked proof |
| `[EST]` | Mathematically established by an explicit derivation |
| `[COMP]` | Computationally verified within a stated finite domain |
| `[NUM]` | Numerical or heuristic evidence |
| `[OPEN]` | Open or conjectural |

**`[EST]` does not equal `[FORMAL]`.** Do not use `[EST]` to imply Lean verification unless a `[FORMAL]` label is also present.

## Geometric Distinction

Contributions must respect the following hierarchy:

$$
\mathcal{F}_n^{\mathbb{C}} \neq \emptyset
\quad \not\Rightarrow \quad
\mathcal{F}_n^{\mathbb{R}} \neq \emptyset
\quad \not\Rightarrow \quad
\mathcal{F}_n^{\mathbb{Z}} \neq \emptyset.
$$

Do not conflate:

- Complex solutions with real solutions.
- Real solutions with integer representations.
- Continuous existence with discrete existence.

## Computational Audits

Contributions involving computational results must:

1. State the exact search domain (explicit bounds on all variables).
2. Specify the arithmetic used (exact integer arithmetic is required for the main audit).
3. Provide a reproducible script or program.
4. Label the result `[COMP]` with the domain stated explicitly.
5. Not describe the result as a global theorem unless a domain-completeness argument has been established.

**A computational absence result is not a global non-existence theorem.**

## Distributed Local Obstruction (DLO)

Contributions to the DLO framework must:

1. Specify the prime(s) at which the local obstruction is computed.
2. Provide the local certificate explicitly.
3. Label the result `[COMP]` for computational certificates.
4. Not describe a collection of local obstructions as a global proof unless the logical implication from local to global has been established.

**A collection of local obstructions is not automatically a global proof.**

## Discriminant and Near-Miss Studies

Contributions involving discriminant analysis or near-miss candidates must:

1. State the exact definition of "near-miss" used.
2. Provide the computational evidence explicitly.
3. Label appropriately (`[COMP]` or `[NUM]`).
4. Not describe near-miss evidence as a proof of non-representability.

## Reproducibility

All computational contributions must be reproducible. Provide:

- Source code or scripts.
- Input parameters and search bounds.
- Expected output and verification procedure.
- Hardware/software environment if relevant.

## Important Distinctions

| Claim type | Correct label | What it does NOT imply |
|------------|---------------|------------------------|
| Lean kernel-checked proof | `[FORMAL]` | — |
| Explicit mathematical derivation | `[EST]` | `[FORMAL]` |
| Finite computational search | `[COMP]` | Global theorem |
| Local congruence certificate | `[COMP]` | Global obstruction |
| Numerical experiment | `[NUM]` | Any of the above |

---

# Getting Help

- Open an issue for questions about the upstream conjecture format.
- Open an issue tagged `sun-extension` for questions about the research programme.
- See [RESEARCH_STATUS.md](RESEARCH_STATUS.md) for the current evidence status of all results.

