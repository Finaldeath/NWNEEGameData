//::///////////////////////////////////////////////
//:: con_a0_allybrbnd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check and see if the PC Is allied with the
    Blackriver Bandits in Act 0
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oSpeaker = OBJECT_SELF;

    int iBRBAllies = GetLocalInt(GetModule(), "A0_BLACKRIVER_ALLY");
    int iResult = FALSE;

    // If the Blackriver Bandits are allies return true.
    if (iBRBAllies == TRUE)
    {
        AdjustReputation(oPC, oSpeaker, 100);
        iResult = TRUE;
    }

    return iResult;
}
