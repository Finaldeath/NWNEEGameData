//::///////////////////////////////////////////////
//:: cac_a2_bloods30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Vengaul has the Scepter, he will now wait in
    the Monkey's cutless for you to set sail.
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
    object oVengaul = OBJECT_SELF;
    object oScepter = GetItemPossessedBy(oPC, "a2_nwscepter");

    int iEXP = GetJournalQuestExperience("a2_bloods");
    iEXP = ConvertPercent(iEXP, 1.00f);

    AssignCommand(oModule, ExecuteScript("exe_a2_crewinc", oPC));
    HandoutQuestXP(oPC, iEXP);

    DestroyObject(oScepter);

    SetLocalInt(oModule, "A2_BLOODS", 30);
    SetLocalInt(oVengaul, "EXIT_TO_CUTLESS", TRUE);
    AddJournalQuestEntry("a2_bloods", 30, oPC);
}
