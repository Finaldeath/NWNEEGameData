//::///////////////////////////////////////////////
//:: con_a2_crew10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC learned they'll need to collect a
    five man crew to sail away.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_CREW");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
