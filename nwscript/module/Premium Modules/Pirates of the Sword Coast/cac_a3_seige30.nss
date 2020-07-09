//::///////////////////////////////////////////////
//:: cac_a3_seige30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Ship is under attack, the Player must
    fend of the attacking sahaugin while
    preventing the ship from sinking.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a3_seige");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A3_SEIGE", 30);
    AddJournalQuestEntry("a3_seige", 30, oPC);
}
