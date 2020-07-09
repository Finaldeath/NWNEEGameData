//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Display Bestow Curse)
//:: WW_Abil_Curse_C.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Returns TRUE if the player should see the
    Bestow Curse ability.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 13, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

int StartingConditional()
{
    object oCreature = GetPCSpeaker();
    return WW_GetShouldDisplayAbility("WW_ABILITY_BESTOW_CURSE", oCreature);
}
