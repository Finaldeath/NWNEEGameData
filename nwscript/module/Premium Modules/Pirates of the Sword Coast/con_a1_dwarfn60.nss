//::///////////////////////////////////////////////
//:: con_a1_dwarfn60
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC not learned that Edgrimm needs wood
    to make a raft?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iDwarf = GetLocalInt(GetModule(), "A1_DWARF");

    if(iDwarf < 60)
    {
        return TRUE;
    }

    return FALSE;

}
