//:://////////////////////////////////////////////
//:: con_a0_cargo90
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the Statue been levitated and the plot
    resolved?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_CARGO");

    if(iStatue >= 90)
    {
        return TRUE;
    }

    return FALSE;

}
