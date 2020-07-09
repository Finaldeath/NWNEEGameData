//::///////////////////////////////////////////////
//:: cac_a2_langer60
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Langer has been notified of his freedom
    and can be found at the Monkey's cutless
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oLanger = OBJECT_SELF;
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a2_langer");
    iEXP = ConvertPercent(iEXP, 1.00f);

    AssignCommand(oModule, ExecuteScript("exe_a2_crewinc", oPC));

    SetLocalInt(oLanger, "EXIT_TO_CUTLESS", TRUE);
    HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_LANGER", 60);
    AddJournalQuestEntry("a2_langer", 60, oPC);
}
