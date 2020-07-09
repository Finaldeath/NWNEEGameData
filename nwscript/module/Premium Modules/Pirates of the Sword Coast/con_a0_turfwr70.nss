//::///////////////////////////////////////////////
//:: con_a0_turfwr70
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have successfully taken down two of the
    Bloodsailor's hideouts
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_TURFWR");

    if(iStatue >= 70)
    {
        return TRUE;
    }

    return FALSE;

}
