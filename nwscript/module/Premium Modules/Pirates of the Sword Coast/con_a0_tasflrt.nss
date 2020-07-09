//::///////////////////////////////////////////////
//:: con_a0_tasflrt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    PC Successfully flirted with Tasina while on
    the escort mission.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: March, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iFlag = GetLocalInt(oModule, "POTSC_A0_TASINAFLIRT");
    int iResult = FALSE;

    if (iFlag == TRUE)
    {
        iResult == FALSE;
    }

    return iResult;
}
