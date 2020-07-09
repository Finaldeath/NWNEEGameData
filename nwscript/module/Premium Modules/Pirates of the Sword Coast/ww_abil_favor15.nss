//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (DC 15, Check_Type_Obtain_Favor)
//:: WW_Abil_Favor15.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Always returns TRUE. This script just sets
     Custom Token #83127 to display DC 15
     (Check_Type_Obtain_Favor)

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
    WW_SetBaseAbilityDC(15, oCreature, "WW_CHECK_TYPE_OBTAIN_FAVOR");

    //Return TRUE.
    return TRUE;
}
