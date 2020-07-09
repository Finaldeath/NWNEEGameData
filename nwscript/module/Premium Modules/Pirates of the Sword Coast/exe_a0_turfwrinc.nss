//::///////////////////////////////////////////////
//:: exe_a0_turfwrinc
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Increment the number of hideouts taken down.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"
void DisableEncounters(string sEcountTag);

void main()
{
    object oPC = OBJECT_SELF;
    object oModule = GetModule();
    object oController;
    int iEXP = GetJournalQuestExperience("a0_turfwr");

    int iPlot = GetLocalInt(oModule, "A0_TURFWR");

    if ((iPlot > 10) && (iPlot < 100))
    {
        iPlot = iPlot + 20;
        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A0_TURFWR", iPlot);
        AddJournalQuestEntry("a0_turfwr", iPlot, oPC);
    }

    // The seige is done.
    if (iPlot == 100)
    {
        oController = GetObjectByTag("a0_spwnbnd");
        SetLocalInt(oController, "CONTROLLER_DISABLED", TRUE);
        DisableEncounters("BlackriverBanditEncounter");
    }
    else if (iPlot == 110)
    {
        oController = GetObjectByTag("a0_spwnbld");
        SetLocalInt(oController, "CONTROLLER_DISABLED", TRUE);
        DisableEncounters("BloodsailorEncounter");
    }
}

void DisableEncounters(string sEcountTag)
{
    int iCursor = 0;
    object oTagCursor = GetObjectByTag(sEcountTag, iCursor++);

    while (GetIsObjectValid(oTagCursor) == TRUE)
    {
        SetEncounterActive(FALSE, oTagCursor);
        oTagCursor = GetObjectByTag(sEcountTag, iCursor++);
    }
}
