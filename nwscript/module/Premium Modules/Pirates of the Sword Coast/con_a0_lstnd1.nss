//::///////////////////////////////////////////////
//:: con_a0_lstnd1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the Player has ever failed the
    listen check at Alledry's door.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iFlag = GetLocalInt(oModule, "cac_a0_lstnd1");
    int iResult = FALSE;

    if (iFlag == FALSE)
    {
        iResult = TRUE;
    }

    return iResult;
}
