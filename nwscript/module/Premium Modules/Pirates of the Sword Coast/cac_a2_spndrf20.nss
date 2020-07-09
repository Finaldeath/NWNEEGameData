//::///////////////////////////////////////////////
//:: cac_a2_spndrf20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has learned that Tasina is actually an
    Umberleen Priestess and has recently arrived
    in Spindrift on an unnamed ship.
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

    int iEXP = GetJournalQuestExperience("a2_spndrf");
    iEXP = ConvertPercent(iEXP, 0.20f);

    HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_SPNDRF", 20);
    AddJournalQuestEntry("a2_spndrf", 20, oPC);
}
