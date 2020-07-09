//::///////////////////////////////////////////////
//:: cac_a2_franc10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have heard of an able bodied sailor by
    the name of Sir Francis wandering about near
    the Fit pits.
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

    SetLocalInt(oModule, "A2_FRANC", 10);
    AddJournalQuestEntry("a2_franc", 10, oPC);
}
