//::///////////////////////////////////////////////
//:: con_a2_whipdnd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC started but not completed the
    Whipped Willigan escape plot?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_WHIPD");

    if ((iPlot < 50) && (iPlot > 0))
    {
        return TRUE;
    }

    return FALSE;

}
