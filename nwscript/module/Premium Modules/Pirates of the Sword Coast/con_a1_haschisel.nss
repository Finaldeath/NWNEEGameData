//::///////////////////////////////////////////////
//:: con_a1_haschisel
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have a Chisel object in their
    inventory from ww1?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oChisel = GetItemPossessedBy(oPC, "ww1_chisel");
    int iResult = FALSE;

    // Does a WW1 Chisel exist in the PC's inventory?
    if (GetIsObjectValid(oChisel) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
