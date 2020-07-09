//::///////////////////////////////////////////////
//:: con_a3_check
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the player still in Act 3?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iPlot = GetLocalInt(oModule, "A2_NECRO");
    int iResult = FALSE;

    if (iPlot >= 40)
    {
        iResult = TRUE;
    }

    return iResult;
}
