//::///////////////////////////////////////////////
//:: con_a0_cargo10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has the cargo plot.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_CARGO");

    if(iStatue >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
