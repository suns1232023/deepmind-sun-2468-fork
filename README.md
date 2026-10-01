# Formal Conjectures
 
[![.github/workflows/push_master.yml](https://github.com/google-deepmind/formal-conjectures/actions/workflows/build-and-docs.yml/badge.svg)](https://github.com/google-deepmind/formal-conjectures/actions/workflows/build-and-docs.yml)
[![arXiv](https://img.shields.io/badge/arXiv-2605.13171-b31b1b.svg)](https://arxiv.org/abs/2605.13171)
[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/google-deepmind/formal-conjectures)
[![project chat](https://img.shields.io/badge/zulip-join_chat-brightgreen.svg)](https://leanprover.zulipchat.com/#narrow/channel/524981-Formal-conjectures)
 
> **This repository is an independent fork and is not an official Google DeepMind project.**
 
A collection of formalised statements of conjectures in
[Lean](https://leanprover.github.io/lean4/doc/whatIsLean.html), using
[mathlib](https://github.com/leanprover-community/mathlib4).
 
Explore the docs: [Formal Conjectures Documentation](https://google-deepmind.github.io/formal-conjectures/)
 
Join our [channel on the leanprover Zulip](https://leanprover.zulipchat.com/#narrow/channel/524981-Formal-conjectures)
 
---
 
## Sun (2,4,6,8) Conjecture & Fiber Geometry Extension
 
This fork extends the Formal Conjectures repository with a computational and geometric study of Sun's (2,4,6,8) representation problem.
 
The focus centers on the fiber geometry of
 
$$
n^* = 896{,}315{,}812{,}331{,}399
$$
 
and on the interaction between continuous fibers and the integer lattice.
 
### Research-Status Labels
 
The labels below distinguish the current epistemic status of the results presented in this extension:
 
| Label | Meaning | Lean required? |
|-------|---------|----------------|
| `[FORMAL]` | Lean 4 kernel-checked proof; `#print axioms` confirms no unexpected axioms; no `sorry`. | Yes |
| `[EST]` | Mathematically established by an explicit derivation. Does **not** imply Lean formalisation. | Not necessarily |
| `[COMP]` | Computationally verified within an explicitly stated finite domain. Always domain-bounded. | No |
| `[NUM]` | Numerical or heuristic evidence. | No |
| `[OPEN]` | Open or conjectural; no proof or computational verification established. | — |
 
**`[EST]` does not equal `[FORMAL]`.** A result labelled `[EST]` has an explicit mathematical derivation but may not yet have a Lean kernel-checked proof.
 
**`[COMP]` is always domain-bounded.** A computational absence result is not a global non-existence theorem unless a domain-completeness argument has been established.
 
These labels are intentionally conservative and do not imply that every result has been formalised as a complete theorem in Lean.
 
### Research Map
 
The extension is organised into four layers:
 
| Layer | Object | Main question | Status |
|-------|--------|---------------|--------|
| Algebraic | $\Phi: \mathbb{Z}_{\geq 0}^4 	o \mathbb{Z}_{>0}$ | What is the underlying polynomial map? | `[FORMAL]` / `[EST]` |
| Complex geometry | $\mathcal{F}_n^{\mathbb{C}}$ | Do complex solutions exist? | `[EST]` |
| Real geometry | $\mathcal{F}_n^{\mathbb{R}}$ | Do real solutions exist? | `[EST]` |
| Integer lattice | $\mathcal{F}_n^{\mathbb{Z}}$ | Does the fiber contain admissible integer points? | `[COMP]` / `[OPEN]` |
| Local obstruction | DLO | Can integer non-existence be certified locally? | `[COMP]` / `[OPEN]` |
 
The central geometric insight is that these are **distinct** questions:
 
$$
\mathcal{F}_n^{\mathbb{C}} 
eq \emptyset
\quad 
ot\Rightarrow \quad
\mathcal{F}_n^{\mathbb{R}} 
eq \emptyset
\quad 
ot\Rightarrow \quad
\mathcal{F}_n^{\mathbb{Z}} 
eq \emptyset.
$$
 
A continuous solution does not imply an integer representation.
 
### Fiber Geometry
 
- **Explicit Complex & Real Solutions `[EST]`**
 
  For $-n^*$, an explicit complex solution is constructed at $x=y=z=0$:
 
  $$
  w =
  \frac{1+i\sqrt{7{,}170{,}526{,}498{,}651{,}191}}{2}.
  $$
 
  For $n^*$, an explicit real non-integer solution is given by
 
  $$
  (w,x,y,z)=(42{,}339{,}774.4,\ 4,\ 6,\ 8).
  $$
 
  These solutions illustrate that the absence of admissible integer representations does not imply the absence of continuous real or complex solutions.
 
- **Surjectivity of $\Phi_{\mathbb{C}}$ `[EST]`**
 
  The map
 
  $$
  \Phi_{\mathbb{C}}:\mathbb{C}^4ightarrow\mathbb{C}
  $$
 
  is formally established as surjective, using the fact that
 
  $$
  B_2(\mathbb{C})=\mathbb{C}.
  $$
 
  Consequently, every complex target value has a non-empty complex fiber. At regular points of the level set, the complex fiber has complex dimension $3$ (equivalently, real dimension $6$).
 
- **Computational Status of $n^*$ `[COMP]`**
 
  The fiber
 
  $$
  \mathcal{F}_{n^*}^{\mathbb{R}}
  $$
 
  is computationally shown to be non-empty and to contain continuous real solutions. Within the stated admissible search domain, the computational audit finds
 
  $$
  R_{\mathbb{Z}}(n^*)=0.
  $$
 
  This is a computational result for the stated search domain. It should not be interpreted as a global non-existence theorem unless a corresponding domain-completeness argument has been established and independently verified.
 
  The result is classified as a **computational counterexample candidate**, not a confirmed counterexample.
 
- **Distributed Local Obstruction (DLO) `[COMP]`**
 
  A distributed local-obstruction framework studies how prime-adic constraints can prevent integer points from entering the fiber.
 
  Individual local obstructions provide local certificates at specified primes. A global non-existence conclusion requires an explicit theorem connecting the collection of local certificates to the original integer representation problem.
 
  **A collection of local obstructions is not automatically a global proof.** The logical implication from local to global must be established separately.
 
  Current status: individual DLO certificates have been computed for specified primes. `[COMP]`
 
### Three-Layer Geometric Framework
 
The current research distinguishes three mathematically different structures:
 
1. **Complex fiber**
 
   $$
   \mathcal{F}_{n}^{\mathbb{C}}
   =
   \{(w,x,y,z)\in\mathbb{C}^4:\Phi_{\mathbb{C}}(w,x,y,z)=n\}.
   $$
 
   The complex setting provides the broadest continuous algebraic structure.
 
2. **Real fiber**
 
   $$
   \mathcal{F}_{n}^{\mathbb{R}}
   =
   \mathcal{F}_{n}^{\mathbb{C}}\cap\mathbb{R}^4.
   $$
 
   The real fiber describes continuous real solutions and may remain non-empty even when integer representations are absent.
 
3. **Integer lattice fiber**
 
   $$
   \mathcal{F}_{n}^{\mathbb{Z}}
   =
   \mathcal{F}_{n}^{\mathbb{R}}
   \cap
   \mathbb{Z}_{\mathrm{adm}}^4,
   $$
 
   where $\mathbb{Z}_{\mathrm{adm}}^4$ denotes the admissible integer domain of the original representation problem.
 
   The representation count is then determined by the cardinality of this discrete intersection:
 
   $$
   R_{\mathbb{Z}}(n)
   =
   \#\mathcal{F}_{n}^{\mathbb{Z}}.
   $$
 
This framework separates three questions that are often conflated:
 
- Does a complex solution exist?
- Does a real solution exist?
- Does an admissible integer solution exist?
 
The fiber geometry shows that these are distinct questions.
 
---
 
## Goals
 
While there is a growing corpus of formalised theorems including proofs, there is a lack of open conjectures where only the statement has been formalised.
 
This would be useful for a few reasons. It could:
 
- Become a great benchmark for automated theorem provers and automated formalisation tools.
- Help clarify the precise meaning of conjectures through formalisation.
- Encourage the expansion of `mathlib` by highlighting needed definitions.
 
It is our hope that this initiative will form the seed of a much richer dataset of formalised conjectures.
 
### Note on Formalisation Accuracy
 
Formalizing mathematical statements without proofs is inherently challenging.
 
Subtle inaccuracies can arise where the formal statement might not perfectly capture the nuances of the original conjecture. To mitigate this issue, we will rely on careful human review of contributions, and plan to periodically leverage AlphaProof to help identify potential misformalisations.
 
The additional results in the Sun (2,4,6,8) fiber-geometry extension should therefore be interpreted according to their stated research-status labels rather than as claims that every result has already been fully formalised.
 
---
 
## Contributing
 
Contributions are most welcome — consider adding (or even just opening an issue describing) your favourite conjecture.
 
See [CONTRIBUTING.md](./CONTRIBUTING.md) for the full contribution guide, including ways to contribute, the step-by-step process, file structure conventions, attribute usage, and style guidelines.
 
For contributions to the Sun (2,4,6,8) extension specifically, see the research-status labels above and the guidelines in [CONTRIBUTING.md](./CONTRIBUTING.md#sun-2468-research-extension).
 
---
 
## Usage, Structure & Features
 
This is a Lean 4 project managed with `lake` and a dependency on `mathlib`.
 
You first need to [install elan, lake, lean and, if you want, VS Code](https://leanprover-community.github.io/get_started.html) and then run:
 
```bash
lake exe cache get
lake build
```
 
### Directory structure
 
The directory structure is organised by the type of sources of the conjectures.
 
There are two special directories:
 
- `FormalConjecturesUtil` contains utilities like the
  [`category` attribute](./FormalConjecturesUtil/Attributes/Basic.lean),
  the [`answer()` elaborator](./FormalConjecturesUtil/Answer.lean),
  and some linters.
 
- `FormalConjecturesForMathlib` contains code potentially suitable to be upstreamed to
  [mathlib](https://github.com/leanprover-community/mathlib4). Here we follow
  mathlib's directory structure.
 
For details on the `@[category]`, `@[formal_proof]`, `@[AMS]` attributes and
the `answer()` elaborator that statements in this repository use, see
[CONTRIBUTING.md](./CONTRIBUTING.md).
 
---
 
## Versioning
 
This repo will track the monthly tagged releases of mathlib (which correspond to Lean releases), rather than tracking mathlib master.
 
To minimize friction when adding problem statements that need definitions that are not yet in mathlib, such definitions can be added to the `FormalConjecturesForMathlib` directory.
 
This ensures that the addition of these problems to `formal-conjectures` is not locked to the mathlib release cadence.
 
When `lean-toolchain` is updated on `main`, a GitHub Actions workflow automatically adds a git tag of the form `v4.{X}.{Y}`, following mathlib's tagging convention.
 
Stable benchmark snapshots are tagged using the format:
 
```text
bench-v{N}-lean4.{X}.{Y}
```
 
where:
 
- **`v{N}` (Benchmark version):** Identifies the set of problems included in the benchmark. The benchmark version is bumped whenever problems are added, removed, or when misformalizations are corrected.
 
- **`lean4.{X}.{Y}` (Lean version):** Identifies the Lean 4 toolchain version used for that snapshot.
 
Tags are immutable: fixes to misformalizations are never patched into an existing benchmark version but instead go into `v{N+1}`.
 
---
 
## Citing formal-conjectures
 
If your work has used formal-conjectures, please consider citing it via:
 
```bibtex
@misc{FormalConjectures,
  author = {{The Formal Conjectures Authors}},
  title  = {{T}he {F}ormal {C}onjectures {R}epository},
  year   = {2025},
  url    = {https://github.com/google-deepmind/formal-conjectures},
}
 
@article{FormalConjecturesPaper,
  author  = {Firsching, Moritz and Lezeau, Paul and Mercuri, Salvatore
             and Horv{'a}th, Mikl{'o}s Z and Dillies, Ya{"e}l and S{"o}nne, Calle
             and Wieser, Eric and Zhang, Fred and Hubert, Thomas
             and Ag{"u}era y Arcas, Blaise and Kohli, Pushmeet},
  title   = {{F}ormal {C}onjectures: {A}n {O}pen and {E}volving {B}enchmark for
             {V}erified {D}iscovery in {M}athematics},
  year    = {2026},
  url     = {https://arxiv.org/abs/2605.13171v1},
}
```
 
For the Sun (2,4,6,8) fiber geometry extension:
 
```bibtex
@misc{Sun2468Extension,
  author = {Sun, Scott},
  title  = {Sun (2,4,6,8) Fiber Geometry Extension},
  year   = {2026},
  url    = {https://github.com/suns1232023/scottsun.com},
  note   = {Independent fork of google-deepmind/formal-conjectures.
            ORCID: 0009-0002-1095-6228},
}
```
 
---
 
## Attribution
 
This repository is based on Google's [Formal Conjectures](https://github.com/google-deepmind/formal-conjectures) project.
 
The upstream Formal Conjectures materials retain their original copyright and licensing terms (see Licensing below).
 
The Sun (2,4,6,8) fiber geometry extension is the independent work of Scott Sun
(ORCID: [0009-0002-1095-6228](https://orcid.org/0009-0002-1095-6228)).
 
---
 
## Licensing
 
Copyright 2025 The Formal Conjectures Authors.
 
All software is licensed under the Apache License, Version 2.0 (Apache 2.0); you may not use this file except in compliance with the Apache 2.0 license.
 
You may obtain a copy of the Apache 2.0 license at:
 
https://www.apache.org/licenses/LICENSE-2.0
 
All other materials are licensed under the Creative Commons Attribution 4.0 International License (CC-BY).
 
You may obtain a copy of the CC-BY license at:
 
https://creativecommons.org/licenses/by/4.0/legalcode
 
The content may be based on third-party sources and may in some cases include third-party content. The original source for each conjecture is indicated by a URL within the source file.
 
Third-party content may be subject to different licensing requirements. In particular:
 
- Material from Wikipedia articles, MathOverflow, and the OEIS is released under the Creative Commons Attribution-Share-Alike License 4.0.
- Material from bbchallenge.org is used under the Creative Commons Attribution 4.0 International License.
- Material from the Equational Theories Project is used under Apache-2.0.
- Material from arXiv is used under the licence applicable to the relevant paper, as indicated at the URL within the source file.
 
Unless required by applicable law or agreed to in writing, all software and materials distributed here under the Apache 2.0 or CC-BY license are distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 
See the licenses for the specific language governing permissions and limitations under those licenses.
 
---
 
**This is not an official Google product.**
 
