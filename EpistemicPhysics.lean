-- EpistemicPhysics.lean
-- Abstract typeclass for the Epistemic Collapse Framework
-- Amber Anson, AmberContinuum Research
--
-- Paste into https://live.lean-lang.org with Mathlib selected.

import Mathlib

set_option linter.unusedVariables false

namespace EpistemicPhysics

-- ============================================================
-- §1  THE EPISTEMIC FRAME
-- ============================================================

structure EpistemicFrame where
  Config : Type*
  C      : Config → ℝ
  K      : Config → ℝ
  Theta  : ℝ
  hTheta : 0 < Theta

-- ============================================================
-- §2  THE EPISTEMIC COLLAPSE METRIC
-- ============================================================

noncomputable def collapseMetric (F : EpistemicFrame) (x : F.Config) : ℝ :=
  (F.C x - F.K x) / F.Theta

-- ============================================================
-- §3  THE COLLAPSE CONDITION AND REGIMES
-- ============================================================

def collapses (F : EpistemicFrame) (x : F.Config) : Prop :=
  F.C x - F.K x ≥ F.Theta

def isLatent (F : EpistemicFrame) (x : F.Config) : Prop :=
  F.C x - F.K x < F.Theta

def isCritical (F : EpistemicFrame) (x : F.Config) : Prop :=
  F.C x - F.K x = F.Theta

-- ============================================================
-- §4  THE EPISTEMIC COLLAPSE EQUIVALENCE
-- ============================================================

lemma metric_ge_one_iff (F : EpistemicFrame) (x : F.Config) :
    collapseMetric F x ≥ 1 ↔ F.C x - F.K x ≥ F.Theta := by
  unfold collapseMetric
  constructor
  · intro h
    have := (le_div_iff₀ F.hTheta).mp h
    linarith
  · intro h
    rw [ge_iff_le, le_div_iff₀ F.hTheta]
    linarith

theorem epistemicCollapseEquivalence
    (F : EpistemicFrame) (x : F.Config) :
    (collapses F x ↔ F.C x - F.K x ≥ F.Theta) ∧
    (collapseMetric F x ≥ 1 ↔ F.C x - F.K x ≥ F.Theta) ∧
    (collapses F x ↔ collapseMetric F x ≥ 1) :=
  ⟨Iff.rfl, metric_ge_one_iff F x, (metric_ge_one_iff F x).symm⟩

-- ============================================================
-- §5  BASIC PROPERTIES OF THE COLLAPSE METRIC
-- ============================================================

theorem collapseMetric_pos
    (F : EpistemicFrame) (x : F.Config)
    (h : F.C x > F.K x) :
    0 < collapseMetric F x := by
  unfold collapseMetric
  apply div_pos _ F.hTheta
  linarith

theorem collapseMetric_neg
    (F : EpistemicFrame) (x : F.Config)
    (h : F.C x < F.K x) :
    collapseMetric F x < 0 := by
  unfold collapseMetric
  apply div_neg_of_neg_of_pos _ F.hTheta
  linarith

theorem collapseMetric_mono_coherence
    (F : EpistemicFrame) (x y : F.Config)
    (hK : F.K x = F.K y)
    (hC : F.C x < F.C y) :
    collapseMetric F x < collapseMetric F y := by
  unfold collapseMetric
  apply div_lt_div_of_pos_right _ F.hTheta
  linarith

theorem collapseMetric_mono_contradiction
    (F : EpistemicFrame) (x y : F.Config)
    (hC : F.C x = F.C y)
    (hK : F.K x < F.K y) :
    collapseMetric F y < collapseMetric F x := by
  unfold collapseMetric
  apply div_lt_div_of_pos_right _ F.hTheta
  linarith

-- ============================================================
-- §6  THE THREE REGIMES ARE EXHAUSTIVE AND MUTUALLY EXCLUSIVE
-- ============================================================

theorem regimes_trichotomy
    (F : EpistemicFrame) (x : F.Config) :
    collapses F x ∨ isCritical F x ∨ isLatent F x := by
  unfold collapses isCritical isLatent
  rcases lt_trichotomy (F.C x - F.K x) F.Theta with h | h | h
  · exact Or.inr (Or.inr h)
  · exact Or.inr (Or.inl h)
  · exact Or.inl (le_of_lt h)

theorem collapsed_not_latent
    (F : EpistemicFrame) (x : F.Config)
    (hc : collapses F x) : ¬ isLatent F x := by
  unfold collapses isLatent at *
  linarith

-- Note: isCritical satisfies collapses (since C - K = Theta implies C - K ≥ Theta).
-- The meaningful boundary theorem is: critical ↔ collapses ∧ ¬ strictly above threshold.

/-- A critical configuration satisfies the collapse condition
    (it is at the boundary, which counts as collapsed). -/
theorem critical_collapses
    (F : EpistemicFrame) (x : F.Config)
    (h : isCritical F x) : collapses F x := by
  unfold isCritical collapses at *
  linarith

/-- Critical is strictly between latent and strict collapse:
    it satisfies collapse but any perturbation increasing K
    would make it latent. -/
theorem critical_is_boundary
    (F : EpistemicFrame) (x : F.Config) :
    isCritical F x ↔ (collapses F x ∧ collapseMetric F x = 1) := by
  unfold isCritical collapses
  constructor
  · intro h
    refine ⟨by linarith, ?_⟩
    unfold collapseMetric
    rw [h]
    exact div_self (ne_of_gt F.hTheta)
  · intro ⟨_, hm⟩
    unfold collapseMetric at hm
    have := (div_eq_one_iff_eq (ne_of_gt F.hTheta)).mp hm
    linarith

-- ============================================================
-- §7  FRAME TRANSFORMATIONS
-- ============================================================

structure FrameTransformation (F F' : EpistemicFrame) where
  map                : F.Config → F'.Config
  preserves_collapse : ∀ x : F.Config,
    collapses F x → collapses F' (map x)

def FrameTransformation.comp
    {F F' F'' : EpistemicFrame}
    (T  : FrameTransformation F F')
    (T' : FrameTransformation F' F'') :
    FrameTransformation F F'' where
  map               := T'.map ∘ T.map
  preserves_collapse := fun x hx =>
    T'.preserves_collapse _ (T.preserves_collapse x hx)

def FrameTransformation.refl (F : EpistemicFrame) :
    FrameTransformation F F where
  map               := fun x => x
  preserves_collapse := fun _ h => h

-- ============================================================
-- §8  CHART UNIVERSALITY
-- ============================================================

theorem chart_universality
    (F : EpistemicFrame) (x : F.Config)
    (h : collapses F x) :
    collapseMetric F x ≥ 1 :=
  (metric_ge_one_iff F x).mpr h

-- ============================================================
-- §9  OPEN CLAIMS
-- ============================================================

/-- A proposed nontriviality property. False for arbitrary frames;
    concrete instantiations must establish it separately. -/
def frame_nontriviality (F : EpistemicFrame) : Prop :=
  ∃ x : F.Config, collapses F x

/-- Collapse is irreversible under frame transformations.
    Proof obligation: requires topology on Config. -/
axiom collapse_irreversibility
    (F F' : EpistemicFrame)
    (T  : FrameTransformation F F')
    (x  : F.Config)
    (hc : collapses F x) :
    ¬ isLatent F' (T.map x)

end EpistemicPhysics
