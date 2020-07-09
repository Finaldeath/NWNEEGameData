//::///////////////////////////////////////////////
//:: cac_a2_blackr30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have successfully competed the Heist and
    gained another party member.
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
    object oHoney = OBJECT_SELF;
    object oScepter = GetItemPossessedBy(oPC, "a2_nwscepter");

    int iEXP = GetJournalQuestExperience("a2_blackr");
    iEXP = ConvertPercent(iEXP, 1.00f);

    AssignCommand(oModule, ExecuteScript("exe_a2_crewinc", oPC));
    HandoutQuestXP(oPC, iEXP);

    DestroyObject(oScepter);

    SetLocalInt(oModule, "A2_BLACKR", 30);
    SetLocalInt(oHoney, "EXIT_TO_CUTLESS", TRUE);
    AddJournalQuestEntry("a2_blackr", 30, oPC);
}
