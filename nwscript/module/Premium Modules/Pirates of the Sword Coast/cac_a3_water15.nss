//::///////////////////////////////////////////////
//:: cac_a3_water15
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Allendry has told you that the priestesses
    walked the plank.
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

    int iEXP = GetJournalQuestExperience("a3_water");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A3_WATER", 15);
    AddJournalQuestEntry("a3_water", 15, oPC);
}
