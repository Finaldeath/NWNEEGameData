//::///////////////////////////////////////////////
//:: con_a1_dwarf90
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the Player has taken the Stolen wood to
    Edgrimm?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iDwarf = GetLocalInt(GetModule(), "A1_DWARF");

    if(iDwarf >= 90)
    {
        return TRUE;
    }

    return FALSE;

}
