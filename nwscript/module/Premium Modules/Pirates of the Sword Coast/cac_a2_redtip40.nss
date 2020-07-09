//::///////////////////////////////////////////////
//:: cac_a2_redtip40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Red-Tip has been defeated and will join the
    crew of the Skull and Bones.
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
    object oRedTip = OBJECT_SELF;
    int iEXP = GetJournalQuestExperience("a2_redtip");
    iEXP = ConvertPercent(iEXP, 1.00f);

    AssignCommand(oModule, ExecuteScript("exe_a2_crewinc", oPC));

    HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A2_REDTIP", 40);
    SetLocalInt(oRedTip, "EXIT_TO_CUTLESS", TRUE);
    AddJournalQuestEntry("a2_redtip", 40, oPC);
}
