//::///////////////////////////////////////////////
//:: con_a1_noscrdwd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script checks if the PC Speaker does not
    yet have the Sacred Wood object in their
    inventory.
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

    if (GetIsObjectValid(oWood) == FALSE)
    {
        iResult = TRUE;
    }

    return iResult;
}
