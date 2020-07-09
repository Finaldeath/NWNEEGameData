//::///////////////////////////////////////////////
//:: con_a2_crewnrs
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has Tasina Fled on the Midnight rose and
    left the PC with a full crew?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlotTasina = GetLocalInt(GetModule(), "A2_SPNDRF");
    int iPlotCrew = GetLocalInt(GetModule(), "A2_CREW");

    if ((iPlotTasina >= 70) && (iPlotCrew > 50))
    {
        return TRUE;
    }

    return FALSE;
}
