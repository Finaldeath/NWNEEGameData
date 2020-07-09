void main()
{
    // get the dungeon to be examined
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    int bFail = FALSE;

    int nDungeon;
    int nModule;

    // greetings
    nDungeon = GetLocalInt(oImport, "nListHirelingGreeting");
    nModule = GetLocalInt(GetModule(), "nLinesHirelingGreetingNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // adventurer
    nDungeon = GetLocalInt(oImport, "nListHirelingAdventurer");
    nModule = GetLocalInt(GetModule(), "nLinesHirelingAdventurerNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // beenlived
    nDungeon = GetLocalInt(oImport, "nListHirelingBeenLived");
    nModule = GetLocalInt(GetModule(), "nLinesHirelingBeenLivedNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // time
    nDungeon = GetLocalInt(oImport, "nListHirelingTime");
    nModule = GetLocalInt(GetModule(), "nLinesHirelingTimeNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // useful
    nDungeon = GetLocalInt(oImport, "nListHirelingUseful");
    nModule = GetLocalInt(GetModule(), "nLinesHirelingUsefulNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // hiring
    nDungeon = GetLocalInt(oImport, "nListHirelingHiring");
    nModule = GetLocalInt(GetModule(), "nLinesHirelingHiringNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // ask
    nDungeon = GetLocalInt(oImport, "nListHirelingAsk");
    nModule = GetLocalInt(GetModule(), "nLinesHirelingAskNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // treasure
    nDungeon = GetLocalInt(oImport, "nListHirelingTreasure");
    nModule = GetLocalInt(GetModule(), "nLinesHirelingTreasureNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // refused
    nDungeon = GetLocalInt(oImport, "nListHirelingRefused");
    nModule = GetLocalInt(GetModule(), "nLinesHirelingRefusedNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // accepted
    nDungeon = GetLocalInt(oImport, "nListHirelingAccepted");
    nModule = GetLocalInt(GetModule(), "nLinesHirelingAcceptedNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    SetLocalInt(OBJECT_SELF, "bImportFailed", bFail);
}
