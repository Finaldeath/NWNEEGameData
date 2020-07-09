//::///////////////////////////////////////////////
//:: con_pceqptrch
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have a torch Equiped?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItemR = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    object oItemL = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);

    int iResult = FALSE;

    // Does a stick exist in the PC's inventory?
    if (((GetTag(oItemR) == "a1_torch") || (GetTag(oItemR) == "a1_torch_long"))
     || ((GetTag(oItemL) == "a1_torch") || (GetTag(oItemL) == "a1_torch_long")))
    {
        iResult = TRUE;
    }

    return iResult;
}
