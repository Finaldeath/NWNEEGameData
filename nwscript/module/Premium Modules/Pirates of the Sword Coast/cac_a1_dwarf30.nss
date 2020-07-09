//::///////////////////////////////////////////////
//:: cac_a1_dwarf30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Player has been threatened by a strange
    flaming avatar But nothing is stopping him/her
    from entering the cavern it guards.
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
    SetLocalInt(GetModule(), "A1_DWARF", 30);
    AddJournalQuestEntry("a1_dwarf", 30, oPC);
}
