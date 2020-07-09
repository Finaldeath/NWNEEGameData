//::///////////////////////////////////////////////
//:: cac_a0_docks20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Captain needs you to pick up a last
    minute passenger.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oAllendry = OBJECT_SELF;
    int iEXP = GetJournalQuestExperience("a0_docks");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A0_DOCKS", 20);
    AddJournalQuestEntry("a0_docks", 20, oPC);

    ExecuteScript("cac_a0_escort10", oAllendry);
}
