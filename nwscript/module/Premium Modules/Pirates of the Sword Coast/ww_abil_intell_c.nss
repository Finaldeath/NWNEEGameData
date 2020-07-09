//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Display Intelligence)
//:: WW_Abil_Intell_C.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Returns TRUE if the player should see an
     Intelligence Check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 21, 2004
//:://////////////////////////////////////////////
#include "ww_inc"

int StartingConditional()
{
    object oCreature = GetPCSpeaker();
    return WW_GetShouldDisplayAbility("WW_ABILITY_INTELLIGENCE", oCreature);
}
