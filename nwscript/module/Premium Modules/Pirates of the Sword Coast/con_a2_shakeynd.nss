//::///////////////////////////////////////////////
//:: con_a2_shakeynd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has started Shakey's plot but not
    completed it.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_SHAKEY");

    if((iPlot < 30) && (iPlot > 0))
    {
        return TRUE;
    }

    return FALSE;

}
