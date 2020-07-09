//::///////////////////////////////////////////////
//:: con_a1_bowstick
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have a Stick object in their
    inventory and a bow of some kind?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    object oStick = GetItemPossessedBy(oPC, "a1_stick");
    object oBowA = GetItemPossessedBy(oPC, "a1_bow");
    object oBowB = GetItemPossessedBy(oPC, "a1_bow_s");

    int iResult = FALSE;

    // Does a stick exist in the PC's inventory?
    if ((GetIsObjectValid(oStick) == TRUE)
      && ((GetIsObjectValid(oBowA) == TRUE)
      || (GetIsObjectValid(oBowB) == TRUE)))
    {
        iResult = TRUE;
    }

    return iResult;
}
