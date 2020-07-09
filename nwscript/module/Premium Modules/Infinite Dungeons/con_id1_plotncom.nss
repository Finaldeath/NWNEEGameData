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

    // if quest has not been activated
    int bCompleted = GetLocalInt(oDungeon, "b" + sPlot + "Completed");
    if (bCompleted == FALSE)
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

        // reward
        int nReward = GetLocalInt(oDungeon, "n" + sPlot + "Reward");

        string sToken = "";

        // temporary variable holders
        int nNum;
        string sString;

        if (nGameplayType == 1)
        {
            int nKilled = GetLocalInt(oDungeon, "n" + sPlot + "CreaturesKilled");

            if (nKilled == 0)
            {
                // return
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverReturn");
                sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Return" + IntToString(nNum));
                sToken += sString + " You haven't managed to ";

                // verb kill
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbKill");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbKill" + IntToString(nNum));
                sToken += sString + " any ";

                // plural monster type
                int nCreatureType = GetLocalInt(oDungeon, "n" + sPlot + "Creature");
                string sCreatureType = GetLocalString(oDungeon, "sListCreature" + IntToString(nCreatureType) + "NamePlural");
                if (sCreatureType == "")
                {
                    sCreatureType = "Penguins";
                }
                sToken += sCreatureType + " since we last spoke. ";

                // payment
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverPayment");
                sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Payment" + IntToString(nNum));
                sToken += sString + " ";

                // reward
                sToken += IntToString(nReward) + " gold and experience for each one you ";

                // verb kill
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbKill");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbKill" + IntToString(nNum));
                sToken += sString + ". Some are ";

                // verb living
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbLiving");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbLiving" + IntToString(nNum));
                sToken += sString + " on ";

                // location
                sToken += GetLocationString(sPlot, nGameplayType, oDungeon) + ". ";
            } else
            {
                // return
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverReturn");
                sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Return" + IntToString(nNum));
                sToken += sString + " You have managed to ";

                // verb kill
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbKill");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbKill" + IntToString(nNum));
                sToken += sString + " " + IntToString(nKilled) + " ";

                // plural monster type
                int nCreatureType = GetLocalInt(oDungeon, "n" + sPlot + "Creature");
                string sCreatureType = GetLocalString(oDungeon, "sListCreature" + IntToString(nCreatureType) + "NamePlural");
                if (sCreatureType == "")
                {
                    sCreatureType = "Penguins";
                }
                sToken += sCreatureType + " since we last spoke. I will ";

                // verb reward
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbReward");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbReward" + IntToString(nNum));
                sToken += sString + " you with ";

                // reward
                sToken += IntToString(nReward) + " gold and experience for each one. More are ";

                // verb living
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbLiving");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbLiving" + IntToString(nNum));
                sToken += sString + " on ";

                // location
                sToken += GetLocationString(sPlot, nGameplayType, oDungeon) + ". ";
            }
        } else if ((nGameplayType == 2) || (nGameplayType == 5))
        {
            if (nGameplayType == 2)
            {
                // return
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverReturn");
                sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Return" + IntToString(nNum));
                sToken += sString + " You haven't managed to ";

                // verb kill
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbKill");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbKill" + IntToString(nNum));
                sToken += sString + " all the enemies in the areas I need on ";

                // location
                sToken += GetLocationString(sPlot, nGameplayType, oDungeon) + ". When you reach those levels, your dungeon journal will list the areas I specify. I will ";

                // verb reward
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbReward");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbReward" + IntToString(nNum));
                sToken += sString + " you with ";

                // reward
                sToken += IntToString(nReward) + " gold and experience when you do. ";

                // incomplete
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverIncomplete");
                sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Incomplete" + IntToString(nNum));
                sToken += sString;
            } else
            {
                // return
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverReturn");
                sString = GetLocalString(oDungeon, "sLinesPlotAttitude" + IntToString(nAttitude) + "Return" + IntToString(nNum));
                sToken += sString + " You haven't had time to ";

                // verb explore
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbExplore");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbExplore" + IntToString(nNum));
                sToken += sString + " all the areas I need on ";

                // location
                sToken += GetLocationString(sPlot, nGameplayType, oDungeon) + ". When you reach those levels, your dungeon journal will list the areas I specify. I will ";

                // verb reward
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbReward");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbReward" + IntToString(nNum));
                sToken += sString + " you with ";

                // reward
                sToken += IntToString(nReward) + " gold and experience when you do. ";

                // incomplete
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverIncomplete");
                sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Incomplete" + IntToString(nNum));
                sToken += sString;
            }
        } else if ((nGameplayType == 3) || (nGameplayType == 4))
        {
            // search player's inventory for the item
            int nItemType = GetLocalInt(oDungeon, "n" + sPlot + "Item");
            string sItemTag = GetLocalString(oDungeon, "sListItem" + IntToString(nItemType) + "ResRef");
            DebugMessage("sItemTag is " + sItemTag);

            object oPC = GetPCSpeaker();

            int nItemNum = 0;
            int nStackSize;
            string sResRef;
            object oObject = GetFirstItemInInventory(oPC);
            while (oObject != OBJECT_INVALID)
            {
                sResRef = GetResRef(oObject);
                DebugMessage("Item resref is " + sResRef);
                if (sResRef == sItemTag)
                {
                    nStackSize = GetItemStackSize(oObject);
                    nItemNum += nStackSize;
                    DebugMessage("  This item is stack size " + IntToString(nStackSize) + " bringing the total to " + IntToString(nItemNum));

    //                DestroyObject(oObject);
                }

                // get next object
                oObject = GetNextItemInInventory(oPC);
            }

            string sItemName = GetLocalString(oDungeon, "sListItem" + IntToString(nItemType) + "Name");
            if (nItemNum == 0)
            {
                // return
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverReturn");
                sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Return" + IntToString(nNum));
                sToken += sString + " You haven't managed to ";

                // verb fetch
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbFetch");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbFetch" + IntToString(nNum));
                sToken += sString + " any " + sItemName + " since we last spoke. ";

                // payment
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverPayment");
                sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Payment" + IntToString(nNum));
                sToken += sString + " ";

                // reward
                sToken += IntToString(nReward) + " gold and experience for each one you ";

                // verb fetch
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbFetch");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbFetch" + IntToString(nNum));
                sToken += sString + ". Some are ";

                if (nGameplayType == 3)
                {
                    sToken += "on creatures ";

                    // verb living
                    nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbLiving");
                    sString = GetLocalString(GetModule(), "sLinesPlotVerbLiving" + IntToString(nNum));
                    sToken += sString + " on ";
                } else
                {
                    sToken += "in containers on ";
                }

                // location
                sToken += GetLocationString(sPlot, nGameplayType, oDungeon) + ".";
            } else
            {
                SetLocalInt(OBJECT_SELF, "nItemNum", nItemNum);

                // return
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverReturn");
                sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Return" + IntToString(nNum));
                sToken += sString + " You have managed to ";

                // verb fetch
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbFetch");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbFetch" + IntToString(nNum));
                sToken += sString + " " + IntToString(nItemNum) + " " + sItemName + " since we last spoke. I will ";

                // verb reward
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbReward");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbReward" + IntToString(nNum));
                sToken += sString + " you with ";

                // reward
                sToken += IntToString(nReward) + " gold and experience for each one. More are ";

                if (nGameplayType == 3)
                {
                    sToken += "on creatures ";

                    // verb living
                    nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbLiving");
                    sString = GetLocalString(GetModule(), "sLinesPlotVerbLiving" + IntToString(nNum));
                    sToken += sString + " on ";
                } else
                {
                    sToken += "in containers on ";
                }

                // location
                sToken += GetLocationString(sPlot, nGameplayType, oDungeon) + ".";
            }
        } else if ((nGameplayType == 6) || (nGameplayType == 7))
        {
            if (nGameplayType == 6) // creature
            {
                // return
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverReturn");
                sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Return" + IntToString(nNum));
                sToken += sString + " You haven't had time to ";

                // verb speak to
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbSpeakTo");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbSpeakTo" + IntToString(nNum));
                sToken += sString + " ";

                // destination name
                string sCreatureName = GetLocalString(oDungeon, "s" + sPlot + "CreatureName");
                sToken += sCreatureName + " yet, I see. I will ";

                // verb reward
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbReward");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbReward" + IntToString(nNum));
                sToken += sString + " you with ";

                // reward
                sToken += IntToString(nReward) + " gold and experience when you do. ";

                // incomplete
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverIncomplete");
                sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Incomplete" + IntToString(nNum));
                sToken += sString;
            } else if (nGameplayType == 7) // placeable
            {
                // return
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverReturn");
                sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Return" + IntToString(nNum));
                sToken += sString + " You haven't had time to ";

                // verb use
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbUse");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbUse" + IntToString(nNum));
                sToken += sString + " the ";

                // destination name
                int nPlaceableType = GetLocalInt(oDungeon, "n" + sPlot + "Placeable");
                string sPlaceableType = GetLocalString(oDungeon, "sListPlotContainer" + IntToString(nPlaceableType) + "Name");
                sToken += sPlaceableType + " yet, I see. I will ";

                // verb reward
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverVerbReward");
                sString = GetLocalString(GetModule(), "sLinesPlotVerbReward" + IntToString(nNum));
                sToken += sString + " you with ";

                // reward
                sToken += IntToString(nReward) + " gold and experience when you do. ";

                // incomplete
                nNum = GetLocalInt(oDungeon, "n" + sPlot + "GiverIncomplete");
                sString = GetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Incomplete" + IntToString(nNum));
                sToken += sString;
            }
        }

        // set the custom token
        SetCustomToken(5001, sToken);

        // plot giver specifics
        int bAccompany = GetLocalInt(oDungeon, "b" + sPlot + "GiverAccompany");
        if (bAccompany == TRUE)
        {
            object oHenchman = OBJECT_SELF;
            object oMaster = GetMaster();
            object oPC = GetPCSpeaker();
            RemoveHenchman(oMaster, oHenchman);
            AddHenchman(oPC, oHenchman);
            SetLocalInt(oHenchman, "bFollower", TRUE);
        }

        return TRUE;
    } else
    {
        return FALSE;
    }
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

