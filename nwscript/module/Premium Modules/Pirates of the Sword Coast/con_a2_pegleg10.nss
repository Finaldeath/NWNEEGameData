//::///////////////////////////////////////////////
//:: con_a2_pegleg10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC know about the Peg Leg paulson,
    the optional crew member?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_PEGLEG");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
