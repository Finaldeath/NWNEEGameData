//:://////////////////////////////////////////////
//:: con_a0_cargo80
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC found the spell component required
    for Rahman's Levitation spell?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_CARGO");

    if(iStatue >= 80)
    {
        return TRUE;
    }

    return FALSE;

}
