//::///////////////////////////////////////////////
//:: exe_a1_surviv40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    With a readied torch you are ready to take
    on the wilds of this untamed land. While not
    all preditors will flee from your fire, it
    should protect you from the simple creatures
    dwelling here.
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
    iEXP = ConvertPercent(iEXP, 0.50f);
    int iDoOnce = GetLocalInt(oModule, "exe_a1_surviv40");

    if ((iDoOnce == FALSE) && (iPlot < 30))
    {
        SetLocalInt(oModule, "exe_a1_surviv40", TRUE);

        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(GetModule(), "A1_SURVIV", 40);
        AddJournalQuestEntry("a1_surviv", 40, oPC);
    }
}
