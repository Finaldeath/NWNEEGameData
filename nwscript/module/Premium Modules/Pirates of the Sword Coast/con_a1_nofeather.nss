//::///////////////////////////////////////////////
//:: con_a1_nofeather
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the PC out of feathers?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oFeather = GetItemPossessedBy(oPC, "a1_feather");

    int iResult = FALSE;

    if (GetIsObjectValid(oFeather) != TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
