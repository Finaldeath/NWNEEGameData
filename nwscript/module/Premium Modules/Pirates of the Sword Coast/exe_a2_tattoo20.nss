//::///////////////////////////////////////////////
//:: exe_a2_tattoo20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have released the Tattooist the shop
    is now open for business.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = OBJECT_SELF;
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a2_tattoo");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A2_TATTOO", 20);
    AddJournalQuestEntry("a2_tattoo", 20, oPC);
}
