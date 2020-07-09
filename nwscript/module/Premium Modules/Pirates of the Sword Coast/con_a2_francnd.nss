//::///////////////////////////////////////////////
//:: con_a2_francnd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has started but not yet completed
    Sir Francis' plot.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_FRANC");

    if((iPlot < 80) && (iPlot > 0))
    {
        return TRUE;
    }

    return FALSE;

}
