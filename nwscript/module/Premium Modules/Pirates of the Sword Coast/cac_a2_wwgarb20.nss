//::///////////////////////////////////////////////
//:: cac_a2_wwgarb20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have obtained the Willigans Garb.
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

    int iEXP = GetJournalQuestExperience("a2_wwgarb");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_WWGARB", 20);
    AddJournalQuestEntry("a2_wwgarb", 20, oPC);
}
