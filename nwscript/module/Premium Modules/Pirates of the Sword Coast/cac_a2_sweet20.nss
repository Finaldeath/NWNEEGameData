//::///////////////////////////////////////////////
//:: cac_a2_sweet20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sweetie Marie won't join. She's waiting for
    something, and the sailor PegLeg in the
    Monkeys cutless may know how to convince
    her.
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
    int iEXP = GetJournalQuestExperience("a2_sweet");
    int iDoOnce = GetLocalInt(oModule, "cac_a2_sweet20");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a2_sweet20", TRUE);

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A2_SWEET", 20);
        AddJournalQuestEntry("a2_sweet", 20, oPC);
    }
}
