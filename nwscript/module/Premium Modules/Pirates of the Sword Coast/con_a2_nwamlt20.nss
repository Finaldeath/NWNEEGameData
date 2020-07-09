//::///////////////////////////////////////////////
//:: con_a2_nwamlt20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC obtained Emerald Amulet on the
    Midnight Rose?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_NWAMLT");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
