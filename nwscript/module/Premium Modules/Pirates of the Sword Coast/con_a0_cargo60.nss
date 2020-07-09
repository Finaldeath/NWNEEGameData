//:://////////////////////////////////////////////
//:: con_a0_cargo60
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Did the Dock hands abandon the PC, leaving only
    the PC and Rahman to solve the plot?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_CARGO");

    if(iStatue >= 60)
    {
        return TRUE;
    }

    return FALSE;

}
