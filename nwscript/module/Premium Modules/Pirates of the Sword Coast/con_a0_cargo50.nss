//:://////////////////////////////////////////////
//:: con_a0_cargo50
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC convinced the Dock Hands to move the
    statue, and therefore resolved the Plot?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_CARGO");

    if(iStatue >= 50)
    {
        return TRUE;
    }

    return FALSE;

}
