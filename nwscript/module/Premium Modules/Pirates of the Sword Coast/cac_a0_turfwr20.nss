//::///////////////////////////////////////////////
//:: cac_a0_turfwr20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has been rescued by a group of
    Bloodsailors wandering the area.

    Unfortunately an all out gang war has
    errupted out into the streets.

    You should help out and end the conflict.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    int iEXP = GetJournalQuestExperience("a0_turfwr");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A0_TURFWR", 20);
    SetLocalInt(GetModule(), "A0_BLOODSAILOR_ALLY", TRUE);
    AddJournalQuestEntry("a0_turfwr", 20, oPC);

    ExecuteScript("exe_a0_spwnblood", OBJECT_SELF);
}
