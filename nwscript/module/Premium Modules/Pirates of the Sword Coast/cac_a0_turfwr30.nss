//::///////////////////////////////////////////////
//:: cac_a0_turfwr30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Bandits have fallen to the cunning of
    the player but in the fonfusion the local
    Blood sailors have fallen under the
    assumption that the Player is a member
    of the bandit gang.

    You must defend yourself and end the turf war.

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
    SetLocalInt(GetModule(), "A0_TURFWR", 30);
    SetLocalInt(GetModule(), "A0_BLACKRIVER_ALLY", TRUE);
    AddJournalQuestEntry("a0_turfwr", 30, oPC);

    ExecuteScript("exe_a0_spwnblood", OBJECT_SELF);
}
