//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (DC 13, Check_Type_Intimidate)
//:: WW_Abil_Intim13.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Always returns TRUE. This script just sets
     Custom Token #83127 to display DC 13
     (Check_Type_Intimidate)

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
    WW_SetBaseAbilityDC(13, oCreature, "WW_CHECK_TYPE_INTIMIDATE");

    //Return TRUE.
    return TRUE;
}
