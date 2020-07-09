//::///////////////////////////////////////////////
//:: cac_a0_cargo10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has been given the cargo plot.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    int iEXP = GetJournalQuestExperience("a0_cargo");

//    HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A0_CARGO", 10);
    AddJournalQuestEntry("a0_cargo", 10, oPC);
}
