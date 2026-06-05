-- CollapseGeometry.lean
-- Chart II: Collapse Geometry (Meaning Collapse)
-- Amber Anson, AmberContinuum Research
--
-- Self-contained. Paste into https://live.lean-lang.org with Mathlib selected.

import Mathlib

set_option linter.unusedVariables false
set_option linter.unusedSimpArgs false
set_option linter.unusedTactic false
set_option linter.unreachableTactic false

namespace CollapseGeometry

open Real

-- ============================================================
-- §1  EPISTEMIC FRAME (inlined)
-- ============================================================

structure EpistemicFrame where
  Config : Type*
  C      : Config → ℝ
  K      : Config → ℝ
  Theta  : ℝ
  hTheta : 0 < Theta

def collapses (F : EpistemicFrame) (x : F.Config) : Prop :=
  F.C x - F.K x ≥ F.Theta

noncomputable def collapseMetric (F : EpistemicFrame) (x : F.Config) : ℝ :=
  (F.C x - F.K x) / F.Theta

-- ============================================================
-- §2  RESONANCE KERNEL
--
-- All arguments explicit. σ is never implicit.
-- resonance σ ψ b : ℝ
-- ============================================================

noncomputable def resonance (σ ψ b : ℝ) : ℝ :=
  exp (- (ψ - b) ^ 2 / (2 * σ ^ 2))

theorem resonance_pos (σ ψ b : ℝ) :
    0 < resonance σ ψ b := by
  unfold resonance; exact exp_pos _

theorem resonance_le_one (hσ : 0 < σ) (ψ b : ℝ) :
    resonance σ ψ b ≤ 1 := by
  unfold resonance
  rw [← exp_zero]
  apply exp_le_exp.mpr
  apply div_nonpos_of_nonpos_of_nonneg
  · nlinarith [sq_nonneg (ψ - b)]
  · positivity

theorem resonance_max (hσ : 0 < σ) (b : ℝ) :
    resonance σ b b = 1 := by
  unfold resonance
  norm_num

theorem resonance_symm (σ ψ b : ℝ) :
    resonance σ ψ b = resonance σ b ψ := by
  unfold resonance; ring_nf

theorem resonance_strictMono (hσ : 0 < σ) (b ψ₁ ψ₂ : ℝ)
    (h : |ψ₁ - b| < |ψ₂ - b|) :
    resonance σ ψ₂ b < resonance σ ψ₁ b := by
  unfold resonance
  apply exp_lt_exp.mpr
  apply div_lt_div_of_pos_right _ (by positivity)
  nlinarith [sq_abs (ψ₁ - b), sq_abs (ψ₂ - b),
             abs_nonneg (ψ₁ - b), abs_nonneg (ψ₂ - b)]

-- ============================================================
-- §3  TORSION
-- ============================================================

noncomputable def contradictionCost (lam Δt : ℝ) : ℝ :=
  1 / (Δt + lam) ^ 2

theorem contradictionCost_pos (hlam : 0 < lam) (hΔt : 0 ≤ Δt) :
    0 < contradictionCost lam Δt := by
  unfold contradictionCost
  apply div_pos one_pos
  nlinarith [sq_nonneg (Δt + lam)]

theorem contradictionCost_le (hlam : 0 < lam) (hΔt : 0 ≤ Δt) :
    contradictionCost lam Δt ≤ 1 / lam ^ 2 := by
  unfold contradictionCost
  apply div_le_div_of_nonneg_left (by norm_num : (0:ℝ) ≤ 1)
    (by nlinarith [sq_nonneg lam]) (by nlinarith [sq_nonneg (Δt + lam)])

theorem contradictionCost_strictMono (hlam : 0 < lam)
    (hΔt₁ : 0 ≤ Δt₁) (hΔt₂ : 0 ≤ Δt₂) (h : Δt₁ < Δt₂) :
    contradictionCost lam Δt₂ < contradictionCost lam Δt₁ := by
  unfold contradictionCost
  apply div_lt_div_of_pos_left (by norm_num : (0:ℝ) < 1)
    (by nlinarith [sq_nonneg (Δt₁ + lam)])
    (by nlinarith [sq_nonneg (Δt₂ + lam)])

noncomputable def torsion (lam : ℝ) (times : List ℝ) : ℝ :=
  (times.map (contradictionCost lam)).sum

theorem torsion_nonneg (hlam : 0 < lam) (times : List ℝ)
    (h : ∀ t ∈ times, (0 : ℝ) ≤ t) :
    0 ≤ torsion lam times := by
  unfold torsion
  apply List.sum_nonneg
  intro x hx
  simp [List.mem_map] at hx
  obtain ⟨t, ht, rfl⟩ := hx
  exact le_of_lt (contradictionCost_pos hlam (h t ht))

theorem torsion_increases (hlam : 0 < lam) (hΔt : 0 ≤ Δt)
    (times : List ℝ) :
    torsion lam times < torsion lam (Δt :: times) := by
  unfold torsion
  simp
  linarith [contradictionCost_pos hlam hΔt]

-- ============================================================
-- §4  STATIONARY MOMENTS
-- ============================================================

noncomputable def stationaryMean (α lam : ℝ) : ℝ := α / lam

noncomputable def stationaryVariance (α lam : ℝ) : ℝ := α / (3 * lam ^ 3)

theorem stationaryMean_pos (hα : 0 < α) (hlam : 0 < lam) :
    0 < stationaryMean α lam :=
  div_pos hα hlam

theorem stationaryVariance_pos (hα : 0 < α) (hlam : 0 < lam) :
    0 < stationaryVariance α lam := by
  unfold stationaryVariance; apply div_pos hα; positivity

theorem stationaryVariance_antitone (hα : 0 < α)
    (hlam₁ : 0 < lam₁) (hlam₂ : 0 < lam₂) (h : lam₁ < lam₂) :
    stationaryVariance α lam₂ < stationaryVariance α lam₁ := by
  unfold stationaryVariance
  have hd₁ : 0 < 3 * lam₁ ^ 3 := by nlinarith [mul_pos hlam₁ (mul_pos hlam₁ hlam₁)]
  have hd₂ : 0 < 3 * lam₂ ^ 3 := by nlinarith [mul_pos hlam₂ (mul_pos hlam₂ hlam₂)]
  have hord : 3 * lam₁ ^ 3 < 3 * lam₂ ^ 3 := by
    have h12 : lam₁ * lam₁ < lam₂ * lam₂ := by nlinarith
    have h123 : lam₁ * lam₁ * lam₁ < lam₂ * lam₂ * lam₂ := by nlinarith
    nlinarith
  exact div_lt_div_of_pos_left hα hd₁ hord

theorem moments_scaling_relation (hα : 0 < α) (hlam : 0 < lam) :
    stationaryVariance α lam = stationaryMean α lam / (3 * lam ^ 2) := by
  unfold stationaryMean stationaryVariance
  have hlam_ne : lam ≠ 0 := ne_of_gt hlam
  field_simp

-- ============================================================
-- §5  TORSION MONOTONICITY
-- ============================================================

theorem torsion_monotonicity
    (R_val τ_val δ δ' ε : ℝ)
    (hcollapse : R_val - τ_val - δ ≥ ε)
    (hshift : δ < δ') :
    R_val - τ_val - δ' < R_val - τ_val - δ := by linarith

theorem torsion_shift_destroys_collapse
    (R_val τ_val δ ε : ℝ)
    (hcollapse : R_val - τ_val - δ ≥ ε)
    (hε : 0 < ε) (δ' : ℝ)
    (hshift : R_val - τ_val - δ - ε < δ' - δ) :
    R_val - τ_val - δ' < ε := by linarith

-- ============================================================
-- §6  THE COLLAPSE GEOMETRY EPISTEMIC FRAME
-- ============================================================

noncomputable def collapseFrame (σ lam ε : ℝ) (times : List ℝ)
    (hσ : 0 < σ) (hε : 0 < ε) : EpistemicFrame where
  Config := ℝ
  C      := fun ψ => resonance σ ψ 0
  K      := fun _ => torsion lam times
  Theta  := ε
  hTheta := hε

theorem collapseFrame_coherence_pos
    (hσ : 0 < σ) (hε : 0 < ε) (lam : ℝ) (times : List ℝ) (ψ : ℝ) :
    0 < (collapseFrame σ lam ε times hσ hε).C ψ := by
  simp only [collapseFrame]
  exact resonance_pos σ ψ 0

theorem collapseFrame_nontriviality
    (hσ : 0 < σ) (hε : 0 < ε) (hlam : 0 < lam)
    (times : List ℝ)
    (h_nonneg : ∀ t ∈ times, (0 : ℝ) ≤ t)
    (h_low : torsion lam times ≤ 1 - ε) :
    ∃ x : ℝ, collapses (collapseFrame σ lam ε times hσ hε) x := by
  use 0
  unfold collapses collapseFrame
  simp only
  rw [resonance_max hσ]
  linarith [torsion_nonneg hlam times h_nonneg]

-- ============================================================
-- §7  POST-SHANNON BOUNDARY = EPISTEMIC COLLAPSE
-- ============================================================

theorem postShannon_is_epistemic_collapse
    (hσ : 0 < σ) (hε : 0 < ε) (lam : ℝ) (times : List ℝ) (ψ : ℝ) :
    collapses (collapseFrame σ lam ε times hσ hε) ψ ↔
    resonance σ ψ 0 - torsion lam times ≥ ε := by
  unfold collapses collapseFrame
  simp only

-- ============================================================
-- §8  AXIOMATIZED CLAIMS
-- ============================================================

axiom collapse_uniqueness
    (σ ε lam : ℝ) (hσ : 0 < σ) (hε : 0 < ε)
    (times : List ℝ) (ψ : ℝ)
    (B : Finset ℝ) (hB : B.Nonempty) :
    ∃! b ∈ B, ∀ b' ∈ B, b' ≠ b →
      resonance σ ψ b > resonance σ ψ b'

axiom collapse_irreversibility_chartII
    (σ lam ε : ℝ) (hσ : 0 < σ) (hε : 0 < ε)
    (times : List ℝ) (b : ℝ) :
    ∃ ψ₁ ψ₂ : ℝ, ψ₁ ≠ ψ₂ ∧
      resonance σ ψ₁ b ≥ resonance σ ψ₁ 0 ∧
      resonance σ ψ₂ b ≥ resonance σ ψ₂ 0

end CollapseGeometry
