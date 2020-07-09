//::///////////////////////////////////////////////
//:: exe_a2_sweet40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have found the flowers for sweet marie.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = OBJECT_SELF;
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a2_sweet");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_SWEET", 40);
    AddJournalQuestEntry("a2_sweet", 40, oPC);
}
