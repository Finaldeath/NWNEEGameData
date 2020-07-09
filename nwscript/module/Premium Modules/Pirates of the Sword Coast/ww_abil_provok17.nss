//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (DC 17, Check_Type_Provoke)
//:: WW_Abil_Provok17.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Always returns TRUE. This script just sets
     Custom Token #83127 to display DC 17
     (Check_Type_Provoke)

     NOTE: The AutoDC system, which defaults to
           ON, will override this value.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 13, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

int StartingConditional()
{
    object oCreature = GetPCSpeaker();
    WW_SetBaseAbilityDC(17, oCreature, "WW_CHECK_TYPE_PROVOKE");

    //Return TRUE.
    return TRUE;
}
