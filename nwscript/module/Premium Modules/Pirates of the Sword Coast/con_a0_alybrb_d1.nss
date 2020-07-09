//::///////////////////////////////////////////////
//:: con_a0_alybrb_d1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check and see if the PC Is allied with the
    Blackriver Bandits in Act 0
    (only if not talked to before)
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
    int iDoOnce = GetLocalInt(oSpeaker, "con_a0_alybrb_d1");
    int iResult = FALSE;

    // If the Blackriver Bandits are allies return true.
    if ((iBRBAllies == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oSpeaker, "con_a0_alybrb_d1", TRUE);
        iResult = TRUE;
    }

    return iResult;
}
