//::///////////////////////////////////////////////
//:: con_a2_nwamlt30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC Delivered the Emerald Amulet from
    the Midnight Rose?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_NWAMLT");

    if(iPlot >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
