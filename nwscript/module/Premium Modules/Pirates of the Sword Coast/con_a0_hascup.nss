//:://////////////////////////////////////////////
//:: con_a0_hascup
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check to see if the PC has the Listening
    Cup in his inventory.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "a0rm_cup");
    int iResult = FALSE;

    if (GetIsObjectValid(oItem) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
