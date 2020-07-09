//::///////////////////////////////////////////////
//:: cac_a2_shakey10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC heard of Shakey McGuire, the
    cowardly crewman?
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

    int iEXP = GetJournalQuestExperience("a2_shakey");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_SHAKEY", 10);
    AddJournalQuestEntry("a2_shakey", 10, oPC);
}
