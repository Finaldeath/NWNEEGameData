//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Display Persuade)
//:: ww_abil_prstsn.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Returns TRUE if the player should see a
     Persuade Check and the Rose has not yet
     left Harbor.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 13, 2003
//:://////////////////////////////////////////////
//:: Modified By: Keith K2 Hayward
//:: Modified On: Feb 3, 2005
//:://////////////////////////////////////////////

#include "ww_inc"

int StartingConditional()
{
    object oCreature = GetPCSpeaker();
    int iPlot = GetLocalInt(GetModule(), "A2_MIDROSE");
    int iCheck = WW_GetShouldDisplayAbility("WW_ABILITY_PERSUADE", oCreature);

    if ((iPlot < 40) && (iCheck == TRUE))
    {
        return TRUE;
    }

    return FALSE;
}
