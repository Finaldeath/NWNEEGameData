//::///////////////////////////////////////////////
//:: con_a2_nistattd1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the player still in Act 2 but has not yet
    learned about the tattooist or used this
    node before?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iPlot = GetLocalInt(oModule, "A2_TTTST");
    int iPlotEnd = GetLocalInt(oModule, "A2_SPNDRF");
    int iPlotStart = GetLocalInt(oModule, "A2_SPNDRF");
    int iDoOnce = GetLocalInt(oModule, "cac_a2_nistattd1");
    int iResult = FALSE;

    // if in act two, this hasn't fired before, and the tattoist
    // plot isn't active then fire this node.
    if ((iDoOnce == FALSE) && (iPlotEnd < 70) && (iPlotStart > 0) && (iPlot == 0))
    {
        iResult = TRUE;
    }

    return iResult;
}
