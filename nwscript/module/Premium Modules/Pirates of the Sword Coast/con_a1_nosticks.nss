//::///////////////////////////////////////////////
//:: con_a1_nosticks
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the PC out of short sticks?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oStickS = GetItemPossessedBy(oPC, "a1_stick");

    int iResult = FALSE;

    if (GetIsObjectValid(oStickS) != TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
