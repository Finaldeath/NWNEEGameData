//::///////////////////////////////////////////////
//:: con_a2_pegleg30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC given Peg Leg too much to drink?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_PEGLEG");

    if(iPlot >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
