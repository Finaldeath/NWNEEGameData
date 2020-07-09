//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Provoke Failure)
//:: WW_Abil_Pro_Fail.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Returns TRUE if attempts to Provoke have
     been failures.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

int StartingConditional()
{
    object oCreature = GetPCSpeaker();
    string sCheckType = "WW_CHECK_TYPE_PROVOKE";
    int bResultTrackedPerCreature = WW_GetIsResultTrackedPerCreature(sCheckType);
    int bFailure;

    //If the result is being tracked per creature...
    if (bResultTrackedPerCreature == TRUE)
    {
        //Pass PCSpeaker to determine creature-specific failure...
        bFailure = WW_GetAbilityCheckFailed(oCreature, sCheckType);
    }
    //If results aren't being tracked per creature...
    else
    {
        //Pass in OBJECT_INVALID to determine generic failure
        bFailure = WW_GetAbilityCheckFailed(OBJECT_INVALID, sCheckType);
    }

    //Return the results of the Failure Check.
    return bFailure;
}
