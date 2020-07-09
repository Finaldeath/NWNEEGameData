//::///////////////////////////////////////////////
//:: con_a0_mbsh30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has walked into Dela's trap and
    been abushed in the Alley way.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iDelaPlot = GetLocalInt(GetModule(), "A0_AMBUSH");
    int iResult = FALSE;

    if (iDelaPlot == 30)
    {
        iResult = TRUE;
    }

    return iResult;
}
