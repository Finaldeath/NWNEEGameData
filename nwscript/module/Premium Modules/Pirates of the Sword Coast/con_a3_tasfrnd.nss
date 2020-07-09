//::///////////////////////////////////////////////
//:: con_a3_tasfrnd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC let Tasina leave while she
    was in Spindrift.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: March, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iFlag = GetLocalInt(oModule, "POTSC_A2_TASINAFRIENDLY");
    int iResult = FALSE;

    if (iFlag == TRUE)
    {
        iResult == FALSE;
    }

    return iResult;
}
