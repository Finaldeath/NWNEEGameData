//::///////////////////////////////////////////////
//:: cac_a2_langer20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have met Langer and he's told you his
    story. and offered solutions for his release.
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

    int iEXP = GetJournalQuestExperience("a2_langer");
    int iDoOnce = GetLocalInt(oModule, "cac_a2_langer20");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a2_langer20", TRUE);

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A2_LANGER", 20);
        AddJournalQuestEntry("a2_langer", 20, oPC);
    }
}
