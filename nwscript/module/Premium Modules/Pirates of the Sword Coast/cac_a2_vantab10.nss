//::///////////////////////////////////////////////
//:: cac_a2_vantab10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC learned the Vantabular is an
    available optional crew member?
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

    int iEXP = GetJournalQuestExperience("a2_vantab");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_VANTAB", 10);
    AddJournalQuestEntry("a2_vantab", 10, oPC);
}
