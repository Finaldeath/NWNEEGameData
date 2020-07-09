//::///////////////////////////////////////////////
//:: con_a2_ioumyr
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have the mayor's IOU.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oIOU = GetItemPossessedBy(oPC, "trs_u_sys_iou002");
    int iResult = FALSE;

    // Does a IOU for the Prison Guard exist in the PC's inventory?
    if (GetIsObjectValid(oIOU) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
