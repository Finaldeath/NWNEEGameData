//::///////////////////////////////////////////////
//:: con_a3_water40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Dweller (Guardian Beast) has destroyed
    the Bridge to the Umberlant temple. The PC
    will have to find another way in.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_WATER");

    if(iPlot >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
