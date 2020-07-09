//::///////////////////////////////////////////////
//:: con_a0_turfwr40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have successfully taken down one of the
    Blackriver bandit's hideouts
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_TURFWR");

    if(iStatue >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
