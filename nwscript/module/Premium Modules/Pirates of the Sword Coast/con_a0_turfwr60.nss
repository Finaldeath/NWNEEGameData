//::///////////////////////////////////////////////
//:: con_a0_turfwr60
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have successfully taken down two of the
    Blackriver bandits hideouts
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_TURFWR");

    if(iStatue >= 60)
    {
        return TRUE;
    }

    return FALSE;

}
