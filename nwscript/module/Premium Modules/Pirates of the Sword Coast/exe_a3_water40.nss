//::///////////////////////////////////////////////
//:: exe_a3_water40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    As you approach the Temple entrance a
    mysterious monster appears and destroys
    the path.

    You'll have to find another way around.
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
    iEXP = ConvertPercent(iEXP, 0.10f);
    int iDoOnce = GetLocalInt(oModule, "exe_a3_water40");

    if (iDoOnce == FALSE)
    {
        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "exe_a3_water40", TRUE);
        SetLocalInt(oModule, "A3_WATER", 40);
        AddJournalQuestEntry("a3_water", 40, oPC);
    }
}
