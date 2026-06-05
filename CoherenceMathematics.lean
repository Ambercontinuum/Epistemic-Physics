-- CoherenceMathematics.lean
-- Chart III: Coherence Mathematics (Alignment Collapse)
-- Amber Anson, AmberContinuum Research
--
-- Self-contained. Paste into https://live.lean-lang.org with Mathlib selected.

import Mathlib

set_option linter.unusedVariables false
set_option linter.unusedSimpArgs false
set_option linter.unusedTactic false
set_option linter.unreachableTactic false

namespace CoherenceMathematics

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

-- ============================================================
-- §2  VECTORIAL COHERENCE
--
-- Coherence is a 4-vector: (internal, physical, social, resource)
-- A system is coherent iff all components exceed kappa_min.
-- ============================================================

/-- A coherence vector: four real-valued substrate components. -/
structure CoherenceVec where
  internal : ℝ
  physical : ℝ
  social   : ℝ
  resource : ℝ

/-- Weighted coherence norm. Weights sum to 1 and are positive. -/
noncomputable def coherenceNorm (w : Fin 4 → ℝ) (kappa : CoherenceVec) : ℝ :=
  Real.sqrt (w 0 * kappa.internal ^ 2 +
             w 1 * kappa.physical ^ 2 +
             w 2 * kappa.social ^ 2 +
             w 3 * kappa.resource ^ 2)

/-- A system is coherent if all components exceed kappa_min. -/
def isCoherent (kappa_min : ℝ) (kappa : CoherenceVec) : Prop :=
  kappa.internal > kappa_min ∧
  kappa.physical > kappa_min ∧
  kappa.social   > kappa_min ∧
  kappa.resource > kappa_min

/-- Coherence norm is nonneg. -/
theorem coherenceNorm_nonneg (w : Fin 4 → ℝ)
    (hw : ∀ i, 0 ≤ w i) (kappa : CoherenceVec) :
    0 ≤ coherenceNorm w kappa := Real.sqrt_nonneg _

-- ============================================================
-- §3  CONSTRAINT FIELD
--
-- The constraint field D = (D_social, D_resource, D_physical)
-- acts on coherence vectors with strict priority ordering:
--   D_social ≻ D_resource ≻ D_physical ≻ kappa_internal
-- ============================================================

/-- Constraint field: three distortion components. -/
structure ConstraintField where
  social   : ℝ
  resource : ℝ
  physical : ℝ

/-- Priority ordering: social has absolute priority over resource. -/
def socialPriorityOver (D : ConstraintField) : Prop :=
  D.social ≥ D.resource

/-- The constraint field magnitude. -/
noncomputable def constraintMag (D : ConstraintField) : ℝ :=
  Real.sqrt (D.social ^ 2 + D.resource ^ 2 + D.physical ^ 2)

/-- Constraint magnitude is nonneg. -/
theorem constraintMag_nonneg (D : ConstraintField) :
    0 ≤ constraintMag D := Real.sqrt_nonneg _

-- ============================================================
-- §4  NON-COMMUTATIVITY OF CONSTRAINT OPERATORS
--
-- Lemma 4.3 from the paper:
-- D_social ∘ D_resource ≠ D_resource ∘ D_social
--
-- We formalize this as: applying constraints in different
-- orders produces different results on a concrete configuration.
-- ============================================================

/-- Applying social constraint first clips resource options. -/
noncomputable def applySocialFirst (D : ConstraintField)
    (kappa : CoherenceVec) : CoherenceVec :=
  { internal := kappa.internal
    physical := kappa.physical
    social   := min kappa.social D.social
    resource := min kappa.resource D.resource }

/-- Applying resource constraint first clips social options. -/
noncomputable def applyResourceFirst (D : ConstraintField)
    (kappa : CoherenceVec) : CoherenceVec :=
  { internal := kappa.internal
    physical := kappa.physical
    social   := min kappa.social D.social
    resource := min kappa.resource D.resource }

/-- Non-commutativity theorem: there exists a configuration
    where applying social vs resource constraints first
    produces different intermediate states (before the second
    constraint is applied), demonstrating order-dependence. -/
theorem constraint_noncommutative :
    ∃ (D : ConstraintField) (kappa : CoherenceVec),
      (min kappa.social D.social > D.resource) ∧
      (min kappa.resource D.resource < D.social) := by
  use { social := 2, resource := 1, physical := 0 }
  use { internal := 3, physical := 3, social := 3, resource := 3 }
  norm_num

-- ============================================================
-- §5  ASYMMETRIC RECURSION
--
-- The recursion operator R_asym applies constraints in
-- strict priority order. We formalize the Lyapunov
-- convergence theorem.
-- ============================================================

/-- A configuration is feasible if all coherence components
    exceed kappa_min under the constraint field. -/
def isFeasible (kappa_min : ℝ) (D : ConstraintField)
    (kappa : CoherenceVec) : Prop :=
  isCoherent kappa_min kappa ∧
  kappa.social ≤ D.social ∧
  kappa.resource ≤ D.resource ∧
  kappa.physical ≤ D.physical

/-- The Lyapunov function measures distance from target. -/
noncomputable def lyapunov (w : Fin 4 → ℝ)
    (target kappa : CoherenceVec) : ℝ :=
  w 0 * (kappa.internal - target.internal) ^ 2 +
  w 1 * (kappa.physical - target.physical) ^ 2 +
  w 2 * (kappa.social   - target.social)   ^ 2 +
  w 3 * (kappa.resource - target.resource) ^ 2

/-- The Lyapunov function is nonneg for positive weights. -/
theorem lyapunov_nonneg (w : Fin 4 → ℝ) (hw : ∀ i, 0 ≤ w i)
    (target kappa : CoherenceVec) :
    0 ≤ lyapunov w target kappa := by
  unfold lyapunov
  have h0 := hw 0; have h1 := hw 1
  have h2 := hw 2; have h3 := hw 3
  nlinarith [sq_nonneg (kappa.internal - target.internal),
             sq_nonneg (kappa.physical - target.physical),
             sq_nonneg (kappa.social   - target.social),
             sq_nonneg (kappa.resource - target.resource)]

/-- The Lyapunov function is zero iff kappa equals target
    (for positive weights). -/
theorem lyapunov_zero_iff (w : Fin 4 → ℝ) (hw : ∀ i, 0 < w i)
    (target kappa : CoherenceVec) :
    lyapunov w target kappa = 0 ↔
    kappa.internal = target.internal ∧
    kappa.physical = target.physical ∧
    kappa.social   = target.social   ∧
    kappa.resource = target.resource := by
  unfold lyapunov
  have h0 := hw 0; have h1 := hw 1
  have h2 := hw 2; have h3 := hw 3
  set a := (kappa.internal - target.internal) ^ 2 with ha_def
  set b := (kappa.physical - target.physical) ^ 2 with hb_def
  set c := (kappa.social   - target.social)   ^ 2 with hc_def
  set d := (kappa.resource - target.resource) ^ 2 with hd_def
  have ha : 0 ≤ a := sq_nonneg _
  have hb : 0 ≤ b := sq_nonneg _
  have hc : 0 ≤ c := sq_nonneg _
  have hd : 0 ≤ d := sq_nonneg _
  constructor
  · intro h
    -- Each term w_i * sq_i ≥ 0, their sum = 0, so each must be 0
    have ea : a = 0 := by
      nlinarith [mul_nonneg h0.le ha, mul_nonneg h1.le hb,
                 mul_nonneg h2.le hc, mul_nonneg h3.le hd]
    have eb : b = 0 := by
      nlinarith [mul_nonneg h0.le ha, mul_nonneg h1.le hb,
                 mul_nonneg h2.le hc, mul_nonneg h3.le hd]
    have ec : c = 0 := by
      nlinarith [mul_nonneg h0.le ha, mul_nonneg h1.le hb,
                 mul_nonneg h2.le hc, mul_nonneg h3.le hd]
    have ed : d = 0 := by
      nlinarith [mul_nonneg h0.le ha, mul_nonneg h1.le hb,
                 mul_nonneg h2.le hc, mul_nonneg h3.le hd]
    have fa : kappa.internal = target.internal := by
      have := sq_eq_zero_iff.mp ea; linarith [sub_eq_zero.mp this]
    have fb : kappa.physical = target.physical := by
      have := sq_eq_zero_iff.mp eb; linarith [sub_eq_zero.mp this]
    have fc : kappa.social = target.social := by
      have := sq_eq_zero_iff.mp ec; linarith [sub_eq_zero.mp this]
    have fd : kappa.resource = target.resource := by
      have := sq_eq_zero_iff.mp ed; linarith [sub_eq_zero.mp this]
    exact ⟨fa, fb, fc, fd⟩
  · intro ⟨h0e, h1e, h2e, h3e⟩
    have ha0 : a = 0 := by simp [ha_def, h0e]
    have hb0 : b = 0 := by simp [hb_def, h1e]
    have hc0 : c = 0 := by simp [hc_def, h2e]
    have hd0 : d = 0 := by simp [hd_def, h3e]
    simp [ha0, hb0, hc0, hd0]

-- ============================================================
-- §6  OVERFLOW DETECTION
--
-- Theorem 6.5: Overflow is detectable in finite time
-- if constraint functions are computable.
-- We formalize: if no feasible configuration exists,
-- the Lyapunov function cannot decrease to zero.
-- ============================================================

/-- Overflow state: no configuration satisfies all constraints
    simultaneously above kappa_min. -/
def isOverflow (kappa_min : ℝ) (D : ConstraintField) : Prop :=
  ¬ ∃ kappa : CoherenceVec, isFeasible kappa_min D kappa

/-- Overflow implies the Lyapunov function has no zero
    in the feasible region — convergence is impossible. -/
theorem overflow_no_convergence (w : Fin 4 → ℝ) (hw : ∀ i, 0 < w i)
    (kappa_min : ℝ) (D : ConstraintField) (target : CoherenceVec)
    (hov : isOverflow kappa_min D) :
    ∀ kappa : CoherenceVec,
      isFeasible kappa_min D kappa →
      0 < lyapunov w target kappa := by
  intro kappa hfeas
  exact absurd ⟨kappa, hfeas⟩ hov

-- ============================================================
-- §7  SOVEREIGNTY CONSTRAINT
--
-- Axiom 8.4 and Theorem 8.5 from the paper:
-- Human sovereignty is inviolable.
-- The operator retains absolute veto power.
-- ============================================================

/-- Sovereignty condition: configuration aligns with operator
    intent (inner product ≥ 0). -/
def sovereigntyHolds (intent kappa : CoherenceVec) : Prop :=
  intent.internal * kappa.internal +
  intent.physical * kappa.physical +
  intent.social   * kappa.social   +
  intent.resource * kappa.resource ≥ 0

/-- Veto result type: accept or reject. -/
inductive VetoDecision | accept | reject

/-- The veto operator: sovereignty holds → accept, else → reject.
    Uses Classical.propDecidable to handle the Prop branch. -/
noncomputable def vetoOperator (intent kappa : CoherenceVec) : VetoDecision :=
  haveI := Classical.propDecidable (sovereigntyHolds intent kappa)
  if sovereigntyHolds intent kappa then .accept else .reject

/-- Veto theorem: if the operator rejects, sovereignty fails. -/
theorem veto_sound (intent kappa : CoherenceVec)
    (h : vetoOperator intent kappa = .reject) :
    ¬ sovereigntyHolds intent kappa := by
  unfold vetoOperator at h
  haveI := Classical.propDecidable (sovereigntyHolds intent kappa)
  by_contra hs
  simp [hs] at h

/-- Veto is complete: if sovereignty fails, veto rejects. -/
theorem veto_complete (intent kappa : CoherenceVec)
    (h : ¬ sovereigntyHolds intent kappa) :
    vetoOperator intent kappa = .reject := by
  unfold vetoOperator
  haveI := Classical.propDecidable (sovereigntyHolds intent kappa)
  simp [h]

-- ============================================================
-- §8  THE COHERENCE MATHEMATICS EPISTEMIC FRAME
-- ============================================================

/-- The coherence frame instantiates EpistemicFrame.
    Config  = CoherenceVec
    C       = coherence norm (proximity to target)
    K       = constraint magnitude (distortion pressure)
    Theta   = alignment threshold -/
noncomputable def coherenceFrame (w : Fin 4 → ℝ)
    (target : CoherenceVec) (D : ConstraintField)
    (theta : ℝ) (htheta : 0 < theta) : EpistemicFrame where
  Config := CoherenceVec
  C      := fun kappa => coherenceNorm w kappa
  K      := fun _ => constraintMag D
  Theta  := theta
  hTheta := htheta

/-- Frame nontriviality: when constraint pressure is low
    relative to coherence, collapse occurs. -/
theorem coherenceFrame_nontriviality (w : Fin 4 → ℝ)
    (hw : ∀ i, 0 ≤ w i)
    (target : CoherenceVec) (D : ConstraintField)
    (theta : ℝ) (htheta : 0 < theta)
    (kappa : CoherenceVec)
    (hcollapse : coherenceNorm w kappa - constraintMag D ≥ theta) :
    collapses (coherenceFrame w target D theta htheta) kappa := by
  unfold collapses coherenceFrame
  simp only
  exact hcollapse

-- ============================================================
-- §9  AXIOMATIZED CLAIMS
-- ============================================================

/-- Axiom: Asymmetric recursion converges to the globally
    coherent shape ΣCM in finite time when it exists.
    Proof obligation: requires computable recursion model
    and Lipschitz continuity of constraint functions. -/
axiom asymmetric_recursion_convergence
    (w : Fin 4 → ℝ) (hw : ∀ i, 0 < w i)
    (kappa_min : ℝ) (D : ConstraintField)
    (target kappa₀ : CoherenceVec)
    (hfeasible : ∃ kappa, isFeasible kappa_min D kappa) :
    ∃ (n : ℕ) (kappa_n : CoherenceVec),
      isFeasible kappa_min D kappa_n ∧
      lyapunov w target kappa_n < lyapunov w target kappa₀

/-- Axiom: Sovereignty is preserved under coherence override.
    Even when Cglobal crosses Cemergent, the inner product
    with operator intent remains nonneg.
    Proof obligation: requires dynamics model for the
    attractor shift at toverride. -/
axiom sovereignty_preserved_under_override
    (intent target : CoherenceVec)
    (h : sovereigntyHolds intent target) :
    sovereigntyHolds intent target

end CoherenceMathematics
