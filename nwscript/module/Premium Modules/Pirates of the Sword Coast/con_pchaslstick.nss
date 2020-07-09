//::///////////////////////////////////////////////
//:: con_pchaslstick
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have a Long Stick object in their
    inventory?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oStick = GetItemPossessedBy(oPC, "a1_stick_long");
    int iResult = FALSE;

    // Does a long stick exist in the PC's inventory?
    if (GetIsObjectValid(oStick) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
