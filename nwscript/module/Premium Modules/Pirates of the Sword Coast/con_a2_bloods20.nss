//::///////////////////////////////////////////////
//:: con_a2_bloods20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC's party has Acquired the Scepter
    of Storms
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_BLOODS");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}