void main()
{
    // get the dungeon to be examined
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    int bFail = FALSE;

    int nDungeon;
    int nModule;

    // greeting
    nDungeon = GetLocalInt(oImport, "nListSellerGreeting");
    nModule = GetLocalInt(GetModule(), "nLinesSellerGreetingNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // asking
    nDungeon = GetLocalInt(oImport, "nListSellerAsking");
    nModule = GetLocalInt(GetModule(), "nLinesSellerAskingNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // purchase
    nDungeon = GetLocalInt(oImport, "nListSellerPurchase");
    nModule = GetLocalInt(GetModule(), "nLinesSellerPurchaseNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // poor
    nDungeon = GetLocalInt(oImport, "nListSellerPoor");
    nModule = GetLocalInt(GetModule(), "nLinesSellerPoorNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // bought
    nDungeon = GetLocalInt(oImport, "nListSellerBought");
    nModule = GetLocalInt(GetModule(), "nLinesSellerBoughtNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // goodbye
    nDungeon = GetLocalInt(oImport, "nListSellerGoodbye");
    nModule = GetLocalInt(GetModule(), "nLinesSellerGoodbyeNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }


    SetLocalInt(OBJECT_SELF, "bImportFailed", bFail);
}
