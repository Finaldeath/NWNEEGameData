//::///////////////////////////////////////////////
//:: con_a1_wrstcs5
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    PC has the Wood and Edgrimm is still alive.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iDwarf = GetLocalInt(GetModule(), "A1_DWARF");
    object oWood = GetItemPossessedBy(oPC, "a1_sacredwood");

    if((GetIsObjectValid(oWood) == TRUE) && (iDwarf == 60))
    {
        return TRUE;
    }

    return FALSE;

}
