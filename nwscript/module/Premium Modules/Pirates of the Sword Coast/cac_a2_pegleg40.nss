//::///////////////////////////////////////////////
//:: cac_a2_pegleg40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Peg-Leg Paulson has agreed to join your crew.
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
    object oPaulson  = OBJECT_SELF;
    int iEXP = GetJournalQuestExperience("a2_pegleg");
    iEXP = ConvertPercent(iEXP, 1.00f);

    AssignCommand(oModule, ExecuteScript("exe_a2_crewinc", oPC));

    HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A2_PEGLEG", 40);
    SetLocalInt(oPaulson, "EXIT_TO_CUTLESS", TRUE);
    AddJournalQuestEntry("a2_pegleg", 40, oPC);
}
