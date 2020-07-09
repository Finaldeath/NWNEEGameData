//::///////////////////////////////////////////////
//:: con_a1pctinder
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script checks if the PC speaker has a
    tinder object in their inventory.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    object oTinder = GetItemPossessedBy(oPC, "a1_tinder");
    int iResult = FALSE;

    if (GetIsObjectValid(oTinder) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
