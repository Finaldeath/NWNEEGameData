//::///////////////////////////////////////////////
//:: con_a1_ednfavor
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the player has not successfully
    obtained a favor from Edgrimm
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iFavor = GetLocalInt(oPC, "A1_EDGRIMMFAVOR");
    int iResult = FALSE;

    if (iFavor != TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
