//::///////////////////////////////////////////////
//:: con_a1_dwarf80
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the Player has fought and Killed the
    Crazed inventor and captured the plans?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iDwarf = GetLocalInt(GetModule(), "A1_DWARF");

    if(iDwarf >= 80)
    {
        return TRUE;
    }

    return FALSE;

}
