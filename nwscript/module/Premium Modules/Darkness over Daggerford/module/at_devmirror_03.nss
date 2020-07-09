// player has poured quicksilver onto the mirror in AR1108

#include "hf_in_plot"

void main()
{
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_BREACH), OBJECT_SELF);
}
