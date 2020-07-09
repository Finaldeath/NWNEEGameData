//::///////////////////////////////////////////////
//:: con_a2_francl80
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Francis has not yet joined the crew and is
    still wandering around the fight club.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_FRANC");

    if(iPlot < 80)
    {
        return TRUE;
    }

    return FALSE;

}
