//::///////////////////////////////////////////////
//:: cac_a2_langer10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You've heard from the Hangman in towns square
    that a sailor of some reputation has been
    sentenced to hang unjustly by the mayor.

    If you can free Langer, he would surely join
    any crew you'd lead.
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

    int iEXP = GetJournalQuestExperience("a2_langer");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_LANGER", 10);
    AddJournalQuestEntry("a2_langer", 10, oPC);
}
