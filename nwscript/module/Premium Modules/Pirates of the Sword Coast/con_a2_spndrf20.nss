//::///////////////////////////////////////////////
//:: con_a2_spndrf20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has learned that Tasina is actually an
    Umberleen Priestess and has recently arrived
    in Spindrift on an unnamed ship.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SPNDRF");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;
}
