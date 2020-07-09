//::///////////////////////////////////////////////
//:: con_a0_noshirt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the PC speaker is wearing a proper
    shirt. If there is no shirt return true.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oUniform = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    int iResult = FALSE;

    // If the object equiped to the shirt is no valid return true.
    if (GetIsObjectValid(oUniform) == FALSE)
    {
        iResult = TRUE;
    }

    return iResult;
}
