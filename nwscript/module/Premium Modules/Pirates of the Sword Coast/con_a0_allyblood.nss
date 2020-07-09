//::///////////////////////////////////////////////
//:: con_a0_allyblood
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check and see if the PC Is allied with the
    Bloodsailors in Act 0
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oSpeaker = OBJECT_SELF;

    int iBloodAllies = GetLocalInt(GetModule(), "A0_BLOODSAILOR_ALLY");
    int iResult = FALSE;

    // If the Bloodsailors are allies return true.
    if (iBloodAllies == TRUE)
    {
        AdjustReputation(oPC, oSpeaker, 100);
        iResult = TRUE;
    }

    return iResult;
}
