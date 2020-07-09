//::///////////////////////////////////////////////
//:: con_a1rawmeat
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script checks if the PC speaker has a
    Raw Meat object in their inventory.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oMeat = GetItemPossessedBy(oPC, "a1_rawmeat");
    int iResult = FALSE;

    if (GetIsObjectValid(oMeat) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
