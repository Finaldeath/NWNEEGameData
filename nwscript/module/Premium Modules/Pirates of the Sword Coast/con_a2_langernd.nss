//::///////////////////////////////////////////////
//:: con_a2_langernd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC started but not completed the
    Longneck Langer plot?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_LANGER");

    if((iPlot < 30) && (iPlot > 0))
    {
        return TRUE;
    }

    return FALSE;

}
