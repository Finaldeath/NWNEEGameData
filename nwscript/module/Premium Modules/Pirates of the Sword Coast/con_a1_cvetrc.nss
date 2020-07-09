//::///////////////////////////////////////////////
//:: con_a1_cvetrc
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have a torch Equiped in the
    Jelly Caves?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oCave = GetArea(oPC);
    object oItemR = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    object oItemL = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);

    int iResult = FALSE;

    // Does a stick exist in the PC's inventory?
    if (((GetTag(oItemR) == "a1_torch") || (GetTag(oItemR) == "a1_torch_long"))
     || ((GetTag(oItemL) == "a1_torch") || (GetTag(oItemL) == "a1_torch_long"))
     && (GetTag(oCave) == "a1_ochrejellycave"))
    {
        iResult = TRUE;
    }

    return iResult;
}
