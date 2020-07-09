//::///////////////////////////////////////////////
//:: con_a0_turfwr80
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have successfully taken down three of
    the Blackriver bandits hideouts
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_TURFWR");

    if(iStatue >= 80)
    {
        return TRUE;
    }

    return FALSE;

}
