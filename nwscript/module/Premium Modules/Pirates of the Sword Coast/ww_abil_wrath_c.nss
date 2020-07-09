//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Display Divine Wrath)
//:: WW_Abil_Wrath_C.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Returns TRUE if the player should see the
    Divine Wrath ability.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 13, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

int StartingConditional()
{
    object oCreature = GetPCSpeaker();
    return WW_GetShouldDisplayAbility("WW_ABILITY_DIVINE_WRATH", oCreature);
}
