//::///////////////////////////////////////////////
//:: con_a2_blackr20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC completed the Heist for the NPC?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_BLACKR");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}