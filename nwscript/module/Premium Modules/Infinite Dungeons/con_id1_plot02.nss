#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_text"

string GetLocationString(string sPlot, int nGameplayType = 0, object oDungeon = OBJECT_INVALID);

int StartingConditional()
{
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
    DebugMessage("sVariable is " + sVariable);
    int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
    DebugMessage("nPlot is " + IntToString(nPlot));

    string sPlot = "Plot" + IntToString(nPlot);
    DebugMessage("sPlot is " + sPlot);

    // gameplay type
    int nGameplayType = GetLocalInt(oDungeon, "n" + sPlot + "GameplayType");
    DebugMessage("Plot gameplay type is " + IntToString(nGameplayType));

    // plot giver specifics
    int nAttitude = GetLocalInt(oDungeon, "n" + sPlot + "GiverAttitude");
    int bPlural = GetLocalInt(oDungeon, "b" + sPlot + "GiverPlural");

    // plot reward
    int nReward = GetLocalInt(oDungeon, "n" + sPlot + "Reward");

    string sToken = "";

    // temporary variable holders
    int nNum;
    string sString;

    // construct string
    if (nGameplayType == 1) // kill creatures
    {
        // payment
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverPayment");
        sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Payment" + IntToString(nNum));
        sToken += sString + " ";

        // reward
        sToken += IntToString(nReward) + " gold and experience for each ";

        // singular monster name
        int nCreatureType = GetLocalInt(oDungeon, "n" + sPlot + "Creature");
        string sCreatureName = GetLocalString(oDungeon, "sListCreature" + IntToString(nCreatureType) + "NameSingular");
        if (sCreatureName == "")
        {
            sCreatureName = "Penguin";
        }
        sToken += sCreatureName + " you ";

        // verb kill
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbKill");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbKill" + IntToString(nNum));
        sToken += sString + ". ";

        // confirmation
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverConfirmation");
        sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Confirmation" + IntToString(nNum));
        sToken += sString;
    } else if (nGameplayType == 2) // clear areas
    {
        // verb kill
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbKill");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbKill" + IntToString(nNum));
        sToken += "When you " + sString + " all enemies in the areas I specify on ";

        // location
        sToken += GetLocationString(sPlot, nGameplayType, oDungeon) + ", I will ";

        // verb reward
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbReward");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbReward" + IntToString(nNum));
        sToken += sString + " you with ";

        // reward
        sToken += IntToString(nReward) + " gold and experience. ";

        // confirmation
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverConfirmation");
        sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Confirmation" + IntToString(nNum));
        sToken += sString;
    } else if (nGameplayType == 3) // items on creatures
    {
        // payment
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverPayment");
        sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Payment" + IntToString(nNum));
        sToken += sString + " ";

        // reward
        sToken += IntToString(nReward) + " gold and experience for each ";

        // item name
        int nItemType = GetLocalInt(oDungeon, "n" + sPlot + "Item");
        string sItemName = GetLocalString(oDungeon, "sListItem" + IntToString(nItemType) + "Name");
        sToken += sItemName + " you ";

        // verb fetch
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbFetch");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbFetch" + IntToString(nNum));
        sToken += sString + ". ";

        // confirmation
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverConfirmation");
        sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Confirmation" + IntToString(nNum));
        sToken += sString;
    } else if (nGameplayType == 4) // items on placeables
    {
        // payment
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverPayment");
        sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Payment" + IntToString(nNum));
        sToken += sString + " ";

        // reward
        sToken += IntToString(nReward) + " gold and experience for each ";

        // item name
        int nItemType = GetLocalInt(oDungeon, "n" + sPlot + "Item");
        string sItemName = GetLocalString(oDungeon, "sListItem" + IntToString(nItemType) + "Name");
        sToken += sItemName + " you ";

        // verb fetch
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbFetch");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbFetch" + IntToString(nNum));
        sToken += sString + ". ";

        // confirmation
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverConfirmation");
        sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Confirmation" + IntToString(nNum));
        sToken += sString;
    } else if (nGameplayType == 5) // explore areas
    {
        // verb explore
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbExplore");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbExplore" + IntToString(nNum));
        sToken += "When you " + sString + " the areas I specify on ";

        // location
        sToken += GetLocationString(sPlot, nGameplayType, oDungeon) + ", I will ";

        // verb reward
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbReward");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbReward" + IntToString(nNum));
        sToken += sString + " you with ";

        // reward
        sToken += IntToString(nReward) + " gold and experience. ";

        // confirmation
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverConfirmation");
        sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Confirmation" + IntToString(nNum));
        sToken += sString;
    } else if (nGameplayType == 6) // find creature
    {
        // destination name
        string sCreatureName = GetLocalString(oDungeon, "s" + sPlot + "CreatureName");
        sToken += "Once you have spoken to " + sCreatureName + ", the ";

        // singular monster type
        int nCreatureType = GetLocalInt(oDungeon, "n" + sPlot + "Creature");
        string sCreatureType = GetLocalString(oDungeon, "sListCreature" + IntToString(nCreatureType) + "NameSingular");
        if (sCreatureType == "")
        {
            sCreatureType = "Penguin";
        }
        sToken += sCreatureType + " will ";

        // verb reward
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbReward");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbReward" + IntToString(nNum));
        sToken += sString + " you with ";

        // reward
        sToken += IntToString(nReward) + " gold and experience. ";

        // confirmation
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverConfirmation");
        sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Confirmation" + IntToString(nNum));
        sToken += sString;
    } else if (nGameplayType == 7) // find object
    {
        // singular placeable type
        int nPlaceableType = GetLocalInt(oDungeon, "n" + sPlot + "Placeable");
        string sPlaceableType = GetLocalString(oDungeon, "sListPlotContainer" + IntToString(nPlaceableType) + "Name");

        // Update Dec 14, 2005: text editing for lines that did not make sense.
        sToken += "Once you find the " + sPlaceableType + " and use it, you will receive ";

        // location
        //sToken += GetLocationString(sPlot, nGameplayType, oDungeon) + ". It is a very specific " + sPlaceableType;

        // End update.

        // reward
        sToken += IntToString(nReward) + " gold and experience to ";

        // verb reward
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbReward");
        sString = GetLocalString(GetModule(), "sLinesPlotVerbReward" + IntToString(nNum));
        sToken += sString + " you. ";

        // confirmation
        nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverConfirmation");
        sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Confirmation" + IntToString(nNum));
        sToken += sString;
    }

    // set the custom token
    SetCustomToken(5001, sToken);

    return TRUE;
}

string GetLocationString(string sPlot, int nGameplayType = 0, object oDungeon = OBJECT_INVALID)
{
    if (oDungeon == OBJECT_INVALID)
    {
        oDungeon = GetCurrentDungeon();
    }

    // level details
    int nLevelNum = GetLocalInt(oDungeon, "n" + sPlot + "LevelNum");
    DebugMessage("Plot has " + IntToString(nLevelNum) + " levels.");
    int nLevel = 1;
    int nTargetLevel;
    int nMaxLevel = GetLocalInt(oDungeon, "nMaxLevel");
    string sLevel;
    int nAreaNum;
    int nArea;
    int nX;
    int nY;
    string sArea;
    int nTargetArea;
    int bExplored;
    int bCleared;
    string sToken = "";
    while (nLevel <= nLevelNum)
    {
        DebugMessage("On level " + IntToString(nLevel) + " of " + IntToString(nLevelNum));

        // determine level
        nTargetLevel = GetLocalInt(oDungeon, "n" + sPlot + "Level" + IntToString(nLevel));
        sToken += "Level " + IntToString(nTargetLevel);

        if (nLevel < nLevelNum)
        {
            sToken += ", ";
        }

        nLevel++;
    }

    return sToken;
}

