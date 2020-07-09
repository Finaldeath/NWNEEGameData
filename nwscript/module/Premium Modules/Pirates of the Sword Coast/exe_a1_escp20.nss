//::///////////////////////////////////////////////
//:: exe_a1_escp20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have aquired some wood.

    With the right plans you could make a
    sturdy craft.
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
    iEXP = ConvertPercent(iEXP, 0.30f);
    int iDoOnce = GetLocalInt(oModule, "exe_a1_escp20");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "exe_a1_escp20", TRUE);

        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(GetModule(), "A1_ESCP", 20);
        AddJournalQuestEntry("a1_escp", 20, oPC);
    }
}
