//::///////////////////////////////////////////////
//:: cac_a2_sweet50
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sweetie Marie has agreed to join your crew.
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
    object oSweet = OBJECT_SELF;
    object oFlowers = GetItemPossessedBy(oPC, "a2_flowers");
    int iEXP = GetJournalQuestExperience("a2_sweet");
    iEXP = ConvertPercent(iEXP, 1.00f);

    AssignCommand(oModule, ExecuteScript("exe_a2_crewinc", oPC));

    DestroyObject(oFlowers);

    HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A2_SWEET", 50);
    SetLocalInt(oSweet, "EXIT_TO_CUTLESS", TRUE);
    AddJournalQuestEntry("a2_sweet", 50, oPC);
}
