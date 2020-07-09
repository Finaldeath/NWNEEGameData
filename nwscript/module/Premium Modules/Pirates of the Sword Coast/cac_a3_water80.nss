//::///////////////////////////////////////////////
//:: cac_a3_water80
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has challenged Tasina and she has
    drawn on the full power of the Umberlant
    statues. She has been possessed by an
    Avatar of Umberlee and is trying to
    destroy you.
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
    iEXP = ConvertPercent(iEXP, 0.50f);

    HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A3_WATER", 80);
    AddJournalQuestEntry("a3_water", 80, oPC);
}
