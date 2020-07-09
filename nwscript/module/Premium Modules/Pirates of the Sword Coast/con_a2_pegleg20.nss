//::///////////////////////////////////////////////
//:: con_a2_pegleg20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC Learned of Peg Legs weakness for
    wemon and liquer?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_PEGLEG");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
