//::///////////////////////////////////////////////
//:: con_a0_cargo20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC heard that Martins has fled the Silver
    sails and is now at the Seedy tavern?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStatue = GetLocalInt(GetModule(), "A0_CARGO");

    if(iStatue >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
