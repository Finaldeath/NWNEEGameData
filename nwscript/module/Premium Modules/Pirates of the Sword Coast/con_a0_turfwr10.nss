//::///////////////////////////////////////////////
//:: con_a0_turfwr10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has been cornered by a group of thugs
    calling themselves "Black River Bandits".
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_TURFWR");

    if(iStatue >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
