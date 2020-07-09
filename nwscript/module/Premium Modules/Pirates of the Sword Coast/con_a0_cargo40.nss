//:://////////////////////////////////////////////
//:: con_a0_cargo40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC heard about Martins Vision?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_CARGO");

    if(iStatue >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
