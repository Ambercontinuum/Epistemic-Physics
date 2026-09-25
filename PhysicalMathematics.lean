-- Physical Mathematics: A Foundational Framework
-- Formal Verification of Anson's First and Second Laws
-- Amber Anson, AmberContinuum Research

import Mathlib

set_option linter.unusedVariables false

namespace PhysicalMathematics

open Real

variable {k_B T R E ℏ c : ℝ}

noncomputable def landauerCost (k_B T : ℝ) : ℝ :=
  k_B * T * log 2

noncomputable def bekensteinBound (R E ℏ c : ℝ) : ℝ :=
  (2 * π * R * E) / (ℏ * c)

noncomputable def nMax (R E ℏ c k_B T : ℝ) : ℕ :=
  ⌊bekensteinBound R E ℏ c / (k_B * T * log 2)⌋₊

lemma log_two_pos : 0 < log 2 := by apply log_pos; norm_num

lemma landauerCost_pos (hk_B : 0 < k_B) (hT : 0 < T) :
    0 < landauerCost k_B T :=
  mul_pos (mul_pos hk_B hT) log_two_pos

lemma bekensteinBound_pos (hR : 0 < R) (hE : 0 < E) (hℏ : 0 < ℏ) (hc : 0 < c) :
    0 < bekensteinBound R E ℏ c := by
  unfold bekensteinBound
  apply div_pos _ (mul_pos hℏ hc)
  have : (0 : ℝ) < 2 * π * R * E := by positivity
  linarith

-- ── Law 1 ────────────────────────────────────────────────────────────────────

theorem law1_ratio_pos
    (hR : 0 < R) (hE : 0 < E) (hℏ : 0 < ℏ) (hc : 0 < c)
    (hk_B : 0 < k_B) (hT : 0 < T) :
    0 < bekensteinBound R E ℏ c / (k_B * T * log 2) :=
  div_pos (bekensteinBound_pos hR hE hℏ hc)
          (mul_pos (mul_pos hk_B hT) log_two_pos)

theorem law1_energy_ceiling
    (hk_B : 0 < k_B) (hT : 0 < T) (hE : 0 < E)
    (b : ℕ) (hb : E < b * (k_B * T * log 2)) :
    ¬ (b * (k_B * T * log 2) ≤ E) :=
  not_le.mpr hb

theorem law1_bekenstein_ceiling
    (hR : 0 < R) (hE : 0 < E) (hℏ : 0 < ℏ) (hc : 0 < c)
    (b : ℕ) (hb : bekensteinBound R E ℏ c < b * log 2) :
    ¬ (b * log 2 ≤ bekensteinBound R E ℏ c) :=
  not_le.mpr hb

theorem law1_core
    (hR : 0 < R) (hE : 0 < E) (hℏ : 0 < ℏ) (hc : 0 < c)
    (hk_B : 0 < k_B) (hT : 0 < T)
    (b : ℕ) (hb : nMax R E ℏ c k_B T < b) :
    bekensteinBound R E ℏ c < b * (k_B * T * log 2) := by
  unfold nMax at hb
  have hdenom : 0 < k_B * T * log 2 := mul_pos (mul_pos hk_B hT) log_two_pos
  have hBpos : 0 < bekensteinBound R E ℏ c := bekensteinBound_pos hR hE hℏ hc
  have hpos : 0 < bekensteinBound R E ℏ c / (k_B * T * log 2) :=
    div_pos hBpos hdenom
  have hfloor : (⌊bekensteinBound R E ℏ c / (k_B * T * log 2)⌋₊ : ℝ) ≤
                bekensteinBound R E ℏ c / (k_B * T * log 2) :=
    Nat.floor_le (le_of_lt hpos)
  have hb' : (⌊bekensteinBound R E ℏ c / (k_B * T * log 2)⌋₊ : ℝ) < (b : ℝ) := by
    exact_mod_cast hb
  have hle : bekensteinBound R E ℏ c / (k_B * T * log 2) < (b : ℝ) := by
    have hstep := Nat.lt_floor_add_one (bekensteinBound R E ℏ c / (k_B * T * log 2))
    have hcast : (⌊bekensteinBound R E ℏ c / (k_B * T * log 2)⌋₊ : ℝ) + 1 ≤ (b : ℝ) := by
      exact_mod_cast hb
    linarith
  rw [div_lt_iff₀ hdenom] at hle
  linarith

-- ── Law 2 ────────────────────────────────────────────────────────────────────

variable {C_method C_round h p : ℝ} {q : ℕ}

lemma truncation_pos (hCm : 0 < C_method) (hh : 0 < h) (q : ℕ) :
    0 < C_method * h ^ q :=
  mul_pos hCm (pow_pos hh q)

lemma rounding_pos (hCr : 0 < C_round) (hp : 0 < p) :
    0 < C_round * p⁻¹ :=
  mul_pos hCr (inv_pos.mpr hp)

theorem law2_error_bound_pos
    (hCm : 0 < C_method) (hCr : 0 < C_round)
    (hh : 0 < h) (hp : 0 < p) (q : ℕ) :
    0 < C_method * h ^ q + C_round * p⁻¹ :=
  add_pos (truncation_pos hCm hh q) (rounding_pos hCr hp)

/-- Law 2, Frame Dependence: Each error term responds oppositely to frame changes.
    Decreasing h reduces truncation error but increasing p reduces rounding error.
    These are independent, strictly monotone — the frame is not arbitrary. -/
theorem law2_truncation_monotone
    (hCm : 0 < C_method) (hh₁ : 0 < h₁) (hh_ord : h₁ < h₂) (q : ℕ) (hq : 0 < q) :
    C_method * h₁ ^ q < C_method * h₂ ^ q :=
  mul_lt_mul_of_pos_left
    (pow_lt_pow_left₀ hh_ord (le_of_lt hh₁) (Nat.pos_iff_ne_zero.mp hq)) hCm

theorem law2_rounding_monotone
    (hCr : 0 < C_round) (hp₁ : 0 < p₁) (hp₂ : 0 < p₂) (hp_ord : p₁ < p₂) :
    C_round * p₂⁻¹ < C_round * p₁⁻¹ := by
  apply mul_lt_mul_of_pos_left _ hCr
  have h12 : 0 < p₁ * p₂ := mul_pos hp₁ hp₂
  have hp1inv : p₁⁻¹ = 1 / p₁ := one_div p₁ |>.symm
  have hp2inv : p₂⁻¹ = 1 / p₂ := one_div p₂ |>.symm
  rw [hp1inv, hp2inv]
  have hkey : 1 * p₁ < 1 * p₂ := by nlinarith
  have hd1 : (0 : ℝ) < p₁ := hp₁
  have hd2 : (0 : ℝ) < p₂ := hp₂
  have := div_lt_div_of_pos_left (by norm_num : (0:ℝ) < 1) hp₁ hp_ord
  linarith [this]

theorem law2_tradeoff
    (hCm : 0 < C_method) (hCr : 0 < C_round)
    (hh₁ : 0 < h₁) (hp₁ : 0 < p₁) (hp₂ : 0 < p₂)
    (hh_ord : h₁ < h₂) (hp_ord : p₁ < p₂)
    (q : ℕ) (hq : 0 < q) :
    C_method * h₁ ^ q < C_method * h₂ ^ q ∧
    C_round * p₂⁻¹ < C_round * p₁⁻¹ := by
  exact ⟨law2_truncation_monotone hCm hh₁ hh_ord q hq,
         law2_rounding_monotone hCr hp₁ hp₂ hp_ord⟩

noncomputable def optimalStep (C_method C_round p : ℝ) (q : ℕ) : ℝ :=
  (C_round / (q * C_method * p)) ^ ((1 : ℝ) / (q + 1))

theorem optimalStep_pos
    (hCm : 0 < C_method) (hCr : 0 < C_round) (hp : 0 < p) (q : ℕ) (hq : 0 < q) :
    0 < optimalStep C_method C_round p q := by
  unfold optimalStep
  apply rpow_pos_of_pos
  apply div_pos hCr
  apply mul_pos
  apply mul_pos
  · exact_mod_cast hq
  · exact hCm
  · exact hp

-- ── Coupling ─────────────────────────────────────────────────────────────────

theorem laws_coupled
    (hR : 0 < R) (hE : 0 < E) (hℏ : 0 < ℏ) (hc : 0 < c)
    (hk_B : 0 < k_B) (hT : 0 < T)
    (p : ℕ) (hp : nMax R E ℏ c k_B T < p) :
    bekensteinBound R E ℏ c < p * (k_B * T * log 2) :=
  law1_core hR hE hℏ hc hk_B hT p hp

-- ── Unasserted research claims ───────────────────────────────────────────────

-- False for arbitrary positive functions (e.g. identical constant functions).
def conjectureA_quantum_complexity_reduction
    (C_classical C_quantum : ℕ → ℝ) : Prop :=
    (∀ n, 0 < C_classical n) →
    (∀ n, 0 < C_quantum n) →
    ∀ n, C_quantum n < C_classical n

-- Boundedness in (1, 2) alone does not imply convergence.
def conjectureB_fractal_dimension_convergence
    (D : ℕ → ℝ) : Prop :=
    (∀ n, 1 < D n ∧ D n < 2) →
    ∃ (D_H : ℝ), 1 < D_H ∧ D_H < 2 ∧ Filter.Tendsto D Filter.atTop (nhds D_H)

-- The right side does not depend on a or b, so this is false for nonconstant R.
def conjectureC_geometric_foundation
    (R : ℤ → ℤ → Prop)
    (R_G : (ℤ → ℤ → Prop) → Prop) : Prop :=
    ∃ (φ : (ℤ → ℤ → Prop) → (ℤ → ℤ → Prop)),
      ∀ (a b : ℤ), R a b ↔ R_G (φ R)

end PhysicalMathematics
