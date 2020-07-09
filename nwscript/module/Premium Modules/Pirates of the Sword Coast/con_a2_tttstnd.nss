//::///////////////////////////////////////////////
//:: con_a2_tttstnd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC started but no completed the
    Tattooist Jail Plot?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_TTTST");

    if((iPlot < 20) && (iPlot > 0))
    {
        return TRUE;
    }

    return FALSE;

}
