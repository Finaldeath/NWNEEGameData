void main()
{
    // get the dungeon to be examined
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    int bFail = FALSE;

    int nDungeon;
    int nModule;

    // attitude
    int nAttitude = 1;
    while ((nAttitude <= 4) && (bFail == FALSE))
    {
        // greeting
        nDungeon = GetLocalInt(oImport, "nListPlotAttitude" + IntToString(nAttitude) + "Greeting");
        nModule = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "GreetingNum");
        if (nDungeon > nModule)
        {
            bFail = TRUE;
        }

        // introduction
        nDungeon = GetLocalInt(oImport, "nListPlotAttitude" + IntToString(nAttitude) + "Introduction");
        nModule = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "IntroductionNum");
        if (nDungeon > nModule)
        {
            bFail = TRUE;
        }

        // name
        nDungeon = GetLocalInt(oImport, "nListPlotAttitude" + IntToString(nAttitude) + "Name");
        nModule = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "NameNum");
        if (nDungeon > nModule)
        {
            bFail = TRUE;
        }

        // payment
        nDungeon = GetLocalInt(oImport, "nListPlotAttitude" + IntToString(nAttitude) + "Payment");
        nModule = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "PaymentNum");
        if (nDungeon > nModule)
        {
            bFail = TRUE;
        }

        // confirmation
        nDungeon = GetLocalInt(oImport, "nListPlotAttitude" + IntToString(nAttitude) + "Confirmation");
        nModule = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "ConfirmationNum");
        if (nDungeon > nModule)
        {
            bFail = TRUE;
        }

        // good response
        nDungeon = GetLocalInt(oImport, "nListPlotAttitude" + IntToString(nAttitude) + "GoodResponse");
        nModule = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "GoodResponseNum");
        if (nDungeon > nModule)
        {
            bFail = TRUE;
        }

        // farewell
        nDungeon = GetLocalInt(oImport, "nListPlotAttitude" + IntToString(nAttitude) + "Farewell");
        nModule = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "FarewellNum");
        if (nDungeon > nModule)
        {
            bFail = TRUE;
        }

        // bad response
        nDungeon = GetLocalInt(oImport, "nListPlotAttitude" + IntToString(nAttitude) + "BadResponse");
        nModule = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "BadResponseNum");
        if (nDungeon > nModule)
        {
            bFail = TRUE;
        }

        // return
        nDungeon = GetLocalInt(oImport, "nListPlotAttitude" + IntToString(nAttitude) + "Return");
        nModule = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "ReturnNum");
        if (nDungeon > nModule)
        {
            bFail = TRUE;
        }

        // complete
        nDungeon = GetLocalInt(oImport, "nListPlotAttitude" + IntToString(nAttitude) + "Complete");
        nModule = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "CompleteNum");
        if (nDungeon > nModule)
        {
            bFail = TRUE;
        }

        // incomplete
        nDungeon = GetLocalInt(oImport, "nListPlotAttitude" + IntToString(nAttitude) + "Incomplete");
        nModule = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "IncompleteNum");
        if (nDungeon > nModule)
        {
            bFail = TRUE;
        }

        nAttitude++;
    }

    // personal singular
    nDungeon = GetLocalInt(oImport, "nListPlotPersonalSingular");
    nModule = GetLocalInt(GetModule(), "nLinesPlotPersonalReferenceSingularNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // personal plural
    nDungeon = GetLocalInt(oImport, "nListPlotPersonalPlural");
    nModule = GetLocalInt(GetModule(), "nLinesPlotPersonalReferencePluralNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // verb want singular
    nDungeon = GetLocalInt(oImport, "nListPlotVerbWantSingular");
    nModule = GetLocalInt(GetModule(), "nLinesPlotVerbWantSingularNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // verb want plural
    nDungeon = GetLocalInt(oImport, "nListPlotVerbWantPlural");
    nModule = GetLocalInt(GetModule(), "nLinesPlotVerbWantPluralNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // adverb
    nDungeon = GetLocalInt(oImport, "nListPlotAdverb");
    nModule = GetLocalInt(GetModule(), "nLinesPlotAdverbNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // prep phrase
    nDungeon = GetLocalInt(oImport, "nListPlotPrepPhrase");
    nModule = GetLocalInt(GetModule(), "nLinesPlotPrepPhraseNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // verb living
    nDungeon = GetLocalInt(oImport, "nListPlotVerbLiving");
    nModule = GetLocalInt(GetModule(), "nLinesPlotVerbLivingNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // verb fetch
    nDungeon = GetLocalInt(oImport, "nListPlotVerbFetch");
    nModule = GetLocalInt(GetModule(), "nLinesPlotVerbFetchNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // verb kill
    nDungeon = GetLocalInt(oImport, "nListPlotVerbKill");
    nModule = GetLocalInt(GetModule(), "nLinesPlotVerbKillNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // verb explore
    nDungeon = GetLocalInt(oImport, "nListPlotVerbExplore");
    nModule = GetLocalInt(GetModule(), "nLinesPlotVerbExploreNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // verb see
    nDungeon = GetLocalInt(oImport, "nListPlotVerbSee");
    nModule = GetLocalInt(GetModule(), "nLinesPlotVerbSeeNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // noun there
    nDungeon = GetLocalInt(oImport, "nListPlotNounThere");
    nModule = GetLocalInt(GetModule(), "nLinesPlotNounThereNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // verb reward
    nDungeon = GetLocalInt(oImport, "nListPlotVerbReward");
    nModule = GetLocalInt(GetModule(), "nLinesPlotVerbRewardNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // verb speak to
    nDungeon = GetLocalInt(oImport, "nListPlotVerbSpeakTo");
    nModule = GetLocalInt(GetModule(), "nLinesPlotVerbSpeakToNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // verb use
    nDungeon = GetLocalInt(oImport, "nListPlotVerbUse");
    nModule = GetLocalInt(GetModule(), "nLinesPlotVerbUseNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    SetLocalInt(OBJECT_SELF, "bImportFailed", bFail);
}
