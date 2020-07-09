//::///////////////////////////////////////////////
//:: con_a2_ioutatt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have the tattooist's IOU.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oIOU = GetItemPossessedBy(oPC, "a2_ioutatt");
    int iResult = FALSE;

    // Does a IOU for the Prison Guard exist in the PC's inventory?
    if (GetIsObjectValid(oIOU) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
