//::///////////////////////////////////////////////
//:: exe_a3_water60
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    After agreeing to the dragons demands you
    are taken to the secret entrance to the
    Umberlant temple.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = OBJECT_SELF;
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a3_water");
    iEXP = ConvertPercent(iEXP, 0.10f);

    HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A3_WATER", 60);
    AddJournalQuestEntry("a3_water", 60, oPC);
}
