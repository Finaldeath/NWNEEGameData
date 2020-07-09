//::///////////////////////////////////////////////
//:: cac_a3_seige10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has left the island of the dead and
    has been awoken aboard the Skull and Bones
    as it is sailed to the Rose by Gyllum.
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

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A3_SEIGE", 10);
    AddJournalQuestEntry("a3_seige", 10, oPC);
}
