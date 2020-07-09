//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Bluff: Bluff Check)
//:: WW_Abil_Blu_Blufs.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Bluff: Bluff" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_BLUFF", oCreature, "WW_CHECK_TYPE_BLUFF");
}
