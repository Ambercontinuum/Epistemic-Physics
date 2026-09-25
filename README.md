# Epistemic Physics

---

## What is this?

This repository presents **Epistemic Physics**, an AmberContinuum Research project by Amber Anson. The proposed framework studies how unresolved systems become determinate across physical computation, information geometry, and agent alignment. The repository contains three research papers and a Lean 4 formalization of selected mathematical claims. Lean checks the stated theorems; open claims are marked separately, and the proposed physical interpretation remains unverified.

---

## What is Epistemic Physics?

Epistemic Physics is a proposed framework that asks: *what might truth, meaning, and alignment have in common at a structural level?*

The claim is that all three are instances of the same underlying phenomenon — **collapse**. A system "collapses" when it moves from an unresolved, indeterminate state into a settled, determinate one. A computation produces an answer. A signal acquires a determinate interpretation. An agent arrives at a stable value alignment. These look like very different events, but Epistemic Physics argues they obey the same law.

Three previously independent research programs are brought together here:

| Program | What it studies | Collapse looks like... |
|---|---|---|
| **Physical Mathematics** | Computation under physical constraints | A computation hitting its entropy ceiling and resolving |
| **Collapse Geometry** | Information in geometric/Riemannian space | A signal exceeding the noise threshold and becoming determinate |
| **Coherence Mathematics** | Agent alignment and value stability | A system converging to a stable, sovereign configuration |

The framework proposes that these may be three coordinate descriptions of a single underlying structure — what the project calls an *epistemic manifold* — governed by one candidate law. This is a modeling hypothesis, not an established result in physics.

---

## What does "collapse" mean?

The central idea is simple. Every configuration of a system has two competing quantities:

- **Coherence** (`C_F`) — the pressure pulling the system toward a determinate state
- **Contradiction** (`K_F`) — the resistance or noise pushing against it

A system **collapses** (becomes determinate) when the coherence exceeds the contradiction by at least some threshold `Θ_F`:

```
C_F(x) - K_F(x) ≥ Θ_F
```

This is the **Epistemic Collapse Operator**. The `F` subscript means "in frame F" — the same system can look collapsed or unresolved depending on the frame of reference, just as a physical measurement depends on the observer.

What makes this interesting is the possibility that truth (in computation), meaning (in geometry), and alignment (in agent dynamics) can be represented by this same inequality — in their respective domains, with domain-specific quantities. The current proofs establish selected mathematical properties of those models; they do not establish that nature uses one universal collapse mechanism.

The project also considers quantum computation, and possibly quantum processes in biological systems, as a future physical realization of collapse. That mechanism is not currently demonstrated. The present status is: the framework is internally coherent in its formal models, while its quantum and neural physical realization remains an open hypothesis.

## What is built, what is under test

The formal core is the proposed abstraction. The physical realization is the open research question.

| Status | Meaning |
|---|---|
| **Proved** | Lean checks the theorem from its stated definitions and hypotheses. |
| **Conditional** | The result is valid, but depends on an explicit domain assumption. |
| **Axiom** | Lean accepts the statement as an assumption; it does not verify it. |
| **Unasserted proposition** | Lean records a proposed statement as a `Prop` definition without assuming it is true. |
| **Needs revision** | The current statement is false, tautological, or too weak to express the intended claim. |

The project is strongest when these categories remain separate. Internal coherence is necessary for a theory, formal validity strengthens it, and physical realization is the further question.

---

## Why formal proof?

Informal mathematical arguments can contain hidden assumptions, subtle errors, or gaps that only become visible when someone tries to apply the result in a new context. Formal proof exposes much of this: a proof assistant like Lean 4 either accepts a proof or rejects it. There is no "mostly right" for what has been encoded — though modeling choices themselves remain open to scrutiny.

The theorems here are **mechanically verified**. This matters especially for a framework that makes claims across multiple domains simultaneously — the formal proofs make the encoded connections precise and checkable. They verify the stated definitions and hypotheses; they do not by themselves validate the choice of physical model or its interpretation.

Where proofs are not yet complete, this repository distinguishes **axioms** (assumed in Lean) from **unasserted propositions** (recorded without being assumed). Claims known to be false as stated are unasserted propositions pending revision. See the [Epistemic Status table](#epistemic-status-of-each-claim) below.

---

## The Candidate Law

For any frame F and configuration x:

```
C_F(x) - K_F(x) ≥ Θ_F
```

Where:
- `C_F` — coherence functional (what pulls toward collapse)
- `K_F` — contradiction functional (what resists collapse)
- `Θ_F` — threshold (minimum net coherence for a determinate state)

This is the **Epistemic Collapse Operator**. Truth, meaning, and alignment are proposed as possible instances of it in different substrates. The shared form is formalized; the physical universality claim remains open.

## Quantum realization

The project treats quantum computation, and possibly quantum processes in biological systems, as a possible physical realization of collapse. That realization is not currently demonstrated.

A substantive quantum version will need to specify:

- a state space, such as Hilbert-space states or density operators;
- measurement operators or quantum channels;
- the observable that becomes determinate;
- definitions of coherence, contradiction, and threshold in that system;
- predictions that differ from existing quantum-information or neuroscience models.

The current claim is therefore:

> Epistemic collapse is a proposed structural pattern that may be physically instantiated by quantum measurement or computation. Its mathematical core is being formalized; its neural and quantum mechanism remains falsifiable research.

---

## Use Cases

Epistemic Physics is designed as a formal reasoning substrate for systems that must determine when an unresolved state has become sufficiently coherent to act on.

- **Auditing threshold decisions** — represent evidence for and against a conclusion explicitly, then verify whether the stated threshold has actually been met.
- **Comparing models across domains** — translate computational limits, signal resolution, and alignment dynamics into a shared vocabulary without claiming that their physical mechanisms are identical.
- **AI alignment and agent governance** — specify coherence targets, constraint pressure, overflow conditions, and sovereignty-preserving vetoes in a form that can be inspected and tested.
- **Information and signal analysis** — study how resonance, contradiction, and accumulated noise affect whether a signal becomes determinate.
- **Physically bounded computation** — reason about entropy ceilings, finite precision, and the tradeoff between truncation and rounding error.
- **Formal theory development** — turn broad interdisciplinary claims into definitions, theorems, counterexamples, and explicit proof obligations.

A concrete implementation might use an `EpistemicFrame` to encode a decision process: `C` measures supporting coherence, `K` measures unresolved contradiction, and `Theta` specifies the minimum margin required before the system may commit. The current repository verifies the mathematics of this pattern; selecting valid domain-specific measures and thresholds remains an empirical and modeling responsibility.

---

## Repository Structure

```
/
├── README.md                         # Research map and epistemic status
├── lean-toolchain                    # Pinned Lean 4 version
├── lakefile.toml                     # Lake targets and Mathlib dependency
├── lake-manifest.json                # Exact dependency revisions
├── EpistemicPhysics.lean             # Shared abstract collapse vocabulary
├── PhysicalMathematics.lean          # Chart I: thermodynamic/numerical model
├── CollapseGeometry.lean             # Chart II: resonance/torsion model
├── CoherenceMathematics.lean         # Chart III: alignment model
├── From_Bit_To_Boundary_V2.tex       # Geometric information-collapse paper
├── Physical_Mathematics_V4.tex       # Physical mathematics paper
└── Coherence_Mathematics.tex         # Coherence mathematics paper
```

Recommended reading order:

1. This README for the claim and its limits.
2. `EpistemicPhysics.lean` for the abstract vocabulary.
3. The three Lean charts for the current formal evidence.
4. The papers for interpretation, motivation, and predictions.
5. The open claims and counterexamples before treating any axiom as a result.

---

## Files

### `EpistemicPhysics.lean`
The abstract layer. Defines `EpistemicFrame` as a structure with a coherence functional, contradiction functional, and threshold. Proves:
- `epistemicCollapseEquivalence` — the three characterizations of collapse are provably equivalent
- `collapseMetric_mono_coherence/contradiction` — monotonicity in both directions
- `regimes_trichotomy` — every configuration is collapsed, critical, or latent
- `critical_is_boundary` — critical ↔ collapsed AND metric = 1 exactly
- `FrameTransformation` with composition and identity — substrate independence has algebraic structure
- `chart_universality` — collapse implies metric ≥ 1, in any frame

Open claims requiring revision:
- `frame_nontriviality` — an unasserted proposition, false for an arbitrary frame without assumptions on `C` and `K`
- `collapse_irreversibility` — still an axiom, although it follows from `FrameTransformation.preserves_collapse` and `collapsed_not_latent`; no topology is needed for the statement currently encoded

### `PhysicalMathematics.lean`
Physical and numerical results intended to support Chart I. Unlike Charts II and III, this file does not yet define an `EpistemicFrame` instantiation. It proves:
- `law1_core` — any computation requiring > n_max bits exceeds the physical entropy budget
- `law2_tradeoff` — truncation and rounding errors are independently monotone in opposite directions
- `law2_error_bound_pos` — the stated two-term error expression is positive when its coefficients and parameters are positive
- `optimalStep_pos` — the optimal step size is well-defined and positive
- `laws_coupled` — the bit-budget ceiling from Law 1 applies directly to the precision parameter in Law 2

Unasserted research propositions (each needs revision):
- `conjectureA_quantum_complexity_reduction` — currently claims quantum complexity is lower for every input and every pair of positive complexity functions; identical functions refute it. The intended nonempty-subclass claim is not yet encoded.
- `conjectureB_fractal_dimension_convergence` — a sequence remaining in (1, 2) need not converge
- `conjectureC_geometric_foundation` — the current type cannot encode pointwise equivalence for a nonconstant relation because its right side does not depend on the particular integers `a` and `b`

Based on: Landauer (1961), Bekenstein (1981), Higham (2002).

### `CollapseGeometry.lean`
Chart II instantiation with `Config = ℝ`. The current formal model is scalar; a general Riemannian-manifold formulation remains future work. It proves:
- `resonance_pos`, `resonance_le_one`, `resonance_max` — Gaussian kernel properties
- `resonance_strictMono` — resonance is strictly decreasing in distance from basis element
- `contradictionCost_pos`, `contradictionCost_strictMono` — torsion shot-noise properties
- `torsion_increases` — adding a contradiction strictly raises torsion
- `stationaryMean_pos`, `stationaryVariance_pos` — positivity of expressions defined to be α/λ and α/(3λ³); the file does not derive these formulas from Campbell's theorem
- `stationaryVariance_antitone` — variance decreases as regularization scale grows
- `moments_scaling_relation` — Var = Mean / (3λ²)
- `torsion_monotonicity` — collapse probability strictly decreasing in torsion shift
- `postShannon_is_epistemic_collapse` — R - τ ≥ ε is exactly the abstract collapse condition by definition

Based on: Anson (2026), *From Bit to Boundary: A Geometric Theory of Information Collapse*.

### `CoherenceMathematics.lean`
Chart III instantiation. Config = CoherenceVec (4-dimensional alignment space). Proves:
- `coherenceNorm_nonneg` — weighted coherence norm is nonneg
- `constraint_noncommutative` — constraint application order matters (concrete witness)
- `lyapunov_nonneg`, `lyapunov_zero_iff` — Lyapunov function characterizes convergence target exactly
- `overflow_no_convergence` — overflow implies no Lyapunov zero in feasible region
- `veto_sound`, `veto_complete` — veto operator is sound and complete for sovereignty
- `coherenceFrame_nontriviality` — frame has a collapsed configuration under low constraint pressure

Based on: Anson (2025), *Coherence Mathematics: A Rigorous Foundation for Asymmetric Recursion*.

---

## Running the Proofs

### Web Editor (recommended for verification)
1. Go to [live.lean-lang.org](https://live.lean-lang.org)
2. Select **Mathlib** from the dropdown
3. Paste any file — each is self-contained
4. Wait for initialization (~60 seconds)
5. Green = verified. Axioms show as warnings, not errors.

### Local (VS Code + Lean 4 extension)
```bash
# Prerequisite: elan installed
lake exe cache get
lake build
```
Run these commands from the repository root. The committed `lean-toolchain`, `lakefile.toml`, and `lake-manifest.json` pin the Lean and Mathlib versions. `lake exe cache get` downloads Mathlib's compiled files; `lake build` checks all four Lean files.

---

## Epistemic Status of Each Claim

| Theorem | Status | File |
|---|---|---|
| Collapse equivalence (3 conditions) | ✅ Proved | EpistemicPhysics |
| Regime trichotomy | ✅ Proved | EpistemicPhysics |
| Frame transformation algebra | ✅ Proved | EpistemicPhysics |
| Law 1: thermodynamic ceiling n_max | ✅ Proved | PhysicalMathematics |
| Law 2: error bound positivity | ✅ Proved | PhysicalMathematics |
| Law 2: independent monotonicity | ✅ Proved | PhysicalMathematics |
| Laws 1 & 2 coupling | ✅ Proved | PhysicalMathematics |
| Quantum advantage for every positive complexity pair | ⚠️ False as stated; unasserted | PhysicalMathematics |
| Fractal dimension convergence | ⚠️ False as stated; unasserted | PhysicalMathematics |
| Geometric foundation (preliminary encoding) | ⚠️ False as stated; unasserted | PhysicalMathematics |
| Resonance kernel properties | ✅ Proved | CollapseGeometry |
| Torsion shot-noise properties | ✅ Proved | CollapseGeometry |
| Positivity and scaling of defined moment formulas | ✅ Proved | CollapseGeometry |
| Torsion monotonicity | ✅ Proved | CollapseGeometry |
| Post-Shannon = epistemic collapse | ✅ Proved | CollapseGeometry |
| Constraint non-commutativity | ✅ Proved | CoherenceMathematics |
| Lyapunov characterization | ✅ Proved | CoherenceMathematics |
| Overflow detection | ✅ Proved | CoherenceMathematics |
| Veto soundness & completeness | ✅ Proved | CoherenceMathematics |
| Arbitrary-frame nontriviality | ⚠️ False as stated; unasserted | EpistemicPhysics |
| Collapse preservation under frame transformation | ♻️ Derivable | EpistemicPhysics |
| Uniqueness of collapse outcome | ⚠️ False as stated; unasserted | CollapseGeometry |
| Asymmetric recursion convergence | ⚠️ False as stated; unasserted | CoherenceMathematics |
| Sovereignty under override | ♻️ Tautological | CoherenceMathematics |

**📐 Axiom** = a formally declared assumption with a precise type signature and documented proof obligation. Lean permits downstream theorems to use it, but does not verify the axiom itself.

**Unasserted proposition** = a `def ... : Prop` declaration. It names a statement but supplies no proof and adds no assumption to Lean.

**⚠️ False as stated** = the current proposition admits elementary counterexamples and must be revised before it can become a viable conjecture.

**♻️ Derivable/Tautological** = the statement needs no axiom at its current type: it either follows from existing definitions and theorems or simply repeats one of its hypotheses.

---

## Claims Requiring Revision

The following declarations should be strengthened, weakened, or replaced before being treated as genuine open problems.

1. **Frame nontriviality** (`EpistemicPhysics`): false for unrestricted `EpistemicFrame`s. For example, a frame with `C = 0`, `K = 0`, and `Theta = 1` has no collapsed configuration. It is now an unasserted frame property; concrete frames need their own proofs.

2. **Collapse irreversibility** (`EpistemicPhysics`): the current conclusion, `¬ isLatent F' (T.map x)`, follows from `T.preserves_collapse x hc` and the existing theorem `collapsed_not_latent`. If the intended claim concerns information loss, non-injectivity, or positive-measure fibers, those concepts need to appear in a new formal statement.

3. **Uniqueness of collapse outcome** (`CollapseGeometry`): false for arbitrary nonempty finite basis sets because two basis points can have equal resonance—for example, points symmetric around `ψ`. It is now unasserted; a revised theorem needs a unique-nearest-point or no-ties hypothesis.

4. **Asymmetric recursion convergence** (`CoherenceMathematics`): false as stated when `kappa₀ = target`, because the nonnegative Lyapunov function is already zero and cannot strictly decrease. It is now unasserted; a revised statement needs a non-optimal initial-state hypothesis and an explicit recursion or update rule.

5. **Sovereignty preservation under override** (`CoherenceMathematics`): currently states `sovereigntyHolds intent target → sovereigntyHolds intent target`, so it is provable by returning the hypothesis. A substantive version must encode the override dynamics and prove preservation across the resulting state transition.

## Unasserted Research Propositions

The following are defined as `Prop` in `PhysicalMathematics.lean`. Lean does not assume them. Each current statement has a counterexample and needs revision before it can serve as a conjecture.

1. **Quantum complexity reduction** (`conjectureA`): currently asserts strict quantum advantage for every input and every pair of positive complexity functions. Identical constant functions refute it. The intended nonempty-subclass claim is a research direction, not the current Lean statement.

2. **Fractal dimension convergence** (`conjectureB`): as written, this is false. A sequence may remain strictly between 1 and 2 while oscillating indefinitely. The statement needs an additional hypothesis, such as monotonicity together with suitable bounds, or the Cauchy property. Even with monotonicity, extra conditions are needed to ensure that the limit remains strictly inside (1, 2).

3. **Geometric foundation** (`conjectureC`): the intended claim is that every integer relation has a geometric realization preserving its pointwise truth conditions. The present Lean type is false for nonconstant relations: `R_G (φ R)` does not depend on the particular integers `a` and `b`. The Goldbach-graph construction is a motivating example rather than a consequence of this proposition.

---

## For Agents Using This Repo as an IDE Tool

This repo is designed to be used as a formal reasoning substrate. Guidelines:

**What is proved is proved.** Do not treat axioms as proved theorems. The distinction is load-bearing.

**Each file is self-contained.** `EpistemicFrame`, `collapses`, and `collapseMetric` are inlined in Chart files. Do not assume cross-file namespace resolution in the web editor.

**No `sorry` anywhere.** If you introduce `sorry` during development, mark it explicitly and do not present the result as verified until the sorry is closed.

**`λ` is a reserved keyword.** Use `lam` for regularization parameters.

**`positivity` is not omniscient.** For cube positivity (`3 * lam^3 > 0`), use explicit `nlinarith` with `mul_pos` witnesses. For division goals, use `le_div_iff₀` and `div_lt_iff₀` directly.

**The web editor Mathlib snapshot is dated.** Some module paths differ from local Mathlib. Use `import Mathlib` (single line) not granular imports.

**Unproved claims use `def ... : Prop` until their assumptions are sound.** An `axiom` introduces an unverified assumption; `theorem ... sorry` also admits an unverified result. Neither is appropriate for a statement with a known counterexample.

**The collapse condition is `≥` not `>`.** Critical configurations satisfy `collapses`. This is intentional and proved in `critical_collapses`.

---

## How this work was developed

Epistemic Physics was developed through an iterative collaboration between Amber Anson and AI tools. Anson set the research direction and supplied the papers, proposed invariants, definitions, and interpretations. AI assisted with drafting and revising the exposition and translating the mathematical ideas into Lean definitions and proofs.

Anson reviewed the generated work, manually entered the Lean files into the web editor, and worked through errors until they checked without `sorry`. The repository's pinned Lean and Mathlib project was subsequently built locally with Lake. This process documents how the formalization was produced; the Lean proofs establish the encoded mathematical results under their stated assumptions, while the proposed physical interpretation remains an open research question.

---

## References

- Anson, A. (2025). *Physical Mathematics: A Foundational Framework*. AmberContinuum Research.
- Anson, A. (2026). *From Bit to Boundary: A Geometric Theory of Information Collapse* (v4.0). AmberContinuum Research.
- Anson, A. (2025). *Coherence Mathematics: A Rigorous Foundation for Asymmetric Recursion*. AmberContinuum Research.
- Bekenstein, J. D. (1981). Universal upper bound on the entropy-to-energy ratio for bounded systems. *Physical Review D*, 23(2), 287.
- de Moura, L. & Ullrich, S. (2021). The Lean 4 theorem prover and programming language. *CADE 28*, LNCS 12699, 625–635.
- Higham, N. J. (2002). *Accuracy and Stability of Numerical Algorithms*. SIAM.
- Landauer, R. (1961). Irreversibility and heat generation in the computing process. *IBM Journal of Research and Development*, 5(3), 183–191.
- The mathlib Community (2020). The Lean mathematical library. *CPP 2020*, 367–381.

---

## License

© 2025–2026 Amber Anson, AmberContinuum Research. All rights reserved.

The formal proofs in this repository are made available for research verification and inspection. For licensing inquiries: ambercontinuum@gmail.com

---

*The Lean 4 formalization is the proof of record. The process that produced it is the proof of concept.*
