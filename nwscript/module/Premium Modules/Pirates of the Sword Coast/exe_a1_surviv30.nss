//::///////////////////////////////////////////////
//:: exe_a1_surviv30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You finally have a Fire, if only you could
    bring it with you where ever you travel. If
    you could put together a make shift torch if
    would be a lot easier to safely explore the
    island.
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
    int iDoOnce = GetLocalInt(oModule, "exe_a1_surviv30");

    if ((iDoOnce == FALSE) && (iPlot < 30))
    {
        SetLocalInt(oModule, "exe_a1_surviv30", TRUE);

        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A1_SURVIV", 30);
        AddJournalQuestEntry("a1_surviv", 30, oPC);
    }
}
