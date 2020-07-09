//::///////////////////////////////////////////////
//:: con_a3_water30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC is on the ocean floor but has not
    yet seen the Dweller (Guardian Beast).
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "_inc_experience"


int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_WATER");

    if(iPlot >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
