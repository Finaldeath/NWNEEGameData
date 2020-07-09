//::///////////////////////////////////////////////
//:: con_a1_scrdwood
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script checks if the PC Speaker has a
    Sacred Wood object in their inventory.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    object oWood = GetItemPossessedBy(oPC, "a1_sacredwood");
    int iResult = FALSE;

    if (GetIsObjectValid(oWood) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
