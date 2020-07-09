//::///////////////////////////////////////////////
//:: con_a2_rand_rdtp
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Random check if the PC Defeated Redtip in
    the ring? (GrogBeard's hints)
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_REDTIP");
    int iResult = FALSE;

    if ((Random(4) == 0) && (iPlot < 30))
    {
        iResult = TRUE;
    }
    return iResult;
}
