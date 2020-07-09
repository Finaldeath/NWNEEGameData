//::///////////////////////////////////////////////
//:: con_a0_turfwr110
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    With your help the Blood Sailors have
    regained control of the Docks, the turf
    war is over.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_TURFWR");

    if(iStatue >= 110)
    {
        return TRUE;
    }

    return FALSE;

}
