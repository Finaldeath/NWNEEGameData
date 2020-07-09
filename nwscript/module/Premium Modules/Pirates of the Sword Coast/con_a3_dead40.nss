//::///////////////////////////////////////////////
//:: con_a3_dead40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The captain has made the PC undead as well as
    the crew of the. The only strange part is
    that the PC isn't under the control of the
    Captain, like all the others.

    A battle begins and the PC must fight for his
    Un-Life or be destroyed.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_DEAD");

    if(iPlot >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
