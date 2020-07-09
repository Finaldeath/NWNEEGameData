//::///////////////////////////////////////////////
//:: con_a1_crftrwmt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the player talking to his raw meat?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
const string sCheck = "a1_rawmeat";

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sItem = GetLocalString(oPC, "CRAFT_ITEM");

    int iResult = FALSE;

    if (sItem == sCheck)
    {
        iResult = TRUE;
    }

    return iResult;
}


