//::///////////////////////////////////////////////
//:: cac_a2_necro30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Your well on your way to tracking down Tasina
    and the Midnight Rose. However, The Captain
    needs to make a quick stop before delivering
    you to your promised destination.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a2_necro");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_NECRO", 30);
    AddJournalQuestEntry("a2_necro", 30, oPC);
}
