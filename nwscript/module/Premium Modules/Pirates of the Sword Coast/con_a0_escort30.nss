//:://////////////////////////////////////////////
//:: con_a0_escort30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC defeated the Brigands that are
    leading an assault on Tasina's room?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_ESCORT");

    if(iStatue >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
