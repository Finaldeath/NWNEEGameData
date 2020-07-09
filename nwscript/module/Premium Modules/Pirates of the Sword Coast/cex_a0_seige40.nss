//::///////////////////////////////////////////////
//:: cex_a0_seige40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Tasina has captured the Midnight Rose, killed
    Captain Allendry, and thrown you overboard.

    Continue the cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 18, 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oSelf = OBJECT_SELF;
    object oArea = GetArea(oSelf);
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    int iEXP = GetJournalQuestExperience("a0_seige");
    iEXP = ConvertPercent(iEXP, 1.00f);

    HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A0_SEIGE", 40);
    AddJournalQuestEntry("a0_seige", 40, oPC);

    ExecuteScript("cut_mrseige3", oArea);
}
