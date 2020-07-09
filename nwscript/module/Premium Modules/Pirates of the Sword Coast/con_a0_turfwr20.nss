//::///////////////////////////////////////////////
//:: con_a0_turfwr20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has been rescued by a group of
    Bloodsailors wandering the area.

    Unfortunately an all out gang war has
    errupted out into the streets.

    You should help out and end the conflict.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_TURFWR");

    if(iStatue >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
