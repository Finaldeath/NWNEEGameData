//::///////////////////////////////////////////////
//:: cac_a2_franc30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sir francis has told you about Rascally Pete
    and how the sewer goer was the original owner
    and that francis's debt is to Pete.
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

    int iEXP = GetJournalQuestExperience("a2_franc");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_FRANC", 30);
    AddJournalQuestEntry("a2_franc", 30, oPC);
}
