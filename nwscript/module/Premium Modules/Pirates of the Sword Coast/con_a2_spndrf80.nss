//::///////////////////////////////////////////////
//:: con_a2_spndrf80
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC confronts Tasina in the temple but
    lets her leave in peace.

    She flees and takes the statues with her to
    Fiddler's Green.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SPNDRF");

    if(iPlot >= 80)
    {
        return TRUE;
    }

    return FALSE;
}
