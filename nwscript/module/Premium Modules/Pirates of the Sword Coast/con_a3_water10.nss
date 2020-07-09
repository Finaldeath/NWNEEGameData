//::///////////////////////////////////////////////
//:: con_a3_water10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Player has emerged from the Seiged
    Skull and Bones to find the Midnight Rose
    pulled up alone side her.

    There is no island, only the Midnight Rose
    floating alone in the waters.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_WATER");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
