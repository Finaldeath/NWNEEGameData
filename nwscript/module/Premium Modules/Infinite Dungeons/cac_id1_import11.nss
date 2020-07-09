void main()
{
    // get the dungeon to be examined
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    int bFail = FALSE;

    int nAttitude = 1;
    int nDungeon;
    int nModule;
    while ((nAttitude <= 2) && (bFail == FALSE))
    {
        // greeting
        nDungeon = GetLocalInt(oImport, "nListMerchantAttitude" + IntToString(nAttitude) + "Greeting");
        nModule = GetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "GreetingNum");
        if (nDungeon > nModule)
        {
            bFail = TRUE;
        }

        // offer
        nDungeon = GetLocalInt(oImport, "nListMerchantAttitude" + IntToString(nAttitude) + "Offer");
        nModule = GetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "OfferNum");
        if (nDungeon > nModule)
        {
            bFail = TRUE;
        }

        // good
        nDungeon = GetLocalInt(oImport, "nListMerchantAttitude" + IntToString(nAttitude) + "Good");
        nModule = GetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "GoodNum");
        if (nDungeon > nModule)
        {
            bFail = TRUE;
        }

        // show
        nDungeon = GetLocalInt(oImport, "nListMerchantAttitude" + IntToString(nAttitude) + "Show");
        nModule = GetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "ShowNum");
        if (nDungeon > nModule)
        {
            bFail = TRUE;
        }

        // farewell
        nDungeon = GetLocalInt(oImport, "nListMerchantAttitude" + IntToString(nAttitude) + "Farewell");
        nModule = GetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "FarewellNum");
        if (nDungeon > nModule)
        {
            bFail = TRUE;
        }

        nAttitude++;
    }

    SetLocalInt(OBJECT_SELF, "bImportFailed", bFail);
}
