//::///////////////////////////////////////////////
//:: con_a1_dwarf40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the Player has entered the mysterious, trap
    ridden, cave?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iDwarf = GetLocalInt(GetModule(), "A1_DWARF");

    if(iDwarf >= 40)
    {
        return TRUE;
    }

    return FALSE;

}
