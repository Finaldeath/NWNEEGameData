//::///////////////////////////////////////////////
//:: con_a1_edgrmhead
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have Edgrimms Head in their
    inventory?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Dec, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHead = GetItemPossessedBy(oPC, "a1_edgrimmshead");
    int iResult = FALSE;

    // Does a head exist in the PC's inventory?
    if (GetIsObjectValid(oHead) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
