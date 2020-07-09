//::///////////////////////////////////////////////
//:: cac_a2_shakey20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has failed to intimidate Shaky and he
    has run away.
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
    object oShakey = OBJECT_SELF;
    int iEXP = GetJournalQuestExperience("a2_shakey");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A2_SHAKEY", 20);
    SetLocalInt(oShakey, "EXIT_TO_CUTLESS", TRUE);
    AddJournalQuestEntry("a2_shakey", 20, oPC);
}
