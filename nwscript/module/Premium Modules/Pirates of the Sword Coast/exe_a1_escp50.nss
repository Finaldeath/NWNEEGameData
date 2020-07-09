//::///////////////////////////////////////////////
//:: exe_a1_escp50
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have escaped the Troglodyte island.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oModule = GetModule();
    object oPC = GetFirstPC();
    int iEXP = GetJournalQuestExperience("a1_escp");
    iEXP = ConvertPercent(iEXP, 0.70f);
    int iDoOnce = GetLocalInt(oModule, "exe_a1_escp50");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "exe_a1_escp50", TRUE);

        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(GetModule(), "A1_ESCP", 50);
        AddJournalQuestEntry("a1_escp", 50, oPC);
    }
}
