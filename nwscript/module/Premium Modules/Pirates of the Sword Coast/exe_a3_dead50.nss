//::///////////////////////////////////////////////
//:: exe_a3_dead50
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Pirate Captain is defeated; you can claim
    the Skull & Bones as your own and head out
    after Tasina.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = OBJECT_SELF;
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a3_dead");
    iEXP = ConvertPercent(iEXP, 0.75f);

    HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A3_DEAD", 50);
    AddJournalQuestEntry("a3_dead", 50, oPC);
}
