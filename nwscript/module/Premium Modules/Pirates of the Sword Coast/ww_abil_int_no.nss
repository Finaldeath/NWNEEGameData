//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Invalid Intimidate - No Ability)
//:: WW_Abil_Int_No.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Returns TRUE if the check was aborted due to
     the player's lack of the required ability.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 14, 2003
//:://////////////////////////////////////////////
#include "ww_inc"

int StartingConditional()
{
    object oCreature = GetPCSpeaker();
    string sCheckType = "WW_CHECK_TYPE_INTIMIDATE";
    int bResultTrackedPerCreature = WW_GetIsResultTrackedPerCreature(sCheckType);
    int iAbort;

    //If Results are tracked by creature...
    if (bResultTrackedPerCreature == TRUE)
    {
        //Pass in the valid creature to get the creature-specific value
        iAbort = WW_GetAbortedResultValue(sCheckType, oCreature);
        //Clear the Abort Value now that it's been retrieved
        WW_SetLocalIntForCheckTypes(0, "sAbilityResultAborted", sCheckType, oCreature);
    }
    //Otherwise pass in OBJECT_INVALID to get the generic value
    else
    {
        iAbort = WW_GetAbortedResultValue(sCheckType, OBJECT_INVALID);
        //Clear the Abort Value now that it's been retrieved.
        WW_SetLocalIntForCheckTypes(0, "sAbilityResultAborted", sCheckType, OBJECT_INVALID);
    }

    //If the Abort Value = -2 (ie - Player lacked the required Ability)...
    if (iAbort == -2)
    {
        return TRUE;
    }
    return FALSE;
}
