//::///////////////////////////////////////////////
//:: cac_a2_vantab30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have unlocked a secret passage under the
    light house and are one step closer to
    uncovering the mysterious treasure.
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

    int iEXP = GetJournalQuestExperience("a2_vantab");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_VANTAB", 30);
    AddJournalQuestEntry("a2_vantab", 30, oPC);
}
