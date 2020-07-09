//::///////////////////////////////////////////////
//:: cac_a0_docks10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Captain Needs you to load a statue before you
    can break harbor.
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
    SetLocalInt(GetModule(), "A0_DOCKS", 10);
    AddJournalQuestEntry("a0_docks", 10, oPC);

    ExecuteScript("cac_a0_cargo10", oAllendry);
}
