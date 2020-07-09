// bale attacks the player in the beacon inn
// he uses his sword's power to cast stoneskin on himself immediately
// his noble friends are supposed to just sit back and watch

#include "hf_in_plot"
#include "hf_in_npc"

void castStoneskin(object oTarget)
{
    int nCasterLevel = 7;
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration = nCasterLevel;
    int nAmount = nCasterLevel * 10;
    effect eStone = EffectDamageReduction(10, DAMAGE_POWER_PLUS_FIVE, nAmount);
    effect eLink = EffectLinkEffects(eStone, eVis);
    eLink = EffectLinkEffects(eLink, eDur);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
}

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet("Bale", 3);
    PlotLevelSet("Gideon", 3);
    GoHostile(OBJECT_SELF);
    castStoneskin(OBJECT_SELF);
}
