//::///////////////////////////////////////////////
//:: con_a2_vantabnd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC started but not completed the
    Vantabular Puzzle quest.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_VANTAB");

    if((iPlot < 40) && (iPlot > 0))
    {
        return TRUE;
    }

    return FALSE;

}
