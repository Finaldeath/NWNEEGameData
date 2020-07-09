//::///////////////////////////////////////////////
//:: con_a2_iouxctnr
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have the Executioners IOU.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oIOU = GetItemPossessedBy(oPC, "trs_u_sys_iou001");
    int iResult = FALSE;

    // Does a IOU for the executioner exist in the PC's inventory?
    if (GetIsObjectValid(oIOU) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
