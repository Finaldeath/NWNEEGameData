//::///////////////////////////////////////////////
//:: con_a2_rand_frns
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Random check if the PC has yet to gain Francis
    as a crewman? (GrogBeard's hints)
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_FRANC");
    int iResult = FALSE;

    if ((Random(4) == 0) && (iPlot < 70))
    {
        iResult = TRUE;
    }
    return iResult;
}
