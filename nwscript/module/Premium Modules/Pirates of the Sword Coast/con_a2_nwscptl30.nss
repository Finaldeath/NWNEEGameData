//::///////////////////////////////////////////////
//:: con_a2_nwscptl30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC NOT delivered the Ceremonial Scepter?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_NWSCPT");

    if ((iPlot < 30) && (iPlot > 0))
    {
        return TRUE;
    }

    return FALSE;

}
