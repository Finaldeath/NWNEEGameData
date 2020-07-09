//::///////////////////////////////////////////////
//:: con_a2_pegleg40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC successfully persuaded PegLeg into
    joining the Crew?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_PEGLEG");

    if(iPlot >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
