//::///////////////////////////////////////////////
//:: exe_a3_seige30
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

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A3_SEIGE", 30);
    AddJournalQuestEntry("a3_seige", 30, oPC);
}
