//::///////////////////////////////////////////////
//:: cac_a2_whipd50
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Whipped willigan has joined the crew.
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
    object oWilligan = OBJECT_SELF;
    int iEXP = GetJournalQuestExperience("a2_whipd");

    AssignCommand(oModule, ExecuteScript("exe_a2_crewinc", oPC));
    iEXP = ConvertPercent(iEXP, 1.00f);

    HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A2_WHIPD", 50);
    SetLocalInt(oWilligan, "EXIT_TO_CUTLESS", TRUE);
    AddJournalQuestEntry("a2_whipd", 50, oPC);
}
