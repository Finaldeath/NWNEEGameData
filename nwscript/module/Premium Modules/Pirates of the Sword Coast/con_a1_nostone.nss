//::///////////////////////////////////////////////
//:: con_a1_nostone
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the PC out of stones?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oStone = GetItemPossessedBy(oPC, "a1_stone");

    int iResult = FALSE;

    if (GetIsObjectValid(oStone) != TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
