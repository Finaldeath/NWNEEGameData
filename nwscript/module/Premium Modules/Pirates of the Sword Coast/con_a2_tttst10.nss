//::///////////////////////////////////////////////
//:: con_a2_tttst10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC Talked to the Tattooist and heard
    his sob story?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_TTTST");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
