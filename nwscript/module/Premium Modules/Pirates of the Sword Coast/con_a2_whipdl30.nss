//::///////////////////////////////////////////////
//:: con_a2_whipdl30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has willigan not explained the situation to
    the PC?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_WHIPD");

    if (iPlot < 30)
    {
        return TRUE;
    }

    return FALSE;

}
