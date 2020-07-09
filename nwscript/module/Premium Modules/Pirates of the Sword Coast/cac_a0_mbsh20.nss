//::///////////////////////////////////////////////
//:: cac_a0_mbsh20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script unlocks Dela's store in the
    seedy tavern.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    int iEXP = GetJournalQuestExperience("a0_ambush");
    iEXP = ConvertPercent(iEXP, 0.80f);

    HandoutQuestXP(oPC, iEXP);
    AddJournalQuestEntry("a0_ambush", 20, oPC);
    SetLocalInt(GetModule(), "A0_AMBUSH", 20);
}
