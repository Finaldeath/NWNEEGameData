//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Confuse: Cast Mind Fog Check)
//:: WW_Abil_Con_MFog.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Confuse: Cast Mind Fog" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_MIND_FOG", oCreature, "WW_CHECK_TYPE_CONFUSE");
}
