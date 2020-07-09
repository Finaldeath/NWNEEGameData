//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Bluff: Charm Person Check)
//:: WW_Abil_Blu_Char.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Performs an "Bluff: Charm Person" check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    WW_DoAbilityCheck("WW_ABILITY_CHARM_PERSON", oCreature, "WW_CHECK_TYPE_BLUFF");
}
