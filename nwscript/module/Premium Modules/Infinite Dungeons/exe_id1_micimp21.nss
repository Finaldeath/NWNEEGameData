#include "inc_id1_utility"

void main()
{
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    object oParent = GetLocalObject(OBJECT_SELF, "oParent");

    DebugMessage("");
    DebugMessage("Specific import details.");

    // EDIT: clear specific import details
    DebugMessage("  Clearing specific dungeon numbers.");

    // boss teleporter
    SetLocalInt(oImport, "bBossTeleporter", FALSE);

    SetLocalInt(oImport, "bBossDead", FALSE);

    // boss activated
    SetLocalInt(oImport, "bBossActivated", FALSE);

    // boss level
    SetLocalInt(oImport, "nBossLevel", 0);

    // boss detect
    SetLocalInt(oImport, "bBossDetect", FALSE);

    SetLocalInt(oImport, "nBossQuest", 0);
    SetLocalInt(oImport, "nBossQuestBoss", 0);
    SetLocalInt(oImport, "nBossPlotDepth", 0);
    SetLocalInt(oImport, "nBossPlotArea", 0);

    int nNum;
    string sString;
    int nCount;

    nNum = GetLocalInt(oImport, "nListDecorOpenNum");
    SetLocalInt(oImport, "nListDecorOpenNum", 0);
    nCount = 1;
    while (nCount <= nNum)
    {
        sString = GetLocalString(oImport, "sListDecorOpenNum" + IntToString(nCount) + "ResRef");
        SetLocalInt(oImport, "nListDecorOpenNum_" + sString, 0);

        nCount++;
    }

    nNum = GetLocalInt(oImport, "nListDecorWallNum");
    SetLocalInt(oImport, "nListDecorWallNum", 0);
    nCount = 1;
    while (nCount <= nNum)
    {
        sString = GetLocalString(oImport, "sListDecorWallNum" + IntToString(nCount) + "ResRef");
        SetLocalInt(oImport, "nListDecorWallNum_" + sString, 0);

        nCount++;
    }

    nNum = GetLocalInt(oImport, "nListItemNum");
    SetLocalInt(oImport, "nListItemNum", 0);
    nCount = 1;
    while (nCount <= nNum)
    {
        sString = GetLocalString(oImport, "sListItemNum" + IntToString(nCount) + "ResRef");
        SetLocalInt(oImport, "nListItemNum_" + sString, 0);

        nCount++;
    }

    nNum = GetLocalInt(oImport, "nListDamageTypeNum");
    SetLocalInt(oImport, "nListDamageTypeNum", 0);
    nCount = 1;
    while (nCount <= nNum)
    {
        sString = IntToString(GetLocalInt(oImport, "sListDamageTypeNum" + IntToString(nCount) + "ID"));
        SetLocalInt(oImport, "nListDamageTypeNum_" + sString, 0);

        nCount++;
    }

    nNum = GetLocalInt(oImport, "nListContainerNum");
    SetLocalInt(oImport, "nListContainerNum", 0);
    nCount = 1;
    while (nCount <= nNum)
    {
        sString = GetLocalString(oImport, "sListContainerNum" + IntToString(nCount) + "ResRef");
        SetLocalInt(oImport, "nListContainerNum_" + sString, 0);

        nCount++;
    }

    nNum = GetLocalInt(oImport, "nListPuzzleNum");
    SetLocalInt(oImport, "nListPuzzleNum", 0);
    nCount = 1;
    while (nCount <= nNum)
    {
        sString = GetLocalString(oImport, "sListPuzzleNum" + IntToString(nCount) + "Script");
        SetLocalInt(oImport, "nListPuzzleNum_" + sString, 0);

        nCount++;
    }

    nNum = GetLocalInt(oImport, "nListPlotContainerNum");
    SetLocalInt(oImport, "nListPlotContainerNum", 0);
    nCount = 1;
    while (nCount <= nNum)
    {
        sString = GetLocalString(oImport, "sListPlotContainerNum" + IntToString(nCount) + "ResRef");
        SetLocalInt(oImport, "nListPlotContainerNum_" + sString, 0);

        nCount++;
    }

    nNum = GetLocalInt(oImport, "nListCreatureNum");
    SetLocalInt(oImport, "nListCreatureNum", 0);
    nCount = 1;
    while (nCount <= nNum)
    {
        sString = GetLocalString(oImport, "sListCreatureNum" + IntToString(nCount) + "ResRef");
        SetLocalInt(oImport, "nListCreatureNum_" + sString, 0);

        nCount++;
    }

    nCount = 1;
    while (nCount <= 2)
    {
        SetLocalInt(oImport, "nListMerchantAttitude" + IntToString(nCount) + "Greeting", 0);
        SetLocalInt(oImport, "nListMerchantAttitude" + IntToString(nCount) + "Offer", 0);
        SetLocalInt(oImport, "nListMerchantAttitude" + IntToString(nCount) + "Good", 0);
        SetLocalInt(oImport, "nListMerchantAttitude" + IntToString(nCount) + "Show", 0);
        SetLocalInt(oImport, "nListMerchantAttitude" + IntToString(nCount) + "Farewell", 0);

        nCount++;
    }

    SetLocalInt(oImport, "nListHirelingGreeting", 0);
    SetLocalInt(oImport, "nListHirelingAdventurer", 0);
    SetLocalInt(oImport, "nListHirelingBeenLived", 0);
    SetLocalInt(oImport, "nListHirelingTime", 0);
    SetLocalInt(oImport, "nListHirelingUseful", 0);
    SetLocalInt(oImport, "nListHirelingHiring", 0);
    SetLocalInt(oImport, "nListHirelingAsk", 0);
    SetLocalInt(oImport, "nListHirelingTreasure", 0);
    SetLocalInt(oImport, "nListHirelingRefused", 0);
    SetLocalInt(oImport, "nListHirelingAccepted", 0);

    SetLocalInt(oImport, "nListSellerGreeting", 0);
    SetLocalInt(oImport, "nListSellerAsking", 0);
    SetLocalInt(oImport, "nListSellerPurchase", 0);
    SetLocalInt(oImport, "nListSellerPoor", 0);
    SetLocalInt(oImport, "nListSellerBought", 0);
    SetLocalInt(oImport, "nListSellerGoodbye", 0);

    SetLocalInt(oImport, "nListCasterGreeting", 0);
    SetLocalInt(oImport, "nListCasterDescription", 0);
    SetLocalInt(oImport, "nListCasterQuestion", 0);
    SetLocalInt(oImport, "nListCasterRemainder", 0);
    SetLocalInt(oImport, "nListCasterSpells", 0);
    SetLocalInt(oImport, "nListCasterCast", 0);
    SetLocalInt(oImport, "nListCasterFarewell", 0);

    nCount = 1;
    while (nCount <= 4)
    {
        SetLocalInt(oImport, "nListPlotAttitude" + IntToString(nCount) + "Greeting", 0);
        SetLocalInt(oImport, "nListPlotAttitude" + IntToString(nCount) + "Introduction", 0);
        SetLocalInt(oImport, "nListPlotAttitude" + IntToString(nCount) + "Name", 0);
        SetLocalInt(oImport, "nListPlotAttitude" + IntToString(nCount) + "Payment", 0);
        SetLocalInt(oImport, "nListPlotAttitude" + IntToString(nCount) + "Confirmation", 0);
        SetLocalInt(oImport, "nListPlotAttitude" + IntToString(nCount) + "GoodResponse", 0);
        SetLocalInt(oImport, "nListPlotAttitude" + IntToString(nCount) + "Farewell", 0);
        SetLocalInt(oImport, "nListPlotAttitude" + IntToString(nCount) + "BadResponse", 0);
        SetLocalInt(oImport, "nListPlotAttitude" + IntToString(nCount) + "Return", 0);
        SetLocalInt(oImport, "nListPlotAttitude" + IntToString(nCount) + "Complete", 0);
        SetLocalInt(oImport, "nListPlotAttitude" + IntToString(nCount) + "Incomplete", 0);

        nCount++;
    }
    SetLocalInt(oImport, "nListPlotPersonalSingular", 0);
    SetLocalInt(oImport, "nListPlotPersonalPlural", 0);
    SetLocalInt(oImport, "nListPlotVerbWantSingular", 0);
    SetLocalInt(oImport, "nListPlotVerbWantPlural", 0);
    SetLocalInt(oImport, "nListPlotAdverb", 0);
    SetLocalInt(oImport, "nListPlotPrepPhrase", 0);
    SetLocalInt(oImport, "nListPlotVerbLiving", 0);
    SetLocalInt(oImport, "nListPlotVerbFetch", 0);
    SetLocalInt(oImport, "nListPlotVerbKill", 0);
    SetLocalInt(oImport, "nListPlotVerbExplore", 0);
    SetLocalInt(oImport, "nListPlotVerbSee", 0);
    SetLocalInt(oImport, "nListPlotNounThere", 0);
    SetLocalInt(oImport, "nListPlotVerbReward", 0);
    SetLocalInt(oImport, "nListPlotVerbSpeakTo", 0);
    SetLocalInt(oImport, "nListPlotVerbUse", 0);

    int nMicroNum = GetLocalInt(GetModule(), "nImportMicroNum");
    int nMicroDead = GetLocalInt(GetModule(), "nImportMicroDead");
    nMicroDead++;
    SetLocalInt(GetModule(), "nImportMicroDead", nMicroDead);
    DebugMessage("  There are " + IntToString(nMicroNum) + " living and " + IntToString(nMicroDead) + " dead microprocesses.");
    if (nMicroDead >= nMicroNum)
    {
        AssignCommand(oParent, ActionResumeConversation());
    }
    DelayCommand(0.01, DestroyObject(OBJECT_SELF));
}
