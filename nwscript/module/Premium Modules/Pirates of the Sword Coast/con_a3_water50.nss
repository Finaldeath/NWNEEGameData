//::///////////////////////////////////////////////
//:: con_a3_water50
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    After finding yourself in the center of a
    feeding frenzy a Bone dragon appears and
    fends off the sharks.

    He offeres you passage into the temple, as
    long as you make him a promise.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_WATER");

    if(iPlot >= 50)
    {
        return TRUE;
    }

    return FALSE;

}
