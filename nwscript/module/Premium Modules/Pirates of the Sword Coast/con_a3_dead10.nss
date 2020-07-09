//::///////////////////////////////////////////////
//:: con_a3_dead10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The skull and bones has landed on the Island
    of the Dead. You should probably talk to
    Captain Kolmarr to learn more about his
    ultimate weapon.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_DEAD");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
