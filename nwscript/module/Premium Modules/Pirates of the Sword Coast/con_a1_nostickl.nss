//::///////////////////////////////////////////////
//:: con_a1_nostickl
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the PC out of long sticks?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oStickL = GetItemPossessedBy(oPC, "a1_stick_long");

    int iResult = FALSE;

    if (GetIsObjectValid(oStickL) != TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
