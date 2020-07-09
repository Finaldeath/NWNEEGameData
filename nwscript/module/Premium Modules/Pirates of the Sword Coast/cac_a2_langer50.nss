//::///////////////////////////////////////////////
//:: cac_a2_langer50
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Langer has received an Extreme Pirate
    Makeover, now he can be exonerated.
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
    int iEXP = GetJournalQuestExperience("a2_langer");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A2_LANGER", 50);
    AddJournalQuestEntry("a2_langer", 50, oPC);
}
