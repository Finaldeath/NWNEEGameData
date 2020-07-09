//::///////////////////////////////////////////////
//:: con_a2_redtipnd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has started but not completed Red Tips
    Plot
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_REDTIP");

    if((iPlot < 40) && (iPlot > 0))
    {
        return TRUE;
    }

    return FALSE;

}
