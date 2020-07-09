//::///////////////////////////////////////////////
//:: cac_a1_dwarf50
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Player has met the mad, Dwarven inventor,
    Edgrimm.
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
    SetLocalInt(GetModule(), "A1_DWARF", 50);
    AddJournalQuestEntry("a1_dwarf", 50, oPC);
}
