//::///////////////////////////////////////////////
//:: cac_a2_vantab40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The treasure has been discovered and Vantabular
    has taken possession of a magical golden sextant
    and has left the rest of the treasure to you.

    He will now sail with you.
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
    object oVantab = OBJECT_SELF;
    object oAstrolabe = GetItemPossessedBy(oPC, "a2_astrolabe");
    int iEXP = GetJournalQuestExperience("a2_vantab");

    AssignCommand(oModule, ExecuteScript("exe_a2_crewinc", oPC));

    HandoutQuestXP(oPC, iEXP);
    PrintString("Destroying the astrolabe.");
    DestroyObject(oAstrolabe);

    SetLocalInt(oVantab, "EXIT_TO_CUTLESS", TRUE);
    SetLocalInt(oModule, "A2_VANTAB", 40);
    AddJournalQuestEntry("a2_vantab", 40, oPC);
}
