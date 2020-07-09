//::///////////////////////////////////////////////
//:: exe_a2_wwboot20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have obtained the Willigan's Boots.
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

    int iEXP = GetJournalQuestExperience("a2_wwboot");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A2_WWBOOT", 20);
    AddJournalQuestEntry("a2_wwboot", 20, oPC, TRUE, FALSE, TRUE);
}
