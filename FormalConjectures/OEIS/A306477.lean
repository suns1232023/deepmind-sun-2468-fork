/-
Copyright 2025 The Formal Conjectures Authors.

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
module

public import FormalConjecturesUtil

/-!
# The 2-4-6-8 Conjecture

Any integer $n > 0$ can be written as $\binom{w+2}{2} + \binom{x+3}{4} + \binom{y+5}{6} + \binom{z+7}{8}$
with $w, x, y, z$ nonnegative integers.

Zhi-Wei Sun has offered a $2,468 prize for the first proof (or $2,468 RMB for a counterexample).

The conjecture has been verified for all $n$ up to $1.2 \times 10^{12}$ by Yaakov Baruch (March 2019).

The conjecture is false: $n = 896315812331399$ has no such representation. The counterexample
was found in the OEIS Open project, with a Lean proof.

**External formal proof (not yet bridged in this fork):**
An external Lean 4 kernel-checked proof exists at:
  epoch-research/LeanOpenProblems-results, commit fd09021e79869476ef83cda231312f1a2a89c8d7
  File: runs/oeis-open-lite-fable51-wm0v421z5ygi8f6b/oeis_306477_conjecture_1/Submission/Spec.lean#L793
  Theorem: `oeis_306477_conjecture_1.disproof`

That proof uses a counting-function definition `A306477 : ℕ → ℕ`, while this file uses
the existential predicate `A : ℕ → Prop`. The bridge theorem
  `A n ↔ 0 < A306477 n`
is established in `FormalConjectures/OEIS/BridgeTheorem.lean` (status: [OPEN]).

Until `BridgeTheorem.A_iff_count_pos` is proved in this fork, the `formal_proof` attribute
cannot be applied to `conjecture` here. See `FORMAL_AUDIT.md` for the full audit checklist.

*References:*
- [A306477](https://oeis.org/A306477)
- [mathoverflow/323541](https://mathoverflow.net/questions/323541): Z.-W. Sun, "Positive integers written as C(w,2) + C(x,4) + C(y,6) + C(z,8) with w,x,y,z in {2,3,...}", Feb. 19, 2019.
- T. Adamczewski, "OEIS Open: How many conjectures can language models turn into theorems?",
  [arXiv:2608.11941](https://arxiv.org/abs/2608.11941) [cs.AI], 2026.
-/

@[expose] public section

namespace OeisA306477

/-- The predicate that `n` can be written as $\binom{w+2}{2} + \binom{x+3}{4} + \binom{y+5}{6} + \binom{z+7}{8}$
for nonnegative integers $w, x, y, z$. -/
def A (n : ℕ) : Prop :=
  ∃ w x y z : ℕ, n = (w + 2).choose 2 + (x + 3).choose 4 + (y + 5).choose 6 + (z + 7).choose 8

@[category test, AMS 11]
theorem a_1 : A 1 :=
  ⟨0, 0, 0, 0, by decide⟩

@[category test, AMS 11]
theorem a_2 : A 2 :=
  ⟨0, 1, 0, 0, by decide⟩

@[category test, AMS 11]
theorem a_3 : A 3 :=
  ⟨1, 0, 0, 0, by decide⟩

@[category test, AMS 11]
theorem a_4 : A 4 :=
  ⟨1, 1, 0, 0, by decide⟩

@[category test, AMS 11]
theorem a_5 : A 5 :=
  ⟨1, 1, 1, 0, by decide⟩

@[category test, AMS 11]
theorem a_6 : A 6 :=
  ⟨2, 0, 0, 0, by decide⟩

/--
**Zhi-Wei Sun's 2-4-6-8 Conjecture (A306477)**: Any integer $n > 0$ can be written as
$\binom{w+2}{2} + \binom{x+3}{4} + \binom{y+5}{6} + \binom{z+7}{8}$ for nonnegative integers $w, x, y, z$.

This is false: $n = 896315812331399$ is a counterexample.
See T. Adamczewski, OEIS Open: How many conjectures can language models turn into theorems?,
[arXiv:2608.11941](https://arxiv.org/abs/2608.11941).

**Proof status in this fork: [OPEN]**
An external Lean 4 kernel-checked proof exists (epoch-research, commit fd09021) but uses a
different definition (`A306477 : ℕ → ℕ`, counting function) rather than this file's existential
predicate `A`. The bridge theorem `A n ↔ 0 < A306477 n` is pending in `BridgeTheorem.lean`.
The `formal_proof` attribute will be restored once the bridge is established.
See `FORMAL_AUDIT.md` for the complete audit checklist.
-/
@[category research solved, AMS 11]
theorem conjecture : ¬ ∀ n : ℕ, 0 < n → A n := by
  -- [OPEN in this fork]: bridge theorem A_iff_count_pos pending.
  -- External proof: epoch-research/LeanOpenProblems-results, commit fd09021,
  -- theorem oeis_306477_conjecture_1.disproof, counterexample n0 = 896315812331399.
  -- Restore formal_proof attribute after BridgeTheorem.A_iff_count_pos is proved.
  sorry

end OeisA306477
