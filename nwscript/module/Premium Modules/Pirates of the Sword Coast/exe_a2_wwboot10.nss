//::///////////////////////////////////////////////
//:: exe_a2_wwboot10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You heard of Willigans boots.
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

    SetLocalInt(oModule, "A2_WWBOOT", 10);
    AddJournalQuestEntry("a2_wwboot", 10, oPC);
}
