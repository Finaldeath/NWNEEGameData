//::///////////////////////////////////////////////
//:: con_a1_dwarf10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the player has found a map in the sand
    pointing out a Strange Cave to the east
    of the island?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iDwarf = GetLocalInt(GetModule(), "A1_DWARF");

    if(iDwarf >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
