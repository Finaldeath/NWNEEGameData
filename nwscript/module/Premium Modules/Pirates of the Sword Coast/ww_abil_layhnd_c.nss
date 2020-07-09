//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Display Lay On Hands)
//:: WW_Abil_LayHnd_C.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Returns TRUE if the player should see a
     Lay On Hands Check.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 13, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

int StartingConditional()
{
    object oCreature = GetPCSpeaker();
    return WW_GetShouldDisplayAbility("WW_ABILITY_LAY_HANDS", oCreature);
}
