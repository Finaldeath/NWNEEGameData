//::///////////////////////////////////////////////
//:: con_a1hasstick
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have either long or short sticks
    in their inventory?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oStick = GetItemPossessedBy(oPC, "a1_stick");
    object oLStick = GetItemPossessedBy(oPC, "a1_stick_long");
    int iResult = FALSE;

    // Does a stick exist in the PC's inventory?
    if ((GetIsObjectValid(oStick) == TRUE)
      || (GetIsObjectValid(oLStick) == TRUE))
    {
        iResult = TRUE;
    }

    return iResult;
}
