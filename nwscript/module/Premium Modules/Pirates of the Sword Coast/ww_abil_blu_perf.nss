//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Bluff: Perform Check)
//:: WW_Abil_Blu_Perf.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Bluff: Perform" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_PERFORM", oCreature, "WW_CHECK_TYPE_BLUFF");
}
