//::///////////////////////////////////////////////
//:: con_a1_raftplan
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have the R.A.F.T. plans in their
    inventory?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Dec, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oPlans = GetItemPossessedBy(oPC, "a1_raftplans");
    int iResult = FALSE;

    // Does a head exist in the PC's inventory?
    if (GetIsObjectValid(oPlans) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
