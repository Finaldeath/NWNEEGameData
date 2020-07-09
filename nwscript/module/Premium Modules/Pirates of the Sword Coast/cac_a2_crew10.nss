//::///////////////////////////////////////////////
//:: cac_a2_crew10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC learned they'll need to collect a
    five man crew to sail away.
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

    int iEXP = GetJournalQuestExperience("a2_crew");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_CREW", 10);
    AddJournalQuestEntry("a2_crew", 10, oPC);
}
