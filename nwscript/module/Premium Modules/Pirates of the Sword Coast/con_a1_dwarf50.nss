//::///////////////////////////////////////////////
//:: con_a1_dwarf50
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has Player has met the mad, Dwarven inventor,
    Edgrimm?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iDwarf = GetLocalInt(GetModule(), "A1_DWARF");

    if(iDwarf >= 50)
    {
        return TRUE;
    }

    return FALSE;

}
