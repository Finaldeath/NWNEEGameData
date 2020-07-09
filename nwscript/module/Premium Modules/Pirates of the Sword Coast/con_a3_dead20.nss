//::///////////////////////////////////////////////
//:: con_a3_dead20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Kolmarr has taken the PC to an island were a
    special item that can defeat the priestesses
    lays hidden. The PC will need to find the
    solutions to the magical markers and leave
    a crewman behind to hold them active.

    The PC should talk to Old Tom to acquire
    the necessary provisions.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_DEAD");

    if(iPlot >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
