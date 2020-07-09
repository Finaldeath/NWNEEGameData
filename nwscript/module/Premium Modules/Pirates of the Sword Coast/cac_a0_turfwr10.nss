//::///////////////////////////////////////////////
//:: cac_a0_turfwr10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has been cornered by a group of thugs
    calling themselves "Black River Bandits".
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
    SetLocalInt(GetModule(), "A0_TURFWR", 10);
    AddJournalQuestEntry("a0_turfwr", 10, oPC);
}
