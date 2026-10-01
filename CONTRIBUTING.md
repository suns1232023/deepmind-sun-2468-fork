# How to contribute

We'd love to accept your patches and contributions to this project. Contributions
of all kinds are welcome, from adding new formalisations to fixing inaccuracies.

This repository is based on the
[Formal Conjectures](https://github.com/google-deepmind/formal-conjectures)
project and additionally contains a research extension concerning Sun's
(2,4,6,8) conjecture and the geometry of its representation fibers.

Contributions should preserve the distinction between:

- the upstream **Formal Conjectures** benchmark and its contribution rules; and
- the additional **Sun (2,4,6,8) fiber-geometry research extension** maintained in this fork.

---

## Before you begin

### Sign our Contributor License Agreement

Contributions to this project must be accompanied by a
[Contributor License Agreement](https://cla.developers.google.com/about) (CLA).

You (or your employer) retain the copyright to your contribution; this simply
gives us permission to use and redistribute your contributions as part of the
project.

If you or your current employer have already signed the Google CLA (even if it
was for a different project), you probably don't need to do it again.

Visit <https://cla.developers.google.com/> to see your current agreements or to
sign a new one.

### Review our community guidelines

This project follows
[Google's Open Source Community Guidelines](https://opensource.google/conduct/).

---

## Ways to contribute

### 1. Formalise a problem

You can find problem lists ready to be worked on in our
[list of Milestones](https://github.com/google-deepmind/formal-conjectures/milestones).

You can also filter by the AMS 2020 Classification, for example:
[Group Theory Issues](https://github.com/google-deepmind/formal-conjectures/issues?q=is%3Aissue%20state%3Aopen%20label%3A%22ams-20%20Group%20theory%20and%20generalizations%22).

If you are new to Lean, see the
[good first issues](https://github.com/google-deepmind/formal-conjectures/issues?q=is%3Aissue%20is%3Aopen%20no%3Aassignee%20label%3A%22good%20first%20issue%22).

You can also browse
[unassigned new conjectures](https://github.com/google-deepmind/formal-conjectures/issues?q=is%3Aissue+is%3Aopen+no%3Aassignee+label%3A%22new+conjecture+conjectures%22)
and comment on the issue, for example:

> I plan to work on this.

More generally, we encourage adding formalisations of open conjectures from
all sorts of sources, including:

- **Literature:** textbooks, problem books, and research papers, including
  [arXiv](https://arxiv.org/archive/math).
- **Community resources:**
  [Wikipedia](https://en.wikipedia.org/wiki/List_of_unsolved_problems_in_mathematics),
  [MathOverflow](https://mathoverflow.net/), and the
  [OEIS](https://oeis.org/).
- **Problem lists:** famous collections such as
  [Millennium Prize Problems](https://www.claymath.org/millennium-problems/),
  [Smale's problems](https://en.wikipedia.org/wiki/Smale%27s_problems),
  [Erdős Problems](https://www.erdosproblems.com/),
  [Ben Green's list](https://people.maths.ox.ac.uk/greenbj/papers/open-problems.pdf),
  [Kourovka Notebook](https://arxiv.org/pdf/1401.0300), and
  [The Scottish Book](https://en.wikipedia.org/wiki/Scottish_Book).

We are also interested in formalised statements of solved variants of open
conjectures and solved statements from dedicated problem lists.

While the main goal is to collect conjecture statements, we appreciate the
inclusion of very short proofs for solved items or counterexamples, especially
if they are illuminating and useful for testing definitions.

**Longer proofs (i.e. more than 25–50 lines) are not to be included in this
repository.** Instead, we welcome you to host your proof in your own repository
and link to it using the `formal_proof` mechanism described below.

This restriction does not apply to `FormalConjecturesForMathlib`, where
statements are expected to have proofs.

### 2. Open issues

Open issues describing problems you would like to see formalised are welcome.

Such an issue should contain links to suitable references and, ideally, a
precise informal statement of the conjecture.

### 3. Improve references and tagging

You can improve existing problems by:

- adding references to existing files;
- correcting or expanding source information;
- adding relevant `AMS` subject attributes;
- improving the mathematical precision of informal descriptions.

### 4. Mark a problem as solved

If you become aware that a problem currently tagged

```lean
@[category research open]
```

has been solved, update its tag to

```lean
@[category research solved]
```

and add a

```lean
@[formal_proof using <kind> at "<url>"]
```

attribute pointing to the relevant proof.

See [The `@[formal_proof]` attribute](#the-formal_proof-attribute)
for the accepted `<kind>` values.

### 5. Fix misformalisations

PRs fixing incorrect formal statements and issues flagging potential
misformalisations are especially appreciated.

When proposing a correction, please distinguish clearly between:

- an error in the original conjecture;
- an error in its Lean formalisation;
- an ambiguity in the informal statement; and
- a change in the mathematical interpretation.

---

# Sun (2,4,6,8) Fiber Geometry Extension

This fork additionally supports research concerning the representation problem

$$
n =
\binom{w}{2}
+
\binom{x}{4}
+
\binom{y}{6}
+
\binom{z}{8},
$$

with the corresponding admissible integer domain.

The current research focuses in particular on

$$
n^* = 896,315,812,331,399.
$$

Contributions to this extension should preserve a strict distinction between
continuous solutions and discrete representations.

## 6. Geometric distinction

Contributors should distinguish explicitly between the following objects:

### Complex fiber

$$
\mathcal{F}_{n}^{\mathbb{C}}
=
\left\{
(w,x,y,z)\in\mathbb{C}^4:
\Phi_{\mathbb{C}}(w,x,y,z)=n
\right\}.
$$

### Real fiber

$$
\mathcal{F}_{n}^{\mathbb{R}}
=
\mathcal{F}_{n}^{\mathbb{C}}\cap\mathbb{R}^4.
$$

### Integer lattice fiber

$$
\mathcal{F}_{n}^{\mathbb{Z}}
=
\mathcal{F}_{n}^{\mathbb{R}}
\cap
\mathbb{Z}_{\mathrm{adm}}^4.
$$

The representation count is then

$$
R_{\mathbb{Z}}(n)
=
\#\mathcal{F}_{n}^{\mathbb{Z}}.
$$

Therefore, the following statements must not be treated as equivalent:

1. a complex solution exists;
2. a real solution exists;
3. an admissible integer solution exists;
4. the integer representation count is non-zero.

In particular,

$$
\mathcal{F}_{n}^{\mathbb{R}}\neq\varnothing
$$

does not imply

$$
R_{\mathbb{Z}}(n)>0.
$$

Likewise, a non-empty complex fiber does not by itself establish an integer
representation.

## 7. Computational audits

Computational contributions are welcome when they are:

- reproducible;
- accompanied by source code;
- based on clearly specified search domains;
- explicit about numerical precision and boundary conditions;
- independently checkable where practical.

Numerical verification should not be described as a formal proof unless the
corresponding result has actually been formalised and verified in an appropriate
proof assistant.

For computational studies, contributors should document:

- the search domain;
- admissibility constraints;
- enumeration strategy;
- integer bounds;
- precision and rounding rules;
- independent verification procedures;
- software versions where relevant.

Scripts for numerical experiments, near-miss searches, discriminant studies,
or local-obstruction experiments should normally be placed in:

```text
scripts/
```

unless they are directly required by a Lean formalisation.

## 8. Distributed Local Obstruction (DLO)

Contributions involving Distributed Local Obstruction (DLO) should clearly
separate local evidence from a global conclusion.

For example, a prime-adic obstruction may establish that no admissible integer
point exists modulo a particular prime or collection of primes.

Such results should identify:

- the relevant prime or primes;
- the local congruence condition;
- the residue or non-residue condition;
- the exact implication for admissible integer solutions;
- whether the result is computational, formally verified, or both.

A collection of local obstructions should not be described as a global proof
unless the logical implication from the local certificates to the global
statement has been established.

Where a Lean formalisation exists, the corresponding source file and theorem
should be identified.

## 9. Discriminant and near-miss studies

Computational studies involving discriminants, near-miss structures, or
approximate continuous solutions should clearly distinguish exact identities
from numerical proximity.

For example, a reported quantity such as

$$
\Delta_{D,\min}=8
$$

should be accompanied by its exact definition, search domain, and computational
method.

A near-miss should not be described as an exact solution unless the relevant
algebraic identity has been established exactly.

## 10. Research-status labels

Research results in this extension should use conservative status labels where
appropriate:

- **`[EST]` — Established:** supported by an explicit mathematical derivation
  and/or formal verification.
- **`[COMP]` — Computationally established:** supported by computational
  verification within a stated and reproducible domain.
- **`[NUM]` — Numerical:** supported primarily by numerical calculation or
  numerical exploration.
- **`[OPEN]` — Open:** a proposed statement, conjecture, interpretation, or
  research question that has not yet been established.

These labels describe the current evidentiary status of a result. They do not
replace the repository's `@[category]` attribute.

---

## Contribution process

1. **Sign the [Google CLA](https://cla.developers.google.com/)** if required.
2. Open a GitHub issue describing your planned contribution, if an appropriate
   issue does not already exist.
3. Fork the
   [repository](https://github.com/google-deepmind/formal-conjectures)
   and create a branch.
4. Add your formalised conjecture(s) in `FormalConjectures` in the appropriate
   subdirectory.
5. Definitions and results needed to formulate the conjecture should be added
   in a separate file in `FormalConjecturesForMathlib` in the appropriate
   subdirectory.
6. Add the file to the index in `FormalConjecturesForMathlib.lean` when required.
7. Verify that embedded links are not broken.
8. Ensure that the project builds successfully:

   ```bash
   lake build
   ```

9. For computational contributions, verify that scripts run from a clean
   environment and document the relevant parameters.
10. Submit a Pull Request and link it to the issue you created.

---

## Getting started with Lean 4

If you're new to Lean 4, install
[elan, lake, and Lean](https://leanprover-community.github.io/get_started.html).

Then:

```bash
git clone https://github.com/google-deepmind/formal-conjectures
cd formal-conjectures
lake exe cache get
lake build
```

Join the
[Formal Conjectures Zulip channel](https://leanprover.zulipchat.com/#narrow/channel/524981-Formal-conjectures)
for help and discussion.

---

## Choosing a folder and category

### Folder

Each top-level directory under `FormalConjectures/` corresponds to where the
conjecture was sourced from.

Place your file in the directory that matches the source you cite:

- `Arxiv` — arXiv preprints.
- `Books` — books and textbooks.
- `ErdosProblems` — [erdosproblems.com](https://www.erdosproblems.com/).
- `GreensOpenProblems` — [Ben Green's open-problems list](https://people.maths.ox.ac.uk/greenbj/papers/open-problems.pdf).
- `HilbertProblems` — [Hilbert's problems](https://en.wikipedia.org/wiki/Hilbert%27s_problems).
- `Kourovka` — [Kourovka Notebook](https://arxiv.org/pdf/1401.0300).
- `Mathoverflow` — [MathOverflow](https://mathoverflow.net/).
- `Millennium` — [Millennium Prize Problems](https://www.claymath.org/millennium-problems/).
- `OEIS` — [OEIS](https://oeis.org/).
- `OpenQuantumProblems` — open problems in quantum theory.
- `OptimizationConstants` — open problems about optimization constants.
- `Paper` — research papers not on arXiv.
- `Wikipedia` — [Wikipedia's list of unsolved problems](https://en.wikipedia.org/wiki/List_of_unsolved_problems_in_mathematics).
- `WrittenOnTheWallII` — the "Written on the Wall II" problem list.
- `Other` — anything that does not fit the categories above.

If your source genuinely does not fit any of these, use `Other` or open an issue
to discuss adding a new top-level directory before doing so.

---

## Category

Pick a category tag based on the statement's current status and purpose:

- The conjecture is **open** (no accepted proof):
  `@[category research open]`.
- The conjecture has been **solved** (informally accepted, or formally proved
  here or elsewhere):
  `@[category research solved]`.
- It is a **textbook-level** problem included as a special case or building
  block of a research problem:
  `@[category textbook]`.
- The statement defines basic theory around a definition you introduced:
  `@[category API]`.
- The statement is a unit test for a definition or theorem statement:
  `@[category test]`.

See [The `@[category]` attribute](#the-category-attribute) below for the
detailed semantics of each tag.

---

## File structure conventions

Every `.lean` file should follow this general structure:

```lean
/-
Copyright YYYY The Formal Conjectures Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-/

import FormalConjecturesUtil

/-
# Problem Title

*Reference:* https://...
-/

namespace MyProblem

@[category research open, AMS 11]
theorem my_conjecture : Statement := by
  sorry

end MyProblem
```

Replace `YYYY` with the current year, and consider adding yourself to the list
of authors in the `AUTHORS` file.

---

## The `@[category]` attribute

A tag to mark the category of a problem statement.

Every statement must have exactly one category tag.

The allowed categories are:

- `@[category research open]` — an unsolved open mathematical problem or
  conjecture for which no solution or proof is currently accepted by the
  mathematical community.

- `@[category research solved]` — a problem with an established solution.
  This includes problems that have a formal proof within this repository, a
  formal proof of an equivalent statement found elsewhere, or an informal
  solution accepted by experts in the field.

- `@[category textbook]` — a mathematics problem at the high school,
  undergraduate, or graduate level. This repository targets research-level
  problems; textbook problems should only be contributed if they are directly
  related to a research-level problem.

- `@[category API]` — a statement that constructs basic theory around a new
  definition.

- `@[category test]` — a unit-test statement useful for checking new
  definitions or theorem statements.

Example:

```lean
@[category research open]
theorem foo : Transcendental ℚ (rexp 1 + π) := by
  sorry

@[category research solved]
theorem bar : FermatLastTheorem := by
  sorry
```

---

## The `@[formal_proof]` attribute

The `formal_proof` attribute records the existence and location of a formal
proof.

This is independent of the `category` attribute and can be used with any
category.

Use:

```lean
@[formal_proof using <kind> at "link"]
```

where `<kind>` is one of:

- `formal_conjectures` — formally proved in this repository.
- `lean4` — formally proved in Lean 4 elsewhere, such as Mathlib or another
  repository.
- `other_system` — formally proved in another formal system, such as Rocq or
  Isabelle.

Example:

```lean
@[category research solved, AMS 11,
  formal_proof using lean4 at "https://github.com/example"]
theorem some_problem : ... := by
  sorry
```

---

## The `@[AMS]` attribute

The `AMS` tag provides information about the mathematical subjects to which a
given statement is related.

We use the main subjects listed in the
[AMS MSC2020](https://mathscinet.ams.org/mathscinet/msc/pdfs/classifications2020.pdf).

Every statement must have at least one `AMS` subject tag.

Examples:

```lean
@[AMS 11]      -- Number theory
@[AMS 5 11]    -- Combinatorics + Number theory
```

Within a Lean file, you can use the `#AMS` command to list all possible values.

To determine the subject associated with a tag in VS Code, hover over the
number.

---

## The `answer( )` elaborator

Some open questions are formulated in a way that requires a user-provided
answer.

For instance, the
[Hadwiger–Nelson problem](https://en.wikipedia.org/wiki/Hadwiger%E2%80%93Nelson_problem)
asks for the minimum number of colours needed to colour the plane such that no
two points exactly one unit distance apart have the same colour.

The `answer( )` elaborator allows us to formulate the problem without deciding
the answer.

```lean
@[category research open]
theorem HadwigerNelsonProblem :
  UnitDistancePlaneGraph.chromaticNumber = answer(sorry) := by
  sorry
```

### Problems that require answers

Providing a term inside the `answer( )` elaborator together with a proof that
the statement is true does **not** by itself mean that the problem has been
solved.

For example, a question of the form:

> Which natural numbers satisfy the predicate $P$?

might be formalised as:

```lean
theorem myOpenProblem : {n : ℕ | P n} = answer(sorry) := by
  sorry
```

One can provide trivial answers that are not mathematically interesting, such
as the set `{n : ℕ | P n}` itself.

The question of whether the answer provided corresponds to a mathematically
meaningful solution of the problem is outside the scope of this repository.

---

## Style guidelines

- One problem per file. Variants and special cases may share a file.
- Include a reference comment linking to the source of the conjecture.
- Use `theorem` or `lemma` for problem statements.
- Bespoke definitions are allowed when they help clarify problem statements;
  add basic API tests for them.
- Do not introduce placeholder definitions, incomplete type annotations,
  holes, or new axioms.
- All referenced definitions must exist, and all imports must be correct.
- Every statement should have at least one `AMS` subject tag.
- Every file should be placed in the corresponding directory of the
  repository.
- When a problem is stated as a question in English, the preferred style is
  to use `answer(sorry)`.

For example:

```lean
/-- English version: "Does P hold?" -/
theorem myConjecture : answer(sorry) ↔ P := by
  sorry
```

This way the informal "Does ...", "Are there ...", or "Is it true that ..."
corresponds to the `answer(sorry)` in the formalised statement.

If the problem has been solved, `answer(sorry)` should be replaced by
`answer(True)` or `answer(False)` accordingly.

If the problem is not stated as a question, the following style is preferred:

```lean
/-- English version: "P holds" -/
theorem myConjecture : P := by
  sorry
```

If the problem has been solved to the negative, then `P` should be replaced
with `¬ P`.

- Follow the same AI usage conventions as
  [Mathlib](https://leanprover-community.github.io/contribute/index.html).
- Use TeX for mathematics in comments, for example:

```lean
If $A \subset \mathbb{N}$ has $\sum_{n \in A}\frac{1}{n} = \infty$.
```

### Additional style guidance for computational research

For computational or geometric extensions:

- distinguish exact results from numerical observations;
- state search bounds explicitly;
- avoid presenting finite computational evidence as a universal theorem;
- provide reproducible scripts where practical;
- preserve exact integer arithmetic whenever possible;
- identify floating-point calculations explicitly;
- state whether a result is computationally exhaustive or only exploratory;
- keep independently verifiable certificates separate from exploratory code.

---

## Code reviews

All submissions, including submissions by project members, require review.

We use GitHub pull requests for this purpose.

Consult
[GitHub Help](https://help.github.com/articles/about-pull-requests/)
for more information on using pull requests.

Reviewers may request:

- clarification of the mathematical statement;
- additional references;
- corrections to the Lean formalisation;
- reproducibility information for computational results;
- separation of computational evidence from formal proof;
- clarification of research-status labels.

---

## Managing labels

Any user can add or remove certain labels on pull requests and issues by
leaving a comment.

The supported labels are:

`awaiting-author`, `WIP`, `Easy`, and `documentation`.

### To add a label

Leave a comment with `+` followed by the exact label name on a line by itself.

For example:

```text
+awaiting-author
```

For compatibility, the exact label name without `+` also works.

### To remove a label

Leave a comment with `-` followed by the exact label name on a line by itself.

For example:

```text
-awaiting-author
```

---

## Research integrity and reproducibility

Research extensions should make a clear distinction between:

- **formal proof**;
- **mathematical derivation**;
- **computer-assisted verification**;
- **numerical evidence**; and
- **open conjectures or hypotheses**.

A computational result should be reported together with its scope.

For example, an exhaustive search over a finite interval establishes the absence
of a solution **within that interval**. It does not, by itself, establish
absence over an infinite domain.

Similarly, a local obstruction establishes a corresponding local constraint.
A global non-existence statement requires the appropriate logical connection
between the local conditions and the original integer problem.

This distinction is especially important for the Sun (2,4,6,8) fiber-geometry
extension, where continuous fibers and discrete lattice intersections represent
different mathematical objects.

---

## Questions and discussion

For questions concerning Lean, formalisation, or the Formal Conjectures
repository, use the
[Formal Conjectures Zulip channel](https://leanprover.zulipchat.com/#narrow/channel/524981-Formal-conjectures).

For research-specific discussions concerning the Sun (2,4,6,8) fiber-geometry
extension, please provide sufficient mathematical and computational detail to
allow independent verification.
