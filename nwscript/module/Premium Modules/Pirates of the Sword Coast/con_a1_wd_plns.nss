//::///////////////////////////////////////////////
//:: con_a1_wd_plns
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Player has both the wood and the plans.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oPlans = GetItemPossessedBy(oPC, "a1_raftplans");
    object oWood = GetItemPossessedBy(oPC, "a1_sacredwood");
    int iResult = FALSE;

    // The player has both the raft and the plans.
    if ( (GetIsObjectValid(oWood) == TRUE) && (GetIsObjectValid(oPlans) == TRUE))
    {
        iResult = TRUE;
    }

    return iResult;
}
