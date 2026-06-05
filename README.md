# Epistemic Physics — Formal Verification Suite

**Amber Anson · AmberContinuum Research**

This repository contains the Lean 4 (Mathlib) formal verification of the Epistemic Physics framework: a unified collapse theory of truth, meaning, and alignment. Three previously independent research programs — Physical Mathematics, Collapse Geometry, and Coherence Mathematics — are shown to be coordinate charts on a single epistemic manifold, governed by one structural law.

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
├── EpistemicPhysics.lean        # Abstract typeclass layer
├── PhysicalMathematics.lean     # Chart I: Truth collapse
├── CollapseGeometry.lean        # Chart II: Meaning collapse  
├── CoherenceMathematics.lean    # Chart III: Alignment collapse
└── README.md
```

---

## Files

### `EpistemicPhysics.lean`
The abstract layer. Defines `EpistemicFrame` as a typeclass with coherence functional, contradiction functional, and threshold. Proves:
- `epistemicCollapseEquivalence` — the three characterizations of collapse are provably equivalent
- `collapseMetric_mono_coherence/contradiction` — monotonicity in both directions
- `regimes_trichotomy` — every configuration is collapsed, critical, or latent
- `critical_is_boundary` — critical ↔ collapsed AND metric = 1 exactly
- `FrameTransformation` with composition and identity — substrate independence has algebraic structure
- `chart_universality` — collapse implies metric ≥ 1, in any frame

Axioms (honest, with documented proof obligations):
- `frame_nontriviality` — every frame has a collapsed configuration
- `collapse_irreversibility` — requires topology on Config

### `PhysicalMathematics.lean`
Chart I instantiation. Config = ℝ (computational states). Proves:
- `law1_core` — any computation requiring > n_max bits exceeds the physical entropy budget
- `law2_tradeoff` — truncation and rounding errors are independently monotone in opposite directions
- `law2_error_bound_pos` — no finite physical frame achieves zero error
- `optimalStep_pos` — the optimal step size is well-defined and positive
- `laws_coupled` — the precision parameter in Law 2 is bounded by n_max from Law 1

Based on: Landauer (1961), Bekenstein (1981), Higham (2002).

### `CollapseGeometry.lean`
Chart II instantiation. Config = ℝ (scalar Riemannian state). Proves:
- `resonance_pos`, `resonance_le_one`, `resonance_max` — Gaussian kernel properties
- `resonance_strictMono` — resonance is strictly decreasing in distance from basis element
- `contradictionCost_pos`, `contradictionCost_strictMono` — torsion shot-noise properties
- `torsion_increases` — adding a contradiction strictly raises torsion
- `stationaryMean_pos`, `stationaryVariance_pos` — Campbell's theorem moments (E[τ∞] = α/λ, Var[τ∞] = α/3λ³)
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
| Collapse equivalence (3 conditions) | ✅ Proved | EpistemicPhysics |
| Regime trichotomy | ✅ Proved | EpistemicPhysics |
| Frame transformation algebra | ✅ Proved | EpistemicPhysics |
| Law 1: thermodynamic ceiling n_max | ✅ Proved | PhysicalMathematics |
| Law 2: error bound positivity | ✅ Proved | PhysicalMathematics |
| Law 2: independent monotonicity | ✅ Proved | PhysicalMathematics |
| Laws 1 & 2 coupling | ✅ Proved | PhysicalMathematics |
| Resonance kernel properties | ✅ Proved | CollapseGeometry |
| Torsion shot-noise properties | ✅ Proved | CollapseGeometry |
| Stationary moments (Campbell) | ✅ Proved | CollapseGeometry |
| Torsion monotonicity | ✅ Proved | CollapseGeometry |
| Post-Shannon = epistemic collapse | ✅ Proved | CollapseGeometry |
| Constraint non-commutativity | ✅ Proved | CoherenceMathematics |
| Lyapunov characterization | ✅ Proved | CoherenceMathematics |
| Overflow detection | ✅ Proved | CoherenceMathematics |
| Veto soundness & completeness | ✅ Proved | CoherenceMathematics |
| Frame nontriviality | 📐 Axiom | All files |
| Collapse irreversibility | 📐 Axiom | EpistemicPhysics |
| Uniqueness of collapse outcome | 📐 Axiom | CollapseGeometry |
| Asymmetric recursion convergence rate | 📐 Axiom | CoherenceMathematics |
| Sovereignty under override | 📐 Axiom | CoherenceMathematics |

**📐 Axiom** = formally stated with precise type signature, proof obligation documented. Not a sorry. Not a gap. A claim whose proof requires additional Mathlib infrastructure (Riemannian geometry, measure theory, Lipschitz dynamics) and is marked accordingly.

---

## For Agents Using This Repo as an IDE Tool

This repo is designed to be used as a formal reasoning substrate. Guidelines:

**What is proved is proved.** Do not treat axioms as proved theorems. The distinction is load-bearing.

**Each file is self-contained.** `EpistemicFrame`, `collapses`, and `collapseMetric` are inlined in Chart files. Do not assume cross-file namespace resolution in the web editor.

**No `sorry` anywhere.** If you introduce `sorry` during development, mark it explicitly and do not present the result as verified until the sorry is closed.

**`λ` is a reserved keyword.** Use `lam` for regularization parameters. This has already burned time.

**`positivity` is not omniscient.** For cube positivity (`3 * lam^3 > 0`), use explicit `nlinarith` with `mul_pos` witnesses. For division goals, use `le_div_iff₀` and `div_lt_iff₀` directly.

**The web editor Mathlib snapshot is dated.** Some module paths differ from local Mathlib. Use `import Mathlib` (single line) not granular imports.

**Axioms use `axiom` not `theorem ... sorry`.** The difference: `sorry` is a failed proof. `axiom` is a formal assertion. The type signature is the specification a future proof must meet.

**The collapse condition is `≥` not `>`.** Critical configurations satisfy `collapses`. This is intentional and proved in `critical_collapses`.

---

## Proof Obligations (Open Problems)

The following are formally stated but unproved. Contributions welcome.

1. **Collapse irreversibility** (`EpistemicPhysics`): requires a topology on `Config` and a proof that the collapse map `P_B : M → B` is non-injective with positive-measure fibers. The Riemannian geometry needed is in Mathlib but the proof is nontrivial.

2. **Uniqueness of collapse outcome** (`CollapseGeometry`): follows from strict log-concavity of the Gaussian kernel on non-negatively curved manifolds. Requires `Analysis.Geometry.Riemannian` infrastructure.

3. **Asymmetric recursion convergence rate** (`CoherenceMathematics`): the axiom states existence of a Lyapunov-decreasing step. A full convergence proof requires Lipschitz continuity of the constraint functions and a formal recursion model.

4. **Sovereignty preservation under override** (`CoherenceMathematics`): requires a formal dynamics model for the attractor shift at `t_override`. Currently the axiom is trivially true (it states the hypothesis implies itself) — a real proof would derive it from the dynamics.

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
