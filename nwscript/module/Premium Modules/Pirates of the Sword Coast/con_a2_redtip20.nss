//::///////////////////////////////////////////////
//:: con_a2_redtip20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the player learned of Red Tip's challenge?
    If the player can defeat him he'll join the
    crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_REDTIP");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
