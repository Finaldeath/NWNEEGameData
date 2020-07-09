//::///////////////////////////////////////////////
//:: cac_a1_dwarf60
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has learned Edgrimm needs wood to make
    a raft, bring him wood and he’ll take you off
    the island.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    int iEXP = GetJournalQuestExperience("a1_dwarf");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A1_DWARF", 60);
    AddJournalQuestEntry("a1_dwarf", 60, oPC);
}
