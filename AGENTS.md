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
4. Describing $n^*$ as a confirmed counterexample without a global non-existence theorem.
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
| Describe $n^*$ as confirmed counterexample | **No** |
| Upgrade evidence label without new evidence | **No** |
| Remove upstream attribution | **No** |
