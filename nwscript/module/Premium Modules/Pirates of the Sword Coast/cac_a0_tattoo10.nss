//::///////////////////////////////////////////////
//:: cac_a0_tattoo10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has heard about the Tattoo parlor
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    int iEXP = GetJournalQuestExperience("a0_tattoo");
    int iDoOnce = GetLocalInt(GetModule(), "cac_a0_tattoo10");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(GetModule(), "cac_a0_tattoo10", TRUE);

        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(GetModule(), "A0_TATTOO", 10);
        AddJournalQuestEntry("a0_tattoo", 10, oPC);
    }
}
