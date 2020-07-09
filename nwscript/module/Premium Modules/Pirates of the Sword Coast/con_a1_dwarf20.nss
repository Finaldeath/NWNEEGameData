//::///////////////////////////////////////////////
//:: con_a1_dwarf20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC received directions from the
    Troglodyte King to a mysterious monster
    cave on the east side of the jungle?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iDwarf = GetLocalInt(GetModule(), "A1_DWARF");

    if(iDwarf >= 20)
    {
        return TRUE;
    }

    return FALSE;

}
