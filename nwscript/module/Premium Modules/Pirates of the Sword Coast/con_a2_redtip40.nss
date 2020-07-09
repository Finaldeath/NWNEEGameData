//::///////////////////////////////////////////////
//:: con_a2_redtip40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has RedTip joined the PC's Crew?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_REDTIP");

    if(iPlot >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
