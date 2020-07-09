//::///////////////////////////////////////////////
//:: con_a2_crewrs
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the Midnight Rose still in port and the
    player has a full crew?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlotTasina = GetLocalInt(GetModule(), "A2_SPNDRF");
    int iPlotCrew = GetLocalInt(GetModule(), "A2_CREW");

    if ((iPlotTasina < 70) && (iPlotCrew > 50))
    {
        return TRUE;
    }

    return FALSE;
}
