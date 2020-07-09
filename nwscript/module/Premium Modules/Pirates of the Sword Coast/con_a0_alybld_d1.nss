//::///////////////////////////////////////////////
//:: con_a0_alybld_d1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check and see if the PC Is allied with the
    Bloodsailors in Act 0, but does it only once
    per object.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oSpeaker = OBJECT_SELF;

    int iBloodAllies = GetLocalInt(GetModule(), "A0_BLOODSAILOR_ALLY");
    int iDoOnce = GetLocalInt(oSpeaker, "con_a0_alybld_d1");
    int iResult = FALSE;

    // If the Bloodsailors are allies return true.
    if ((iBloodAllies == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oSpeaker, "con_a0_alybld_d1", TRUE);
        iResult = TRUE;
    }

    return iResult;
}
