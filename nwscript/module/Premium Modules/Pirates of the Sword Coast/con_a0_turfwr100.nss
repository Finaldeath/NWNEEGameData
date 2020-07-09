//::///////////////////////////////////////////////
//:: con_a0_turfwr100
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    With your help the Black River Bandits have
    taken control of the Docks, the turf war is
    over.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_TURFWR");

    if(iStatue >= 100)
    {
        return TRUE;
    }

    return FALSE;

}
