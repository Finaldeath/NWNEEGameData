//::///////////////////////////////////////////////
//:: cac_a3_hunt70
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Kolmarr has opened a strange gate at the top
    of the hill and entered the portal. He has
    told you to follow him.
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

    int iEXP = GetJournalQuestExperience("a3_hunt");
    iEXP = ConvertPercent(iEXP, 0.15f);

    HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A3_HUNT", 70);
    AddJournalQuestEntry("a3_hunt", 70, oPC);

}
