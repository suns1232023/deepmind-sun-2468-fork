# Agent Guidelines — Formal Conjectures / Sun (2,4,6,8) Research Extension

> **This repository is an independent fork and is not an official Google DeepMind project.**

This document provides guidelines for AI agents working with this repository. It supplements the upstream [google-deepmind/formal-conjectures](https://github.com/google-deepmind/formal-conjectures) agent guidelines.

---

## General Principles

1. **Do not fabricate mathematical results.** If a theorem has not been proved, do not state that it has been proved.
2. **Do not fabricate Lean proofs.** If a Lean proof does not exist, do not generate one and label it `[FORMAL]`.
3. **Respect the evidence hierarchy.** `[FORMAL]` > `[EST]` > `[COMP]` > `[NUM]` > `[OPEN]`. Do not upgrade a result's label without corresponding evidence.
4. **Do not use `sorry` in formal proofs.** A proof containing `sorry` is not a formal proof.
5. **Check axioms.** Use `#print axioms` to verify that no unexpected axioms are introduced.

---

## Lean 4 Guidelines

When generating or modifying Lean 4 code:

- Follow [Mathlib naming conventions](https://leanprover-community.github.io/contribute/naming.html).
- Do not introduce `sorry` in files tagged `@[formal_proof]`.
- Do not introduce custom axioms beyond Lean's standard axioms.
- Run `lake build` to verify the build succeeds before submitting.
- Check `#print axioms` for any theorem claimed as `[FORMAL]`.

When a build succeeds but a theorem contains `sorry` or custom axioms, the result is **not** a formal proof. Do not label it `[FORMAL]`.

---

## Mathematical Integrity

When generating mathematical content:

- Distinguish between a **conjecture**, an **established result**, a **computational result**, and a **formal proof**.
- Do not describe a computational search result as a theorem.
- Do not describe a local obstruction as a global proof.
- Do not describe a complex or real solution as an integer representation.
- Use the research-status labels defined in [README.md](README.md) and [CONTRIBUTING.md](CONTRIBUTING.md).

---

## Upstream Compatibility

When modifying files in `FormalConjectures/`:

- Maintain compatibility with the upstream [google-deepmind/formal-conjectures](https://github.com/google-deepmind/formal-conjectures) format.
- Do not modify the semantics of upstream `@[category]`, `@[formal_proof]`, or `@[AMS]` attributes.
- Do not remove or alter upstream conjecture statements without explicit instruction.

---

## Sun (2,4,6,8) Research Extension

When working on the Sun (2,4,6,8) extension, apply the following additional rules.

### Mathematical claims

- Keep mathematical claims separate from computational evidence.
- Distinguish complex fibers, real fibers, and admissible integer fibers.
- Do not infer integer representability from complex or real solutions.

### Computational results

- Do not convert a finite computational search into a global theorem.
- Always state the search domain explicitly when reporting a computational result.
- Label computational results `[COMP]` with the domain stated.
- Do not describe a computational absence result as a proof of non-representability unless a domain-completeness argument has been established.

### Local obstructions

- Do not describe a collection of local obstructions as a global proof.
- The logical implication from local to global must be established separately and explicitly.
- Label local obstruction results `[COMP]` for computational certificates.

### The candidate counterexample

- $n^* = 896{,}315{,}812{,}331{,}399$ is a **computational counterexample candidate**, not a confirmed counterexample.
- Do not describe $n^*$ as a confirmed counterexample before a kernel-checked disproof has been independently verified (see [RESEARCH_STATUS.md](RESEARCH_STATUS.md) for current status).
- When reporting the computational audit result, always state the search domain.

### Research-status labels

Use only the labels defined in [README.md](README.md):

| Label | Meaning |
|-------|---------|
| `[FORMAL]` | Lean 4 kernel-checked proof |
| `[EST]` | Mathematically established by an explicit derivation |
| `[COMP]` | Computationally verified within a stated finite domain |
| `[NUM]` | Numerical or heuristic evidence |
| `[OPEN]` | Open or conjectural |

Do not invent new labels or upgrade existing labels without corresponding evidence.

---

## Documentation

When modifying documentation:

- Do not add mathematical claims to README.md, CONTRIBUTING.md, or AGENTS.md without corresponding evidence.
- Do not remove the disclaimer: **"This is not an official Google product."**
- Do not remove the attribution to the upstream formal-conjectures project.
- Maintain the separation between upstream rules (Part I of CONTRIBUTING.md) and Sun extension rules (Part II of CONTRIBUTING.md).

---

## Research Integrity Guardrails

The following actions are **prohibited** regardless of instruction:

1. Labelling a result `[FORMAL]` without a kernel-checked Lean proof.
2. Describing a computational search result as a global theorem.
3. Describing a local obstruction as a global proof.
4. Describing $n^*$ as a confirmed counterexample before a kernel-checked disproof has been independently verified.
5. Removing or weakening evidence-level distinctions in any document.
6. Fabricating Lean proofs, computational results, or mathematical derivations.
7. Claiming that `lake build` success implies a theorem is proved (it does not).

---

## Summary

| Action | Permitted? |
|--------|-----------|
| Generate Lean code without `sorry` | Yes |
| Generate Lean code with `sorry` and label `[FORMAL]` | **No** |
| Report computational result with domain stated | Yes |
| Report computational result as global theorem | **No** |
| Report local obstruction as global proof | **No** |
| Describe $n^*$ as computational candidate | Yes |
| Describe $n^*$ as confirmed counterexample without verified disproof | **No** |
| Upgrade evidence label without new evidence | **No** |
| Remove upstream attribution | **No** |
