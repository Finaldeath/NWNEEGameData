//::///////////////////////////////////////////////
//:: exe_a2_wwgarb10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have heard about Willigans Garb.
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

    int iEXP = GetJournalQuestExperience("a2_wwgarb");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_WWGARB", 10);
    AddJournalQuestEntry("a2_wwgarb", 10, oPC);
}
