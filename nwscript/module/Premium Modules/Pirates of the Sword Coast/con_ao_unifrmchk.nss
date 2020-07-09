//::///////////////////////////////////////////////
//:: con_ao_unifrmchk
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check to see if the item equiped to the chest
    is a Midnight Rose uniform.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oUniform = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    int iResult = FALSE;

    // if the chest is equiped with the sailors uniform return true
    if (GetTag(oUniform) == "a0_sailorsuniform")
    {
        iResult = TRUE;
    }

    return iResult;
}
