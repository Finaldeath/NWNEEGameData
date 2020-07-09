//::///////////////////////////////////////////////
//:: con_a2_spndrf10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has wasted up on the shore of
    Spindrift island.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SPNDRF");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;
}
