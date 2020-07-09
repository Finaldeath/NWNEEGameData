//::///////////////////////////////////////////////
//:: exe_a1_dwarf80
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Player has fought and Killed the Crazed
    inventor and captured the plans.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = OBJECT_SELF;
    object oModule = GetModule();
    int iEXP = GetJournalQuestExperience("a1_dwarf");
    int iDoOnce = GetLocalInt(oModule, "exe_a1_dwarf80");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "exe_a1_dwarf80", TRUE);
        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A1_DWARF", 80);
        AddJournalQuestEntry("a1_dwarf", 80, oPC);
    }
}
