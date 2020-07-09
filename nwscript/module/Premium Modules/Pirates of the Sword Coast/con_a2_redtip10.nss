//::///////////////////////////////////////////////
//:: con_a2_redtip10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the player learned of "Red Tip", the
    Minotaur Sailor?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_REDTIP");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
