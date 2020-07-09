//:://////////////////////////////////////////////
//:: con_a0_cargo70
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC suggested that Rahman should go and
    Levitate the Statue into position?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_CARGO");

    if(iStatue >= 70)
    {
        return TRUE;
    }

    return FALSE;

}
