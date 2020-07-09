//::///////////////////////////////////////////////
//:: con_a2_vantab30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC solved the puzzle and opened the
    secret passage?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_VANTAB");

    if(iPlot >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
