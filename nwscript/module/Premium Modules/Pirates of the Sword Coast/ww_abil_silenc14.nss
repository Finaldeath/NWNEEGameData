//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (DC 14, Check_Type_Silence)
//:: WW_Abil_Silenc.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Always returns TRUE. This script just sets
     Custom Token #83127 to display DC 14
     (Check_Type_Silence)

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
    WW_SetBaseAbilityDC(14, oCreature, "WW_CHECK_TYPE_SILENCE");

    //Return TRUE.
    return TRUE;
}
