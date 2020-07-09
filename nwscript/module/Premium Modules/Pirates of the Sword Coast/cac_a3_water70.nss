//::///////////////////////////////////////////////
//:: cac_a3_water70
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has found Tasina and she has agreed
    to stop the ceremony, once this occurs the
    Umberlant Guardian shows up and starts to
    demolishing the temple to get at you and
    your party.
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

    int iEXP = GetJournalQuestExperience("a3_water");
    iEXP = ConvertPercent(iEXP, 0.50f);

    HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A3_WATER", 70);
    AddJournalQuestEntry("a3_water", 70, oPC);
}
