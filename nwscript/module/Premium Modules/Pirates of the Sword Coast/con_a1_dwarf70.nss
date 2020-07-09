//::///////////////////////////////////////////////
//:: con_a1_dwarf70
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has Edgrimm has taken offence to your
    threats and decided to kill you?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iDwarf = GetLocalInt(GetModule(), "A1_DWARF");

    if(iDwarf >= 70)
    {
        return TRUE;
    }

    return FALSE;

}
