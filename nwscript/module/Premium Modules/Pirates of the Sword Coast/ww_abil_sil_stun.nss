//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Silence: Stunning Fist Check)
//:: WW_Abil_Sil_Stun.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Silence: Stunning Fist" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_STUNNING_FIST", oCreature, "WW_CHECK_TYPE_SILENCE");
}
