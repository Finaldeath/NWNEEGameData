//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Bluff Success)
//:: WW_Abil_Blu_Succ.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Returns TRUE if attempts to Bluff have
     been successful.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

int StartingConditional()
{
    object oCreature = GetPCSpeaker();
    string sCheckType = "WW_CHECK_TYPE_BLUFF";
    int bResultTrackedPerCreature = WW_GetIsResultTrackedPerCreature(sCheckType);
    int bSuccess;

    //If the result is being tracked per creature...
    if (bResultTrackedPerCreature == TRUE)
    {
        //Pass PCSpeaker to determine creature-specific success...
        bSuccess = WW_GetAbilityCheckSuccess(oCreature, sCheckType);
    }
    //If results aren't being tracked per creature...
    else
    {
        //Pass in OBJECT_INVALID to determine generic success
        bSuccess = WW_GetAbilityCheckSuccess(OBJECT_INVALID, sCheckType);
    }

    //Return the results of the Success Check.
    return bSuccess;
}
