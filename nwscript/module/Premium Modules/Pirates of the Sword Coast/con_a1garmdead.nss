//::///////////////////////////////////////////////
//:: con_a1garmdead
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC killed Garm?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iGarm = GetLocalInt(GetModule(), "A1_GARMDEAD");

    if(iGarm == 10)
    {
        return TRUE;
    }

    return FALSE;

}
