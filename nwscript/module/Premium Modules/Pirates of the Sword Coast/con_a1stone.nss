//::///////////////////////////////////////////////
//:: con_a1stone
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script checks if the PC speaker has a
    stone object in their inventory.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oStone = GetItemPossessedBy(oPC, "a1_stone");
    int iResult = FALSE;

    if (GetIsObjectValid(oStone) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
