//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Display Cloud of Bewilderment)
//:: WW_Abil_Bewild_C.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Returns TRUE if the player should see a
     Cloud of Bewilderment Check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 13, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

int StartingConditional()
{
    object oCreature = GetPCSpeaker();
    return WW_GetShouldDisplayAbility("WW_ABILITY_BEWILDERMENT", oCreature);
}
