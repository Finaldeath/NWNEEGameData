//::///////////////////////////////////////////////
//:: exe_a2_wwctls10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have heard about Willigans Cutless.
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

    int iEXP = GetJournalQuestExperience("a2_wwctls");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_WWCTLS", 10);
    AddJournalQuestEntry("a2_wwctls", 10, oPC);
}
