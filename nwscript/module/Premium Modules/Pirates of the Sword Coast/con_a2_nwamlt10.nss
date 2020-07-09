//::///////////////////////////////////////////////
//:: con_a2_nwamlt10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC learned of the Emerald Amulet on the
    Midnight Rose?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_NWAMLT");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
