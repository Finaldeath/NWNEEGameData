//::///////////////////////////////////////////////
//:: exe_a1_surviv20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have found a safe place to rest, all you
    need is a fire to keep away the preditors of
    the island as night falls.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oModule = GetModule();
    object oPC = OBJECT_SELF;
    int iPlot = GetLocalInt(GetModule(), "A1_SURVIV");
    int iEXP = GetJournalQuestExperience("a1_surviv");
    iEXP = ConvertPercent(iEXP, 0.25f);
    int iDoOnce = GetLocalInt(oModule, "exe_a1_surviv20");

    if ((iDoOnce == FALSE) && (iPlot < 20))
    {
        SetLocalInt(oModule, "exe_a1_surviv20", TRUE);

        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(GetModule(), "A1_SURVIV", 20);
        AddJournalQuestEntry("a1_surviv", 20, oPC);
    }
}
