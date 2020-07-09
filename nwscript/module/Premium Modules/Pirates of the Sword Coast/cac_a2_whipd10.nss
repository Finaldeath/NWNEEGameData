//::///////////////////////////////////////////////
//:: cac_a2_whipd10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC heard of Whipped Willigan?
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

    int iEXP = GetJournalQuestExperience("a2_whipd");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_WHIPD", 10);
    AddJournalQuestEntry("a2_whipd", 10, oPC);
}
