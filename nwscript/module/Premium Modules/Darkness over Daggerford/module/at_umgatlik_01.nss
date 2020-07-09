#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oVetrixia = GetNearestObjectByTag("ks_vetrixia", oPC);
    if (GetIsDead(oVetrixia))
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_RAISE_DEAD), oVetrixia);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oVetrixia);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(100), oVetrixia);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DAZED_S), oVetrixia);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GLOW_RED), oVetrixia);
        AssignCommand(oVetrixia, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oVetrixia, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 6.0));
        SetLocalInt(oVetrixia, "UNDEAD", 1);
        PlotLevelSet("ks_vetrixia", 5);
    }
}
