//::///////////////////////////////////////////////
//:: exe_a3_seige40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have successfully plugged the holes,
    now to finish off the sahaugin invaders.
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

    int iEXP = GetJournalQuestExperience("a3_seige");
    iEXP = ConvertPercent(iEXP, 0.75f);

    HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A3_SEIGE", 40);
    AddJournalQuestEntry("a3_seige", 40, oPC);
}
