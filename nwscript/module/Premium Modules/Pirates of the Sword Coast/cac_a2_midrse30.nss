//::///////////////////////////////////////////////
//:: cac_a2_midrse30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You've gathered a Crew, but until the weather
    changes there's little you can do.
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

    SetLocalInt(oModule, "A2_MIDROSE", 30);
    AddJournalQuestEntry("a2_midrose", 30, oPC);
}
