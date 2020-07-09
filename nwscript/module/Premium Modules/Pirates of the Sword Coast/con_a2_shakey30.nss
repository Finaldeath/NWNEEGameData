//::///////////////////////////////////////////////
//:: con_a2_shakey30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC successfully pacified Shaky into
    joining your crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SHAKEY");

    if(iPlot >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
