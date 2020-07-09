// onEnter event for Umgatlik's Prison

#include "hf_in_plot"
#include "hf_in_spawn"

void Enter(object oPC)
{
    object oWP1 = GetObjectByTag("WP_AR2105_GUMBRIL");
    object oGumbril = CreateObject(OBJECT_TYPE_CREATURE, "ks_gumbril", GetLocation(oWP1));
    PlotLevelSet(GetTag(oGumbril), 2);

    object oWP2 = GetObjectByTag("WP_AR2105_UMGATLIK");
    object oUmgatlik = CreateObject(OBJECT_TYPE_CREATURE, "ks_umgatlik", GetLocation(oWP2));
    SpawnLevelupCreature(oUmgatlik, SpawnGetPartyCR(oPC, 75));
    PlotLevelSet(GetTag(oUmgatlik), 0);

    object oWP3 = GetObjectByTag("WP_AR2105_PORTAL");
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_dig_potal", GetLocation(oWP3), FALSE, "ks_dig_potal2");
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MAJOR), oPortal);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_LIGHT_RED_15), oPortal);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD), oPortal);
    SetLocalInt(oPortal, "nExit", 1);
}

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nEntered") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nEntered", 1);
            Enter(oPC);
        }
    }
}
