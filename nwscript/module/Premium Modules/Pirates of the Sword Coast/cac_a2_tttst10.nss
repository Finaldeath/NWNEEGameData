//::///////////////////////////////////////////////
//:: cac_a2_tttst10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have met the Jailed tattooist and he
    has told you about his situation.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a2_tttst");
    int iDoOnce = GetLocalInt(oModule, "cac_a2_tttst10");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a2_tttst10", TRUE);
        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A2_TTTST", 10);
        AddJournalQuestEntry("a2_tttst", 10, oPC);

        //Update the DoOnce
        SetLocalInt(OBJECT_SELF, "cac_a2_tttst_d1", TRUE);
    }
}
