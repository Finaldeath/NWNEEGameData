//::///////////////////////////////////////////////
//:: cac_a2_shakey40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has succeeded in Intimidating Shaky
    and he has joined the crew.
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
    object oShakey = OBJECT_SELF;
    int iEXP = GetJournalQuestExperience("a2_shakey");
    iEXP = ConvertPercent(iEXP, 1.00f);

    AssignCommand(oModule, ExecuteScript("exe_a2_crewinc", oPC));

    HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A2_SHAKEY", 40);
    SetLocalInt(oShakey, "EXIT_TO_CUTLESS", TRUE);
    AddJournalQuestEntry("a2_shakey", 40, oPC);
}
