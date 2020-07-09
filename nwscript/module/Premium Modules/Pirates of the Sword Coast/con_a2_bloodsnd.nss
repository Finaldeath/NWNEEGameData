//::///////////////////////////////////////////////
//:: con_a2_bloodsnd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has Started but not completed
    Vengaul Bloodsails treasure plot.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_BLOODS");

    if ((iPlot < 30) && (iPlot > 0))
    {
        return TRUE;
    }

    return FALSE;

}
