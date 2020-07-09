//::///////////////////////////////////////////////
//:: con_a2_check
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the player still in Act 2?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iPlotEnd = GetLocalInt(oModule, "A2_NECRO");
    int iPlotStart = GetLocalInt(oModule, "A2_SPNDRF");
    int iResult = FALSE;

    if ((iPlotEnd < 40) && (iPlotStart > 0))
    {
        iResult = TRUE;
    }

    return iResult;
}
