#include "hf_in_plot"

void main()
{
    object oWP = GetWaypointByTag("WP_AR2202_TROLLCHEST");
    SetLocalInt(OBJECT_SELF, "iCheckAttempted", 1);
    effect eStrength = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrength, GetPCSpeaker());
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_trollchest", GetLocation(oWP));
}
