//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (DC 16, Check_Type_Pacify)
//:: WW_Abil_Pacify16.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Always returns TRUE. This script just sets
     Custom Token #83127 to display DC 16
     (Check_Type_Pacify)

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
    WW_SetBaseAbilityDC(16, oCreature, "WW_CHECK_TYPE_PACIFY");

    //Return TRUE.
    return TRUE;
}
