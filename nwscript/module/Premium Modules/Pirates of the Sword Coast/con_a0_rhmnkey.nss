//::///////////////////////////////////////////////
//:: con_a0_rhmnkey
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have Rahmans room key?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oKey = GetItemPossessedBy(oPC, "a0_rahmanskey");
    int iResult = FALSE;

    if (GetIsObjectValid(oKey) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
