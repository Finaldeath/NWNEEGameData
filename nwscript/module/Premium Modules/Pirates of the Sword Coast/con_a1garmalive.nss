//::///////////////////////////////////////////////
//:: con_a1garmdead
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC spared Garm?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iGarm = GetLocalInt(GetModule(), "A1_GARMDEAD");

    if(iGarm == 20)
    {
        return TRUE;
    }

    return FALSE;

}
