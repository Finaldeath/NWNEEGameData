//::///////////////////////////////////////////////
//:: cac_a2_wwctls20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have obtained the Willigans Cutless.
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

    int iEXP = GetJournalQuestExperience("a2_wwctls");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_WWCTLS", 20);
    AddJournalQuestEntry("a2_wwctls", 20, oPC);
}
