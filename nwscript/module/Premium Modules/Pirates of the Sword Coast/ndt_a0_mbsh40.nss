//::///////////////////////////////////////////////
//:: ndt_a0_mbsh40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Dela is Dead.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"


void main()
{
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    int iEXP = GetJournalQuestExperience("a0_ambush");
    iEXP = ConvertPercent(iEXP, 0.80f);

    //dela is dead.
    HandoutQuestXP(oPC, iEXP);
    AddJournalQuestEntry("a0_ambush", 40, oPC);
    SetLocalInt(GetModule(), "A0_AMBUSH", 40);
}

