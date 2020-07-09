//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Display Animal Empathy)
//:: WW_Abil_AniEmp_C.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Returns TRUE if the player should see an
     Animal Empathy Check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 13, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

int StartingConditional()
{
    object oCreature = GetPCSpeaker();
    return WW_GetShouldDisplayAbility("WW_ABILITY_ANIMAL_EMPATHY", oCreature);
}
