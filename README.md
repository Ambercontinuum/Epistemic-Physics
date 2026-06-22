# Epistemic Physics — Formal Verification Suite

**Amber Anson · AmberContinuum Research**

---

## What is this?

This repository contains machine-verified mathematical proofs for a new theoretical framework called **Epistemic Physics**. The proofs are written in [Lean 4](https://lean-lang.org/), a proof assistant — software that checks mathematical arguments the way a compiler checks code. Every theorem marked ✅ has been verified by a machine, not just argued by a person.

---

## What is Epistemic Physics?

Epistemic Physics is a framework that asks: *what do truth, meaning, and alignment have in common at a structural level?*

The claim is that all three are instances of the same underlying phenomenon — **collapse**. A system "collapses" when it moves from an unresolved, indeterminate state into a settled, determinate one. A computation produces an answer. A signal acquires a determinate interpretation. An agent arrives at a stable value alignment. These look like very different events, but Epistemic Physics argues they obey the same law.

Three previously independent research programs are brought together here:

| Program | What it studies | Collapse looks like... |
|---|---|---|
| **Physical Mathematics** | Computation under physical constraints | A computation hitting its entropy ceiling and resolving |
| **Collapse Geometry** | Information in geometric/Riemannian space | A signal exceeding the noise threshold and becoming determinate |
| **Coherence Mathematics** | Agent alignment and value stability | A system converging to a stable, sovereign configuration |

The framework proposes that these are not three separate theories. They are three coordinate descriptions of a single underlying structure — what the project calls an *epistemic manifold* — governed by one law.

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

What makes this interesting: truth (in computation), meaning (in geometry), and alignment (in agent dynamics) all satisfy exactly this inequality — in their respective domains, with their respective quantities. The proofs formalize substantial parts of each domain and establish the shared structure explicitly for the geometric and alignment charts; completing the computational chart remains open.

---

## Why formal proof?

Informal mathematical arguments can contain hidden assumptions, subtle errors, or gaps that only become visible when someone tries to apply the result in a new context. Formal proof exposes much of this: a proof assistant like Lean 4 either accepts a proof or rejects it. There is no "mostly right" for what has been encoded — though modeling choices themselves remain open to scrutiny.

The theorems here are **mechanically verified**. This matters especially for a framework that makes claims across multiple domains simultaneously — the formal proofs make the connections precise and checkable, not just suggestive.

Where proofs are not yet complete, this repository marks them honestly as **axioms** (formally stated claims with documented proof obligations) or **conjectures** (speculative claims at the frontier). The distinction is load-bearing. See the [Epistemic Status table](#epistemic-status-of-each-claim) below.

---

## The Law

For any frame F and configuration x:

```
C_F(x) - K_F(x) ≥ Θ_F
```

Where:
- `C_F` — coherence functional (what pulls toward collapse)
- `K_F` — contradiction functional (what resists collapse)
- `Θ_F` — threshold (minimum net coherence for a determinate state)

This is the **Epistemic Collapse Operator**. Truth, meaning, and alignment are all instances of it in different physical substrates.

---

## Repository Structure

```
/
├── EpistemicGround.lean         # Standalone relational-grounding model
├── EpistemicPhysics.lean        # Abstract frame structure and collapse properties
├── PhysicalMathematics.lean     # Chart I: Truth collapse
├── CollapseGeometry.lean        # Chart II: Meaning collapse
├── CoherenceMathematics.lean    # Chart III: Alignment collapse
└── README.md
```

---

## Files

### `EpistemicGround.lean`
A standalone model of relational grounding using the same collapse vocabulary as the other files. Defines:
- `EpistemicFrame` and the collapse operator
- `FrameCoupling` and `groundedBy` — coupling dynamics between frames
- `grounding_theorem` — a direct consequence of the `groundedBy` assumption: a latent configuration in F collapses after the specified map into G
- `ground_is_critical`, `ground_collapses` — under the explicit hypothesis that coherence minus circularity equals the threshold, the self-frame is critical and therefore collapses at the boundary
- `RelationalIntelligence` — formal structure for a system that operates within a frame, recognizes latency, and accesses a grounding frame to resolve it
- `relational_resolution` — a recognized latent configuration collapses in G when the `RelationalIntelligence` structure includes the required grounding assumption
- `grounding_is_not_self_grounding` — despite its name, the current theorem permits `F = G` and derives collapse directly from an assumed self-grounding map; it does not prove that self-grounding is impossible

The interpretation involving a non-closing tower, a biological ground, or Gödelian limits is motivating prose rather than a consequence established by the current theorem.

### `EpistemicPhysics.lean`
The abstract layer. Defines `EpistemicFrame` as a structure with a coherence functional, contradiction functional, and threshold. Proves:
- `epistemicCollapseEquivalence` — the three characterizations of collapse are provably equivalent
- `collapseMetric_mono_coherence/contradiction` — monotonicity in both directions
- `regimes_trichotomy` — every configuration is collapsed, critical, or latent
- `critical_is_boundary` — critical ↔ collapsed AND metric = 1 exactly
- `FrameTransformation` with composition and identity — substrate independence has algebraic structure
- `chart_universality` — collapse implies metric ≥ 1, in any frame

Axiomatized claims requiring revision:
- `frame_nontriviality` — false for an arbitrary frame without assumptions on `C` and `K`
- `collapse_irreversibility` — already follows from `FrameTransformation.preserves_collapse` and `collapsed_not_latent`; no topology is needed for the statement currently encoded

### `PhysicalMathematics.lean`
Physical and numerical results intended to support Chart I. Unlike Charts II and III, this file does not yet define an `EpistemicFrame` instantiation. It proves:
- `law1_core` — any computation requiring > n_max bits exceeds the physical entropy budget
- `law2_tradeoff` — truncation and rounding errors are independently monotone in opposite directions
- `law2_error_bound_pos` — the stated two-term error expression is positive when its coefficients and parameters are positive
- `optimalStep_pos` — the optimal step size is well-defined and positive
- `laws_coupled` — the bit-budget ceiling from Law 1 applies directly to the precision parameter in Law 2

Conjectures (formally stated, speculative):
- `conjectureA_quantum_complexity_reduction` — there exists a nonempty class of inputs on which quantum complexity is strictly less than classical complexity
- `conjectureB_fractal_dimension_convergence` — a sequence remaining in (1, 2) converges to a limit in (1, 2); as currently stated this is false without an additional hypothesis such as monotonicity or the Cauchy property
- `conjectureC_geometric_foundation` — a preliminary formal placeholder for geometric realization; its current type does not yet encode the full pointwise equivalence described in the accompanying paper

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
- `postShannon_is_epistemic_collapse` — R - τ ≥ ε is exactly the abstract collapse condition

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

### Local (VSCode + Lean 4 extension)
```bash
# Prerequisites: elan installed
lake new epistemic-physics
cd epistemic-physics
# Add to lakefile.lean:
#   require mathlib from git "https://github.com/leanprover-community/mathlib4"
lake update
lake build
```
Copy the `.lean` files into the project. **Do not run `lake update` while VSCode is open** — it will download the full Mathlib cache (~8GB) and compete with the language server.

---

## Epistemic Status of Each Claim

| Theorem | Status | File |
|---|---|---|
| Grounding theorem | ✅ Proved | EpistemicGround |
| Ground self-application (critical collapse) | ✅ Proved | EpistemicGround |
| Relational resolution | ✅ Proved | EpistemicGround |
| Self-coupling implication (not tower non-closure) | ✅ Proved | EpistemicGround |
| Collapse equivalence (3 conditions) | ✅ Proved | EpistemicPhysics |
| Regime trichotomy | ✅ Proved | EpistemicPhysics |
| Frame transformation algebra | ✅ Proved | EpistemicPhysics |
| Law 1: thermodynamic ceiling n_max | ✅ Proved | PhysicalMathematics |
| Law 2: error bound positivity | ✅ Proved | PhysicalMathematics |
| Law 2: independent monotonicity | ✅ Proved | PhysicalMathematics |
| Laws 1 & 2 coupling | ✅ Proved | PhysicalMathematics |
| Quantum advantage on a nonempty subclass | 🔬 Conjecture | PhysicalMathematics |
| Fractal dimension convergence (requires revision) | ⚠️ False as stated | PhysicalMathematics |
| Geometric foundation (preliminary encoding) | 🔬 Conjecture | PhysicalMathematics |
| Resonance kernel properties | ✅ Proved | CollapseGeometry |
| Torsion shot-noise properties | ✅ Proved | CollapseGeometry |
| Positivity and scaling of defined moment formulas | ✅ Proved | CollapseGeometry |
| Torsion monotonicity | ✅ Proved | CollapseGeometry |
| Post-Shannon = epistemic collapse | ✅ Proved | CollapseGeometry |
| Constraint non-commutativity | ✅ Proved | CoherenceMathematics |
| Lyapunov characterization | ✅ Proved | CoherenceMathematics |
| Overflow detection | ✅ Proved | CoherenceMathematics |
| Veto soundness & completeness | ✅ Proved | CoherenceMathematics |
| Arbitrary-frame nontriviality | ⚠️ False as stated | EpistemicPhysics |
| Collapse preservation under frame transformation | ♻️ Derivable | EpistemicPhysics |
| Uniqueness of collapse outcome | ⚠️ False as stated | CollapseGeometry |
| Asymmetric recursion convergence | ⚠️ False as stated | CoherenceMathematics |
| Sovereignty under override | ♻️ Tautological | CoherenceMathematics |

**📐 Axiom** = a formally declared assumption with a precise type signature and documented proof obligation. Lean permits downstream theorems to use it, but does not verify the axiom itself.

**🔬 Conjecture** = formally stated as an `axiom` but speculative in content. It is included to mark the boundary of what has been established.

**⚠️ False as stated** = the current axiom admits elementary counterexamples and must not be treated as a viable conjecture until its hypotheses are strengthened.

**♻️ Derivable/Tautological** = the statement needs no axiom at its current type: it either follows from existing definitions and theorems or simply repeats one of its hypotheses.

---

## Axiomatized Claims Requiring Revision

The following declarations should be strengthened, weakened, or replaced before being treated as genuine open problems.

1. **Frame nontriviality** (`EpistemicPhysics`): false for unrestricted `EpistemicFrame`s. For example, a frame with `C = 0`, `K = 0`, and `Theta = 1` has no collapsed configuration. Nontriviality should be a property or hypothesis of a frame, not an axiom about every frame.

2. **Collapse irreversibility** (`EpistemicPhysics`): the current conclusion, `¬ isLatent F' (T.map x)`, follows from `T.preserves_collapse x hc` and the existing theorem `collapsed_not_latent`. If the intended claim concerns information loss, non-injectivity, or positive-measure fibers, those concepts need to appear in a new formal statement.

3. **Uniqueness of collapse outcome** (`CollapseGeometry`): false for arbitrary nonempty finite basis sets because two basis points can have equal resonance—for example, points symmetric around `ψ`. A revised theorem needs a unique-nearest-point or no-ties hypothesis.

4. **Asymmetric recursion convergence** (`CoherenceMathematics`): false as stated when `kappa₀ = target`, because the nonnegative Lyapunov function is already zero and cannot strictly decrease. A revised statement needs a non-optimal initial-state hypothesis and an explicit recursion or update rule.

5. **Sovereignty preservation under override** (`CoherenceMathematics`): currently states `sovereigntyHolds intent target → sovereigntyHolds intent target`, so it is provable by returning the hypothesis. A substantive version must encode the override dynamics and prove preservation across the resulting state transition.

## Conjectures (Open, Speculative)

The following are formally stated in `PhysicalMathematics.lean` as `axiom` but are not proof obligations — they are speculative claims at the boundary of the framework.

1. **Quantum complexity reduction** (`conjectureA`): asserts that there is a nonempty predicate-defined class of inputs on which quantum complexity is strictly less than classical complexity. This is a research direction, not an established complexity-theoretic result.

2. **Fractal dimension convergence** (`conjectureB`): as written, this is false. A sequence may remain strictly between 1 and 2 while oscillating indefinitely. The statement needs an additional hypothesis, such as monotonicity together with suitable bounds, or the Cauchy property. Even with monotonicity, extra conditions are needed to ensure that the limit remains strictly inside (1, 2).

3. **Geometric foundation** (`conjectureC`): the intended claim is that every integer relation has a geometric realization preserving its pointwise truth conditions. The present Lean type is only a placeholder: `R_G (φ R)` does not depend on the particular integers `a` and `b`, so it does not yet faithfully encode the prose claim. The Goldbach-graph construction is a motivating example rather than a consequence of the current axiom.

---

## For Agents Using This Repo as an IDE Tool

This repo is designed to be used as a formal reasoning substrate. Guidelines:

**What is proved is proved.** Do not treat axioms as proved theorems. The distinction is load-bearing.

**Each file is self-contained.** `EpistemicFrame`, `collapses`, and `collapseMetric` are inlined in Chart files. Do not assume cross-file namespace resolution in the web editor.

**No `sorry` anywhere.** If you introduce `sorry` during development, mark it explicitly and do not present the result as verified until the sorry is closed.

**`λ` is a reserved keyword.** Use `lam` for regularization parameters.

**`positivity` is not omniscient.** For cube positivity (`3 * lam^3 > 0`), use explicit `nlinarith` with `mul_pos` witnesses. For division goals, use `le_div_iff₀` and `div_lt_iff₀` directly.

**The web editor Mathlib snapshot is dated.** Some module paths differ from local Mathlib. Use `import Mathlib` (single line) not granular imports.

**Axioms use `axiom` not `theorem ... sorry`.** Both introduce an unverified assumption into the trusted environment, but `axiom` communicates that the assumption is deliberate and exposes its type signature as a future proof obligation.

**The collapse condition is `≥` not `>`.** Critical configurations satisfy `collapses`. This is intentional and proved in `critical_collapses`.

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
