//::///////////////////////////////////////////////
//:: con_pchasstick
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have a Stick object in their
    inventory?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oStick = GetItemPossessedBy(oPC, "a1_stick");
    int iResult = FALSE;

    // Does a stick exist in the PC's inventory?
    if (GetIsObjectValid(oStick) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
