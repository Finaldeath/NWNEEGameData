//::///////////////////////////////////////////////
//:: cac_a2_sweet40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sweetie Marie has agreed to sail with you on
    the Skull and Bones.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a2_sweet");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_SWEET", 40);
    AddJournalQuestEntry("a2_sweet", 40, oPC);
}
