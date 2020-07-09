//::///////////////////////////////////////////////
//:: cac_a2_midrse20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You've found the Rose in Harbor, but to man
    it you'll need a five man crew and a clear
    sky.
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

    SetLocalInt(oModule, "A2_MIDROSE", 20);
    AddJournalQuestEntry("a2_midrose", 20, oPC);
}
