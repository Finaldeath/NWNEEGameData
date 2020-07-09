//::///////////////////////////////////////////////
//:: con_a1_pcnhastrc
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC not have a torch object in their
    inventory?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oTorchS = GetItemPossessedBy(oPC, "a1_torch");
    object oTorchL = GetItemPossessedBy(oPC, "a1_torch_long");

    int iResult = FALSE;

    // Does a stick exist in the PC's inventory?
    if ((GetIsObjectValid(oTorchS) == FALSE)
      && (GetIsObjectValid(oTorchL) == FALSE))
    {
        iResult = TRUE;
    }

    return iResult;
}
