//::///////////////////////////////////////////////
//:: cac_a2_midrse40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Tasina has Left port with the Midngiht Rose.
    She's headed out to an ancient Undersea
    temple.
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

    int iEXP = GetJournalQuestExperience("a2_midrose");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_MIDROSE", 40);
    AddJournalQuestEntry("a2_midrose", 40, oPC);
}
