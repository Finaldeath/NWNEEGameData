//::///////////////////////////////////////////////
//:: con_a2_midrsend
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC activated but not completed the
    Midnight Rose Plot?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_MIDROSE");

    if((iPlot > 0) && (iPlot < 40))
    {
        return TRUE;
    }

    return FALSE;

}
