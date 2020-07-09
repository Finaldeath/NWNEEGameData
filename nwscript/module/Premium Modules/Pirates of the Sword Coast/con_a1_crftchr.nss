//::///////////////////////////////////////////////
//:: con_a1_crftchr
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the player talking to his ichor?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
const string sCheck = "a1_ichor";

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


