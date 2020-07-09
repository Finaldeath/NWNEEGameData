//::///////////////////////////////////////////////
//:: cac_a0_seige20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You've learned that the Captian has been
    hold up in his quarters with the Lady
    Preistess and the Mage.

    You should probably find out what's going on.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    int iEXP = GetJournalQuestExperience("a0_seige");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A0_SEIGE", 20);
    AddJournalQuestEntry("a0_seige", 20, oPC);
}
