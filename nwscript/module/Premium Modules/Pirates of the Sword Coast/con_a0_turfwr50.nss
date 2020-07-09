//::///////////////////////////////////////////////
//:: con_a0_turfwr50
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have successfully taken down one of the
    Bloodsailor's hideouts
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_TURFWR");

    if(iStatue >= 50)
    {
        return TRUE;
    }

    return FALSE;

}
