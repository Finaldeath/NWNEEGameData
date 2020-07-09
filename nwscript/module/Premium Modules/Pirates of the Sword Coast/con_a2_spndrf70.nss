//::///////////////////////////////////////////////
//:: con_a2_spndrf70
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC confronts Tasina in the temple and
    attempts to attack her.

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

    if(iPlot >=70)
    {
        return TRUE;
    }

    return FALSE;
}
