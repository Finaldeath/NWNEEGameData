//::///////////////////////////////////////////////
//:: con_a1_check
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the player still in Act 1?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iPlotEnd = GetLocalInt(oModule, "A1_ESCP");
    int iPlotStart = GetLocalInt(oModule, "A1_ESCP");
    int iResult = FALSE;

    if ((iPlotEnd < 50) && (iPlotStart > 0))
    {
        iResult = TRUE;
    }

    return iResult;
}
