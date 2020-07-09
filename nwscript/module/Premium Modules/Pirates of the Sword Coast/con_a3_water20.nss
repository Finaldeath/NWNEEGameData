//::///////////////////////////////////////////////
//:: con_a3_water20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has found Allendry and has been
    been made the offer to be taken to the
    sea floor where the Temple (Fiddler's
    green) lays.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "_inc_experience"


int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_WATER");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
