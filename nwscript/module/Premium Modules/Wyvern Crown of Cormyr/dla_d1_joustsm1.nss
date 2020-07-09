//::///////////////////////////////////////////////
//:: dla_d1_joustsm1
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Show the visual effect with the map of the shield regions to aim
*/
//:://////////////////////////////////////////////
//:: Create By: Gale
//:: Created On: Jan 22, 2006
//:://////////////////////////////////////////////

#include "dla_i0_const"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    location lMapLocation = GetLocation(GetObjectByTag("WP_shieldregions"));
    object oShieldMap = CreateObject(OBJECT_TYPE_PLACEABLE, "dla_joust_shieldm", lMapLocation);

    effect eVFX = SupernaturalEffect(EffectVisualEffect(VFX_DUR_DLA_SHIELDMAP));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, oShieldMap , 0.0);
    return TRUE;
}
