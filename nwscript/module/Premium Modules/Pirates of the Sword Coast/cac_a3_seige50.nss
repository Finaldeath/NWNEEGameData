//::///////////////////////////////////////////////
//:: cac_a3_seige50
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have driven off the invasion.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a3_seige");
    iEXP = ConvertPercent(iEXP, 0.25f);

    HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A3_SEIGE", 50);
    AddJournalQuestEntry("a3_seige", 50, oPC);
}
