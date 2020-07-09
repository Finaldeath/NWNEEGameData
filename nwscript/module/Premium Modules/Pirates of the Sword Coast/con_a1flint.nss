//::///////////////////////////////////////////////
//:: con_a1flint
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script checks if the PC speakert has a
    Flint object in their inventory.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oFlint = GetItemPossessedBy(oPC, "a1_flint");
    int iResult = FALSE;

    if ((GetIsObjectValid(oFlint) == TRUE) && (GetIdentified(oFlint) == TRUE))
    {
        iResult = TRUE;
    }

    return iResult;
}
