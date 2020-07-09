#include "inc_id1_debug"
#include "inc_id1_creature"
#include "inc_id1_utility"
#include "inc_id_liltimmy"


int GetPlotGameplayType();
int GetPlotLevelScope(int nGameplayType);
int GetPlotLevelNumber();
int GetLevelIncrement();
int GetPlotAreaScope(int nGameplayType);
int GetPlotAreaNumber();
int GetTargetNum(int nPartySize, int nPartyLevel);


void main()
{
    object oTempHolder = GetObjectByTag("ID1_TempHolder");

    // get current process (1 = catalogue, 2 = plot generation, 3 = detailed generation)
    int nTempProcess = GetLocalInt(oTempHolder, "nTempProcess");

    DebugMessage("");
    DebugMessage("Plot generation process is " + IntToString(nTempProcess));

    // catalog waypoints and areas
    if (nTempProcess == 1)
    {
        int nX = GetLocalInt(oTempHolder, "nCurrentX");
        int nY = GetLocalInt(oTempHolder, "nCurrentY");

        DebugMessage("  Examining area " + IntToString(nX) + "," + IntToString(nY));

        object oDungeon = GetCurrentDungeon();
        int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
        int nArea = GetLocalInt(oDungeon, "nLevel" + IntToString(nCurrentLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY));

        DebugMessage("  Returned area number " + IntToString(nArea));

        // if an area is present here
        if (nArea > 0)
        {
            // catalog area
            int nTempAreaNum = GetLocalInt(oTempHolder, "nTempAreaNum");
            nTempAreaNum++;
            SetLocalInt(oTempHolder, "nTempAreaNum", nTempAreaNum);

            SetLocalInt(oTempHolder, "nTempArea" + IntToString(nTempAreaNum) + "Area", nArea);
            DebugMessage("    Added area number " + IntToString(nArea) + " to list position " + IntToString(nTempAreaNum));

            // catalog plot waypoints
            int nWaypointNum = GetLocalInt(oDungeon, "nArea" + IntToString(nArea) + "WaypointPlot");
            DebugMessage("    There are " + IntToString(nWaypointNum) + " plot waypoints.");
            int nWaypoint = 1;
            int nTempWaypointNum;
            while (nWaypoint <= nWaypointNum)
            {
                // add the waypoint to the catalog
                nTempWaypointNum = GetLocalInt(oTempHolder, "nTempPlotWaypointNum");
                nTempWaypointNum++;
                SetLocalInt(oTempHolder, "nTempPlotWaypointNum", nTempWaypointNum);
                SetLocalInt(oTempHolder, "nTempPlotWaypoint" + IntToString(nTempWaypointNum) + "Area", nArea);
                SetLocalInt(oTempHolder, "nTempPlotWaypoint" + IntToString(nTempWaypointNum) + "Waypoint", nWaypoint);

                DebugMessage("      Setting nTempPlotWaypoint" + IntToString(nTempWaypointNum));

                // add next waypoint;
                nWaypoint++;
            }

            // catalog encounter waypoints
            int nCreatureType;
            int nCreatureTypeNum;
            int nCreatureNum;
            int nCreature;
            string sLevel;
            string sCreature;
            nWaypointNum = GetLocalInt(oDungeon, "nArea" + IntToString(nArea) + "WaypointEncounter");
            DebugMessage("    There are " + IntToString(nWaypointNum) + " encounter waypoints.");
            nWaypoint = 1;
            while (nWaypoint <= nWaypointNum)
            {
                // add the waypoint to the catalog
                nTempWaypointNum = GetLocalInt(oTempHolder, "nTempEncounterWaypointNum");
                nTempWaypointNum++;
                SetLocalInt(oTempHolder, "nTempEncounterWaypointNum", nTempWaypointNum);
                SetLocalInt(oTempHolder, "nTempEncounterWaypoint" + IntToString(nTempWaypointNum) + "Area", nArea);
                SetLocalInt(oTempHolder, "nTempEncounterWaypoint" + IntToString(nTempWaypointNum) + "Waypoint", nWaypoint);

                DebugMessage("      Setting nTempEncounterWaypoint" + IntToString(nTempWaypointNum));

                // add creatures to list
                sLevel = "Area" + IntToString(nArea) + "WaypointEncounter" + IntToString(nWaypoint) + "Level" + IntToString(nCurrentLevel);
                nCreatureNum = GetLocalInt(oDungeon, "n" + sLevel + "Size");
                DebugMessage("    There are " + IntToString(nCreatureNum) + " creatures at this waypoint.");
                nCreature = 1;
                while (nCreature <= nCreatureNum)
                {
                    // get the creature type
                    sCreature = sLevel + "Creature" + IntToString(nCreature);
                    nCreatureType = GetLocalInt(oDungeon, "sCreature");
                    DebugMessage("      Creature " + IntToString(nCreature) + " is type " + IntToString(nCreatureType));

                    // get the current number of this type of creature in the level
                    nCreatureTypeNum = GetLocalInt(oTempHolder, "nTempCreatureType" + IntToString(nCreatureType));
                    DebugMessage("        There are already " + IntToString(nCreatureTypeNum) + " creatures of type " + IntToString(nCreatureType));
                    nCreatureType++;
                    SetLocalInt(oTempHolder, "nTempCreatureType" + IntToString(nCreatureType), nCreatureTypeNum);
                    DebugMessage("        Added creature " + IntToString(nCreature) + " as number " + IntToString(nCreatureTypeNum) + " in list nTempCreatureType" + IntToString(nCreatureType));

                    // examine next creature
                    nCreature++;
                }

                // add next waypoint;
                nWaypoint++;
            }

            // catalog treasure waypoints
            nWaypointNum = GetLocalInt(oDungeon, "nArea" + IntToString(nArea) + "WaypointTreasure");
            DebugMessage("    There are " + IntToString(nWaypointNum) + " treasure waypoints.");
            nWaypoint = 1;
            while (nWaypoint <= nWaypointNum)
            {
                // add the waypoint to the catalog
                nTempWaypointNum = GetLocalInt(oTempHolder, "nTempTreasureWaypointNum");
                nTempWaypointNum++;
                SetLocalInt(oTempHolder, "nTempTreasureWaypointNum", nTempWaypointNum);
                SetLocalInt(oTempHolder, "nTempTreasureWaypoint" + IntToString(nTempWaypointNum) + "Area", nArea);
                SetLocalInt(oTempHolder, "nTempTreasureWaypoint" + IntToString(nTempWaypointNum) + "Waypoint", nWaypoint);

                DebugMessage("      Setting nTempTreasureWaypoint" + IntToString(nTempWaypointNum));

                // add next waypoint;
                nWaypoint++;
            }
        } else
        {
            DebugMessage("    Area does not exist.");
        }

        // advance to next area
        int nMaxX = GetLocalInt(oDungeon, "nMaxX");
        int nMaxY = GetLocalInt(oDungeon, "nMaxY");

        nX++;

        // if the line has finished
        if (nX > nMaxX)
        {
            nY++;

            nX = 1;
        }

        // if all lines have finished
        if (nY > nMaxY)
        {
            // set the current plot point
            nX = 1;

            // reset the Y coordinate
            nY = 1;

            // if there are plot waypoints, generate new ones, otherwise, go to final
            int nTempPlotWaypointNum = GetLocalInt(oTempHolder, "nTempPlotWaypointNum");
            if (nTempPlotWaypointNum > 0)
            {
                int nType1Frequency = GetModuleFlagValue(ID1_FLAG_PLOT_TYPE1_FREQUENCY);
                int nType2Frequency = nType1Frequency + GetModuleFlagValue(ID1_FLAG_PLOT_TYPE2_FREQUENCY);
                int nType3Frequency = nType2Frequency + GetModuleFlagValue(ID1_FLAG_PLOT_TYPE3_FREQUENCY);
                int nType4Frequency = nType3Frequency + GetModuleFlagValue(ID1_FLAG_PLOT_TYPE4_FREQUENCY);
                int nType5Frequency = nType4Frequency + GetModuleFlagValue(ID1_FLAG_PLOT_TYPE5_FREQUENCY);
                int nType6Frequency = nType5Frequency + GetModuleFlagValue(ID1_FLAG_PLOT_TYPE6_FREQUENCY);
                int nType7Frequency = nType6Frequency + GetModuleFlagValue(ID1_FLAG_PLOT_TYPE7_FREQUENCY);
                DebugMessage("Plot total value is " + IntToString(nType7Frequency));

                if (nType7Frequency > 0)
                {
                    // advance to next step in the process
                    SetLocalInt(oTempHolder, "nTempProcess", 2);
                } else
                {
                    // advance to next step in the process
                    SetLocalInt(oTempHolder, "nTempProcess", 3);
                }
            } else
            {
                // advance to next step in the process
                SetLocalInt(oTempHolder, "nTempProcess", 3);
            }
        }

        SetLocalInt(oTempHolder, "nCurrentX", nX);
        SetLocalInt(oTempHolder, "nCurrentY", nY);

        DelayCommand(0.01, ExecuteScript("exe_id1_plotgen", GetNextCPU()));
    } else if (nTempProcess == 2) // generating plots
    {
        object oDungeon = GetCurrentDungeon();
        int nDungeonDepth = GetLocalInt(oDungeon, "nDungeonDepth");
        int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
        object oPC = GetLocalObject(GetModule(), "oTempPC");

        int nPartyLevel = GetPartyLevel(oPC, FALSE);
        DebugMessage("  Party level is " + IntToString(nPartyLevel));

        int nPartySize = GetPartySize(oPC, FALSE);
        DebugMessage("  Party size is " + IntToString(nPartySize));

        nPartyLevel = GetPartyLevelSize(nPartyLevel, nPartySize);

        int nDifficulty = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_DIFFICULTY);
        DebugMessage("  Encounter difficulty adjustment is " + IntToString(nDifficulty));
        nPartyLevel += nDifficulty;
        DebugMessage("    Party level adjusted for difficulty is " + IntToString(nPartyLevel));

        int nPlotGameplayType;
        int nPlotLevelScope;
        int nPlotAreaScope;
        int nLevelNum;
        int nLevel;
        int nDestinationLevel;
        int nLevelIncrement;
        int nCreatureNum;
        int nCreatureType;
        int nCreatureSubType;
        int nItemNum;
        int nItemType;
        int nPlaceableNum;
        int nPlaceableType;
        int nPlotNum;
        int nPlotItemNum;

        string sPlotStep;
        string sPlotLevel;
        string sName;

        int nReward;
        int nTemp;
        string sTemp;

        // go through each plot waypoint
        int nPlotWaypointNum = GetLocalInt(oTempHolder, "nTempPlotWaypointNum");
        int nPlotWaypoint = GetLocalInt(oTempHolder, "nCurrentX");

        DebugMessage("  On plot waypoint " + IntToString(nPlotWaypoint) + " of " + IntToString(nPlotWaypointNum));

        // get area and waypoint number
        int nArea = GetLocalInt(oTempHolder, "nTempPlotWaypoint" + IntToString(nPlotWaypoint) + "Area");
        int nWaypoint = GetLocalInt(oTempHolder, "nTempPlotWaypoint" + IntToString(nPlotWaypoint) + "Waypoint");
        int nX = GetLocalInt(oDungeon, "nArea" + IntToString(nArea) + "Level" + IntToString(nCurrentLevel) + "X");
        int nY = GetLocalInt(oDungeon, "nArea" + IntToString(nArea) + "Level" + IntToString(nCurrentLevel) + "Y");

        DebugMessage("  Actual waypoint " + IntToString(nWaypoint) + " in area number " + IntToString(nArea));

        // get variable strings
        string sArea = "Area" + IntToString(nArea);
        string sWaypoint = sArea + "WaypointPlot" + IntToString(nWaypoint);
        string sLevel = sWaypoint + "Level" + IntToString(nCurrentLevel);

        DebugMessage("  sLevel is " + sLevel);

        // if not used already
        int bUsed = GetLocalInt(oDungeon, "b" + sLevel + "Used");
        if (bUsed == FALSE)
        {
            DebugMessage("  Waypoint is not used.");

            // determine if new plot to be generated
            int nRandom = d100();
            int nPlotPercentage = GetModuleFlagValue(ID1_FLAG_PLOT_FREQUENCY);
            if (nRandom <= nPlotPercentage)
            {
                // add new plot
                int nPlot = GetLocalInt(oDungeon, "nPlotNum");
                nPlot++;
                SetLocalInt(oDungeon, "nPlotNum", nPlot);

                string sPlot = "Plot" + IntToString(nPlot);
                DebugMessage("  sPlot is " + sPlot);

                // mark area as having a plot
                SetLocalInt(oDungeon, "bLevel" + IntToString(nCurrentLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY) + "Plot", TRUE);
                DebugMessage("  Setting bLevel" + IntToString(nCurrentLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY) + "Plot to TRUE");

                // record plot starting information
                SetLocalInt(oDungeon, "n" + sPlot + "StartLevel", nCurrentLevel);
                SetLocalInt(oDungeon, "n" + sPlot + "StartArea", nArea);
                SetLocalInt(oDungeon, "n" + sPlot + "StartWaypoint", nWaypoint);
                DebugMessage("  Recording n" + sPlot + "Start for level " + IntToString(nCurrentLevel) + ", area number " + IntToString(nArea) + ", waypoint " + IntToString(nWaypoint));

                // determine gameplay type
                nPlotGameplayType = GetPlotGameplayType();
//                nPlotGameplayType = 7; // EDIT: testing
                SetLocalInt(oDungeon, "n" + sPlot + "GameplayType", nPlotGameplayType);
                DebugMessage("  Gameplay type is " + IntToString(nPlotGameplayType));

                // determine level scope
                nPlotLevelScope = GetPlotLevelScope(nPlotGameplayType);
                DebugMessage("  Level scope is " + IntToString(nPlotLevelScope));

                // determine levels
                if (nPlotLevelScope == 1) // single level
                {
                    nLevelNum = 1;
                } else if (nPlotLevelScope == 2) // multiple levels
                {
                    nLevelNum = GetPlotLevelNumber();
                } else if (nPlotLevelScope == 3) // every remaining level
                {
                    nLevelNum = nDungeonDepth - nCurrentLevel + 1;
                }

                DebugMessage("  Levels in plot is " + IntToString(nLevelNum));

                // determine area scope
                nPlotAreaScope = GetPlotAreaScope(nPlotGameplayType);
                SetLocalInt(oDungeon, "n" + sPlot + "AreaScope", nPlotAreaScope);

                DebugMessage("  Area scope is " + IntToString(nPlotAreaScope));

                // select first level
                nLevel = 1;

                // add increment
                if (nPlotLevelScope < 3)// selected levels
                {
                    nDestinationLevel = nCurrentLevel + GetLevelIncrement();
                } else // all levels
                {
                    nDestinationLevel = nCurrentLevel;
                }

                // make sure the destination is within the dungeon
                if (nDestinationLevel > nDungeonDepth)
                {
                    nDestinationLevel = nDungeonDepth;
                }

                // add level to plot
                SetLocalInt(oDungeon, "n" + sPlot + "LevelNum", nLevel);
                SetLocalInt(oDungeon, "n" + sPlot + "Level" + IntToString(nLevel), nDestinationLevel);
                SetLocalInt(oDungeon, "n" + sPlot + "Level_" + IntToString(nDestinationLevel), nLevel);
                SetLocalInt(oDungeon, "b" + sPlot + "Level" + IntToString(nDestinationLevel) + "Used", TRUE);

                DebugMessage("    Set n" + sPlot + "Level" + IntToString(nLevel) + " to " + IntToString(nDestinationLevel));
                DebugMessage("    Set b" + sPlot + "Level" + IntToString(nDestinationLevel) + "Used to TRUE");

                // if on the last level, stop
                if (nDestinationLevel == nDungeonDepth)
                {
                    nLevelNum = nLevel;
                }

                // increment level
                nLevel++;

                // select other levels
                while (nLevel <= nLevelNum)
                {
                    // find next level
                    if (nPlotLevelScope < 3)// selected levels
                    {
                        // get how much farther down the next level is
                        nLevelIncrement = GetLevelIncrement();

                        // make sure the next level is at least 1 lower
                        if (nLevelIncrement > 0)
                        {
                            nDestinationLevel += nLevelIncrement;
                        } else
                        {
                            nDestinationLevel++;
                        }
                    } else // all levels
                    {
                        nDestinationLevel++;
                    }

                    // make sure the destination is within the dungeon
                    if (nDestinationLevel > nDungeonDepth)
                    {
                        nDestinationLevel = nDungeonDepth;
                    }

                    // add level to plot
                    SetLocalInt(oDungeon, "n" + sPlot + "LevelNum", nLevel);
                    SetLocalInt(oDungeon, "n" + sPlot + "Level" + IntToString(nLevel), nDestinationLevel);
                    SetLocalInt(oDungeon, "n" + sPlot + "Level_" + IntToString(nDestinationLevel), nLevel);
                    SetLocalInt(oDungeon, "b" + sPlot + "Level" + IntToString(nDestinationLevel) + "Used", TRUE);

                    DebugMessage("    Set n" + sPlot + "Level" + IntToString(nLevel) + " to " + IntToString(nDestinationLevel));
                    DebugMessage("    Set b" + sPlot + "Level" + IntToString(nDestinationLevel) + "Used to TRUE");

                    // if on the last level, stop
                    if (nDestinationLevel == nDungeonDepth)
                    {
                        nLevelNum = nLevel;
                    }

                    // increment level
                    nLevel++;
                }

                // set the total number of levels used
                SetLocalInt(oDungeon, "n" + sPlot + "LevelNum", nLevelNum);

                DebugMessage("  Final number of levels is " + IntToString(nLevelNum));

                // EDIT: add dialog for giver; percentages
                int nAttitude = Random(4) + 1; // attitude
                SetLocalInt(oDungeon, "n" + sPlot + "GiverAttitude", nAttitude);
                int bPlural = Random(2); // plurality
                SetLocalInt(oDungeon, "b" + sPlot + "GiverPlural", bPlural);
                int bAccompany = Random(2); // accompany
                if ((nPlotGameplayType == 2) || (nPlotGameplayType == 5))
                {
                    SetLocalInt(oDungeon, "b" + sPlot + "GiverAccompany", TRUE);
                } else
                {
                    SetLocalInt(oDungeon, "b" + sPlot + "GiverAccompany", bAccompany);
                }

                int nNum;
                int nLine;
                int nMax;

                // attitude lines
                nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "GreetingNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverGreeting", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Greeting");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Greeting", nLine);
                    DebugMessage("  Set max greeting to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "IntroductionNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverIntroduction", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Introduction");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Introduction", nLine);
                    DebugMessage("  Set max introduction to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "NameNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverName", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Name");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Name", nLine);
                    DebugMessage("  Set max name to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "PaymentNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverPayment", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Payment");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Payment", nLine);
                    DebugMessage("  Set max payment to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "ConfirmationNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverConfirmation", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Confirmation");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Confirmation", nLine);
                    DebugMessage("  Set max confirmation to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "GoodResponseNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverGoodResponse", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "GoodResponse");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "GoodResponse", nLine);
                    DebugMessage("  Set max good response to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "FarewellNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverFarewell", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Farewell");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Farewell", nLine);
                    DebugMessage("  Set max farewell to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "BadResponseNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverBadResponse", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "BadResponse");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "BadResponse", nLine);
                    DebugMessage("  Set max bad response to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "ReturnNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverReturn", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Return");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Return", nLine);
                    DebugMessage("  Set max return to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "CompleteNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverComplete", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Complete");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Complete", nLine);
                    DebugMessage("  Set max complete to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "IncompleteNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverIncomplete", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Incomplete");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotAttitude" + IntToString(nAttitude) + "Incomplete", nLine);
                    DebugMessage("  Set max greeting to " + IntToString(nLine));
                }

                // plural lines
                if (bPlural == FALSE)
                {
                    nNum = GetLocalInt(GetModule(), "nLinesPlotPersonalReferenceSingularNum");
                } else
                {
                    nNum = GetLocalInt(GetModule(), "nLinesPlotPersonalReferencePluralNum");
                }
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverPersonalReference", nLine);
                if (bPlural == TRUE)
                {
                    nMax = GetLocalInt(oDungeon, "nListPlotPersonalPlural");
                    if (nLine > nMax)
                    {
                        SetLocalInt(oDungeon, "nListPlotPersonalPlural", nLine);
                        DebugMessage("  Set max personal plural to " + IntToString(nLine));
                    }
                } else
                {
                    nMax = GetLocalInt(oDungeon, "nListPlotPersonalSingular");
                    if (nLine > nMax)
                    {
                        SetLocalInt(oDungeon, "nListPlotPersonalSingular", nLine);
                        DebugMessage("  Set max personal singular to " + IntToString(nLine));
                    }
                }

                if (bPlural == FALSE)
                {
                    nNum = GetLocalInt(GetModule(), "nLinesPlotVerbWantSingularNum");
                } else
                {
                    nNum = GetLocalInt(GetModule(), "nLinesPlotVerbWantPluralNum");
                }
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverVerbWant", nLine);
                if (bPlural == TRUE)
                {
                    nMax = GetLocalInt(oDungeon, "nListPlotVerbWantPlural");
                    if (nLine > nMax)
                    {
                        SetLocalInt(oDungeon, "nListPlotVerbWantPlural", nLine);
                        DebugMessage("  Set max verb want plural to " + IntToString(nLine));
                    }
                } else
                {
                    nMax = GetLocalInt(oDungeon, "nListPlotVerbWantSingular");
                    if (nLine > nMax)
                    {
                        SetLocalInt(oDungeon, "nListPlotVerbWantSingular", nLine);
                        DebugMessage("  Set max verb want singular to " + IntToString(nLine));
                    }
                }

                // normal lines
                nNum = GetLocalInt(GetModule(), "nLinesPlotAdverbNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverAdverb", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotAdverb");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotAdverb", nLine);
                    DebugMessage("  Set max adverb to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotPrepPhraseNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverPrepPhrase", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotPrepPhrase");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotPrepPhrase", nLine);
                    DebugMessage("  Set max prep phrase to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotVerbLivingNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverVerbLiving", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotVerbLiving");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotVerbLiving", nLine);
                    DebugMessage("  Set max verb living to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotVerbFetchNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverVerbFetch", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotVerbFetch");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotVerbFetch", nLine);
                    DebugMessage("  Set max verb fetch to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotVerbKillNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverVerbKill", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotVerbKill");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotVerbKill", nLine);
                    DebugMessage("  Set max verb kill to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotVerbExploreNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverVerbExplore", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotVerbExplore");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotVerbExplore", nLine);
                    DebugMessage("  Set max verb explore to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotVerbSeeNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverVerbSee", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotVerbSee");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotVerbSee", nLine);
                    DebugMessage("  Set max verb see to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotNounThereNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverNounThere", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotNounThere");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotNounThere", nLine);
                    DebugMessage("  Set max noun there to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotVerbRewardNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverVerbReward", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotVerbReward");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotVerbReward", nLine);
                    DebugMessage("  Set max verb reward to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotVerbSpeakToNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverVerbSpeakTo", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotVerbSpeakTo");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotVerbSpeakTo", nLine);
                    DebugMessage("  Set max verb speak to to " + IntToString(nLine));
                }
                nNum = GetLocalInt(GetModule(), "nLinesPlotVerbUseNum");
                nLine = Random(nNum) + 1;
                SetLocalInt(oDungeon, "n" + sPlot + "GiverVerbUse", nLine);
                nMax = GetLocalInt(oDungeon, "nListPlotVerbUse");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListPlotVerbUse", nLine);
                    DebugMessage("  Set max verb use to " + IntToString(nLine));
                }

                int nValue;
                float fValue;

                // determine objectives
                if (nPlotGameplayType == 1) // kill creatures
                {
                    // determine number of creatures
                    nCreatureNum = GetTargetNum(nPartySize, nPartyLevel);
                    SetLocalInt(oDungeon, "n" + sPlot + "CreatureNum", nCreatureNum);
                    DebugMessage("  Target number of creatures is " + IntToString(nCreatureNum));

                    // generate target creature
                    object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU101");
                    SetLocalString(oMicroCPU, "sCreature", sPlot + "Creature");
                    SetLocalInt(oMicroCPU, "nCR", nPartyLevel);
                    SetLocalInt(oMicroCPU, "bIntelligentOnly", FALSE);
                    SetLocalInt(oMicroCPU, "bUnIntelligentOnly", FALSE);
                    SetLocalInt(oMicroCPU, "bMediumSizeOnly", FALSE);
                    SetLocalInt(oMicroCPU, "bBoss", FALSE);
                    SetLocalInt(oMicroCPU, "nTileset", -1);
                    SetLocalInt(oMicroCPU, "nTheme", -1);
                    SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                    SetLocalInt(oMicroCPU, "bHold", TRUE);
                    SetLocalInt(oMicroCPU, "bNoTreasure", TRUE);

                    int nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                    nMicroNum++;
                    SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

                    DelayCommand(0.01, ExecuteScript("exe_id1_micmon", oMicroCPU));

                    // determine reward
                    if (nPartyLevel < 1)
                    {
                        nReward = 100;
                    } else
                    {
                        nReward = nPartyLevel * 100;
                    }
                    nReward /= nCreatureNum;
                    if (nReward < 1)
                    {
                        nReward = 1;
                    }
                    nValue = GetModuleFlagValue(ID1_FLAG_PLOT_REWARD_VALUE);
                    fValue = (nValue / 100.0);
                    nReward = FloatToInt(nReward * fValue);
                    SetLocalInt(oDungeon, "n" + sPlot + "Reward", nReward);
                    DebugMessage("  Reward set to " + IntToString(nReward));
                } else if ((nPlotGameplayType == 2) || (nPlotGameplayType == 5)) // clear or explore areas
                {
                    if (nPlotGameplayType == 2)
                    {
                        DebugMessage("  No special considerations for clearing areas.");
                    } else if (nPlotGameplayType == 5)
                    {
                        DebugMessage("  No special considerations for exploring areas.");
                    }

                    // determine reward
                    if (nPartyLevel < 1)
                    {
                        nReward = 100 * nLevelNum;
                    } else
                    {
                        nReward = nPartyLevel * 100 * nLevelNum;
                    }
                    nValue = GetModuleFlagValue(ID1_FLAG_PLOT_REWARD_VALUE);
                    fValue = (nValue / 100.0);
                    nReward = FloatToInt(nReward * fValue);
                    SetLocalInt(oDungeon, "n" + sPlot + "Reward", nReward);
                    DebugMessage("  Reward set to " + IntToString(nReward));
                } else if ((nPlotGameplayType == 3) || (nPlotGameplayType == 4)) // items on creatures or placeables
                {
                    // determine number of items
                    nItemNum = GetTargetNum(nPartySize, nPartyLevel);
                    SetLocalInt(oDungeon, "n" + sPlot + "ItemNum", nItemNum);

                    DebugMessage("  Target number of items is " + IntToString(nItemNum));

                    // determine plot item template
                    nPlotItemNum = GetLocalInt(GetModule(), "nPlotItem");
                    nItemType = Random(nPlotItemNum) + 1;
                    sTemp = GetLocalString(GetModule(), "sPlotItem" + IntToString(nItemType) + "ResRef");
                    nTemp = GetLocalInt(oDungeon, "nListItem_" + sTemp);
                    if (nTemp == 0) // if not in the list yet
                    {
                        nTemp = GetLocalInt(oDungeon, "nListItemNum");
                        nTemp++;
                        SetLocalInt(oDungeon, "nListItemNum", nTemp);
                        SetLocalString(oDungeon, "sListItem" + IntToString(nTemp) + "ResRef", sTemp);
                        SetLocalInt(oDungeon, "nListItem_" + sTemp, nTemp);
                        sTemp = GetLocalString(GetModule(), "sPlotItem" + IntToString(nItemType) + "Name");
                        SetLocalString(oDungeon, "sListItem" + IntToString(nTemp) + "Name", sTemp);
                    }
                    SetLocalInt(oDungeon, "n" + sPlot + "Item", nTemp);
                    DebugMessage("  Item type is " + IntToString(nTemp) + " which is actual item " + sTemp);

                    // determine reward
                    if (nPartyLevel < 1)
                    {
                        nReward = 100;
                    } else
                    {
                        nReward = nPartyLevel * 100;
                    }
                    nReward /= nItemNum;
                    if (nReward < 1)
                    {
                        nReward = 1;
                    }
                    nValue = GetModuleFlagValue(ID1_FLAG_PLOT_REWARD_VALUE);
                    fValue = (nValue / 100.0);
                    nReward = FloatToInt(nReward * fValue);
                    SetLocalInt(oDungeon, "n" + sPlot + "Reward", nReward);
                    DebugMessage("  Reward set to " + IntToString(nReward));
                } else if (nPlotGameplayType == 6) // find creature
                {
                    // generate target creature
                    object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU102");
                    SetLocalString(oMicroCPU, "sCreature", sPlot + "Creature");
                    SetLocalInt(oMicroCPU, "nCR", nPartyLevel);
                    SetLocalInt(oMicroCPU, "bIntelligentOnly", TRUE);
                    SetLocalInt(oMicroCPU, "bUnIntelligentOnly", FALSE);
                    SetLocalInt(oMicroCPU, "bMediumSizeOnly", FALSE);
                    SetLocalInt(oMicroCPU, "bBoss", FALSE);
                    SetLocalInt(oMicroCPU, "nTileset", -1);
                    SetLocalInt(oMicroCPU, "nTheme", 1);
                    SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                    SetLocalInt(oMicroCPU, "bHold", TRUE);
                    SetLocalInt(oMicroCPU, "bNoTreasure", TRUE);

                    int nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                    nMicroNum++;
                    SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

                    DelayCommand(0.01, ExecuteScript("exe_id1_micmon", oMicroCPU));

                    sName = RandomName();
                    SetLocalString(oDungeon, "s" + sPlot + "CreatureName", sName);

                    // determine reward
                    if (nPartyLevel < 1)
                    {
                        nReward = 250;
                    } else
                    {
                        nReward = nPartyLevel * 250;
                    }
                    nValue = GetModuleFlagValue(ID1_FLAG_PLOT_REWARD_VALUE);
                    fValue = (nValue / 100.0);
                    nReward = FloatToInt(nReward * fValue);
                    SetLocalInt(oDungeon, "n" + sPlot + "Reward", nReward);
                    DebugMessage("  Reward set to " + IntToString(nReward));
                } else if (nPlotGameplayType == 7) // find placeable
                {
                    // nArea is area number
                    string sTileset = GetLocalString(oDungeon, "sArea" + IntToString(nArea) + "Tileset");
                    int nTileset = GetLocalInt(GetModule(), "nTileset_" + sTileset);
                    DebugMessage("  Tileset for plot placeable is " + sTileset + " which is number " + IntToString(nTileset));

                    // determine placeable template
                    nPlaceableNum = GetLocalInt(GetModule(), "nPlotContainer");
                    nPlaceableType = Random(nPlaceableNum) + 1;
                    string sPlaceableResRef = GetLocalString(GetModule(), "sPlotContainer" + IntToString(nPlaceableType) + "ResRef");
                    DebugMessage(" Selected placeable " + IntToString(nPlaceableType) + " out of " + IntToString(nPlaceableNum) + " which is resref " + sPlaceableResRef);
                    int nDungeonType = GetLocalInt(oDungeon, "nListPlotContainer_" + sPlaceableResRef);
                    if (nDungeonType == 0)
                    {
                        nDungeonType = GetLocalInt(oDungeon, "nListPlotContainerNum");
                        nDungeonType++;
                        SetLocalInt(oDungeon, "nListPlotContainerNum", nDungeonType);
                        SetLocalString(oDungeon, "sListPlotContainer" + IntToString(nDungeonType) + "ResRef", sPlaceableResRef);
                        SetLocalInt(oDungeon, "nListPlotContainer_" + sPlaceableResRef, nDungeonType);
                        sPlaceableResRef = GetLocalString(GetModule(), "sPlotContainer" + IntToString(nPlaceableType) + "Name");
                        SetLocalString(oDungeon, "sListPlotContainer" + IntToString(nDungeonType) + "Name", sPlaceableResRef);
                    }
                    SetLocalInt(oDungeon, "n" + sPlot + "Placeable", nDungeonType);
                    DebugMessage("  Placeable type is " + IntToString(nDungeonType) + " which is type " + sPlaceableResRef);


                    // determine reward
                    if (nPartyLevel < 1)
                    {
                        nReward = 250;
                    } else
                    {
                        nReward = nPartyLevel * 250;
                    }
                    nValue = GetModuleFlagValue(ID1_FLAG_PLOT_REWARD_VALUE);
                    fValue = (nValue / 100.0);
                    nReward = FloatToInt(nReward * fValue);
                    SetLocalInt(oDungeon, "n" + sPlot + "Reward", nReward);
                    DebugMessage("  Reward set to " + IntToString(nReward));
                }

                // set waypoint as used
                SetLocalInt(oDungeon, "b" + sLevel + "Used", TRUE);

                // increment plot number
                nPlotNum = GetLocalInt(oDungeon, "n" + sLevel + "PlotNum");
                nPlotNum++;
                SetLocalInt(oDungeon, "n" + sLevel + "PlotNum", nPlotNum);

                // set plot number
                SetLocalInt(oDungeon, "n" + sLevel + "Plot" + IntToString(nPlotNum), nPlot);
                DebugMessage("  Set n" + sLevel + "Plot" + IntToString(nPlotNum) + " to " + IntToString(nPlot));

                // set inverse plot number
                SetLocalInt(oDungeon, "n" + sLevel + "Plot_" + IntToString(nPlot), nPlotNum);
                DebugMessage("  Set n" + sLevel + "Plot_" + IntToString(nPlot) + " to " + IntToString(nPlotNum));

                // set plot giver to spawn
                SetLocalInt(oDungeon, "n" + sLevel + "Plot" + IntToString(nPlotNum) + "SpawnType", 1);
                DebugMessage("  Set n" + sLevel + "Plot" + IntToString(nPlotNum) + "SpawnType to 1");
            }
        }

        // cycle to next waypoint
        nPlotWaypoint++;

        // if all waypoints have not been checked
        if (nPlotWaypoint <= nPlotWaypointNum)
        {
            DebugMessage("  Advancing to next plot waypoint.");

            // advance to next waypoint
            SetLocalInt(oTempHolder, "nCurrentX", nPlotWaypoint);

            // run plot generation
            DebugMessage("  Entering plot holding pattern.");
            DelayCommand(0.01, ExecuteScript("exe_id1_plothold", GetNextCPU()));
        } else // all waypoints have been checked
        {
            DebugMessage("  All plot waypoints have been generated.");

            // set the current plot to examine
            SetLocalInt(oTempHolder, "nCurrentX", 1);

            // set the current plot step to examine
            SetLocalInt(oTempHolder, "nCurrentY", 1);

            // set step in the process
            SetLocalInt(oTempHolder, "nTempProcess", 3);

            // check for plots to activate
            DebugMessage("  Entering plot holding pattern.");
            DelayCommand(0.01, ExecuteScript("exe_id1_plothold", GetNextCPU()));
        }
    } else if (nTempProcess == 3) // this level details of plots
    {
        object oDungeon = GetCurrentDungeon();
        int nDungeonDepth = GetLocalInt(oDungeon, "nDungeonDepth");
        int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
        object oPC = GetFirstPC();

        int nLevelNum;
        int nCreatureNum;
        int nLevelCreatureNum;
        int nCreatureType;
        int nCreatureSubType;
        int nEncounterWaypointNum;
        int nPlotAreaScope;
        int nNeededNum;
        int nWaypointCreatureNum;
        int nNeeded;
        int nEncounterWaypoint;
        int nStartWaypoint;
        int nArea;
        int nWaypoint;
        int bUsed;
        int nCurrentCreature;
        int nAreaNum;
        int nNewArea;
        int bFail;
        int nCount;
        int nOldArea;
        int nWaypointPlot;
        int nX;
        int nY;
        int nSubTypeNum;
        int nSubType;
        int nSize;
        int nStartArea;
        int nStartLevel;
        int nItemNum;
        int nLevelItemNum;
        int nCurrentItem;
        int nItemType;
        int nPlotWaypointNum;
        int nPlotWaypoint;
        int nWaypointPlotNum;
        int nPlaceableType;
        int nTreasureWaypointNum;
        int nPlaceableNum;

        string sLevel;
        string sPlotWaypoint;
        string sCreature;
        string sName;
        string sLevelPlot;
        string sPlaceable;
        string sItem;
        string sResRef;

        // get the number of plots
        int nPlotNum = GetLocalInt(oDungeon, "nPlotNum");

        // get the current plot
        int nPlot = GetLocalInt(oTempHolder, "nCurrentX");

        if (nPlot <= nPlotNum)
        {
            DebugMessage("  On plot " + IntToString(nPlot));

            // if plot is active on this level, go detailed
            int bPlotActive = GetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Level" + IntToString(nCurrentLevel) + "Used");
            DebugMessage("  bPlot" + IntToString(nPlot) + "Level" + IntToString(nCurrentLevel) + "Used is " + IntToString(bPlotActive));
            if (bPlotActive == TRUE)
            {
                string sPlot = "Plot" + IntToString(nPlot);
                DebugMessage("  " + sPlot + " is active.");

                int nLevel = GetLocalInt(oDungeon, "n" + sPlot + "Level_" + IntToString(nCurrentLevel));
                string sPlotLevel = sPlot + "Level" + IntToString(nLevel);
                DebugMessage("    PlotLevel " + sPlotLevel);

                // get the plot type
                int nPlotGameplayType = GetLocalInt(oDungeon, "n" + sPlot + "GameplayType");
                DebugMessage("    Gameplay type of this step is " + IntToString(nPlotGameplayType));

                if (nPlotGameplayType == 1) // kill creatures
                {
                    DebugMessage("      Gameplay is 1. Kill creatures.");

                    // get number of levels in the step
                    nLevelNum = GetLocalInt(oDungeon, "n" + sPlot + "LevelNum");

                    DebugMessage("      Levels in this step: " + IntToString(nLevelNum));

                    // get the number of plot creatures on this level
                    nCreatureNum = GetLocalInt(oDungeon, "n" + sPlot + "CreatureNum");
                    DebugMessage("      Creatures in this step: " + IntToString(nCreatureNum));
                    nLevelCreatureNum = nCreatureNum / nLevelNum;

                    // if it doesnt divide evenly
                    if ((nLevelCreatureNum * nLevelNum) < nCreatureNum)
                    {
                        // round up
                        nLevelCreatureNum++;
                    }

                    DebugMessage("      Creatures per level: " + IntToString(nLevelCreatureNum));

                    // get creature details
                    nCreatureType = GetLocalInt(oDungeon, "n" + sPlot + "Creature");
                    sResRef = GetLocalString(oDungeon, "sListCreature" + IntToString(nCreatureType) + "ResRef");
                    DebugMessage("      Creatures are type " + IntToString(nCreatureType) + " with resref " + sResRef + " from n" + sPlot + "Creature");

                    // determine how many encounter waypoints are on this level
                    nEncounterWaypointNum = GetLocalInt(oTempHolder, "nTempEncounterWaypointNum");

                    DebugMessage("      Encounter waypoints: " + IntToString(nEncounterWaypointNum));

                    // check to see if more creatures of this type are needed on this level
                    nCreatureNum = GetLocalInt(oTempHolder, "nTempCreatureType" + IntToString(nCreatureType));
                    DebugMessage("      Level has " + IntToString(nCreatureNum) + " creatures of type " + IntToString(nCreatureType) + " with plot needing " + IntToString(nLevelCreatureNum));
                    if (nLevelCreatureNum > nCreatureNum)
                    {
                        // add an extra creature for this plot as well
                        nLevelCreatureNum++;

                        // set new total number of creatures on this level
                        SetLocalInt(oTempHolder, "nTempCreatureType" + IntToString(nCreatureType), nLevelCreatureNum);

                        // determine how many are needed
                        nLevelCreatureNum -= nCreatureNum;
                    } else // there are already enough creatures on this level
                    {
                        // add one more creature, just in case
                        nLevelCreatureNum = nCreatureNum + 1;

                        // set new total number of creatures on this level
                        SetLocalInt(oTempHolder, "nTempCreatureType" + IntToString(nCreatureType), nLevelCreatureNum);

                        DebugMessage("        Adding an extra creature, bringin total to " + IntToString(nLevelCreatureNum));

                        nLevelCreatureNum = 1;
                    }

                    // if there are waypoints
                    if (nEncounterWaypointNum > 0)
                    {
                        // add new creatures
                        nCurrentCreature = 1;
                        while (nCurrentCreature <= nLevelCreatureNum)
                        {
                            DebugMessage("        On creature " + IntToString(nCurrentCreature) + " of " + IntToString(nLevelCreatureNum));

                            // select a random waypoint
                            nEncounterWaypoint = Random(nEncounterWaypointNum) + 1;

                            // add creature at this waypoint
                            nArea = GetLocalInt(oTempHolder, "nTempEncounterWaypoint" + IntToString(nEncounterWaypoint) + "Area");
                            nWaypoint = GetLocalInt(oTempHolder, "nTempEncounterWaypoint" + IntToString(nEncounterWaypoint) + "Waypoint");
                            sLevel = "Area" + IntToString(nArea) + "WaypointEncounter" + IntToString(nWaypoint) + "Level" + IntToString(nCurrentLevel);
                            nSize = GetLocalInt(oDungeon, "n" + sLevel + "Size");
                            nSize++;
                            SetLocalInt(oDungeon, "n" + sLevel + "Size", nSize);
                            sCreature = sLevel + "Creature" + IntToString(nSize);
                            DebugMessage("        Adding creature " + sCreature + " with type " + IntToString(nCreatureType) + " and subtype " + IntToString(nSubType));
                            SetLocalInt(oDungeon, "n" + sCreature, nCreatureType);

                            // add next creature
                            nCurrentCreature++;
                        }
                    } else // there are no waypoints on this level
                    {
                        DebugMessage("      No waypoints. Adding to emergency list.");

                        // dump everything at the first stairs up
                        sLevel = "EmergencyLevel" + IntToString(nCurrentLevel);
                        nCreatureNum = GetLocalInt(oDungeon, "n" + sLevel + "CreatureNum");
                        DebugMessage("There are " + IntToString(nCreatureNum) + " creatures already at the emergency point.");

                        // add each creature
                        nCurrentCreature = 1;
                        while (nCurrentCreature <= nLevelCreatureNum)
                        {
                            sCreature = sLevel + "Creature" + IntToString(nCurrentCreature + nCreatureNum);
                            DebugMessage("Adding creature " + sCreature);
                            SetLocalInt(oDungeon, "n" + sCreature, nCreatureType);

                            // add next creature
                            nCurrentCreature++;
                        }

                        // set the new number of creatures
                        nCreatureNum += nLevelCreatureNum;
                        SetLocalInt(oDungeon, "n" + sLevel + "CreatureNum", nCreatureNum);
                    }
                } else if (nPlotGameplayType == 3) // items dropped by creatures
                {
                    DebugMessage("      Gameplay is 3. Get items on creatures.");

                    // get number of levels in the step
                    nLevelNum = GetLocalInt(oDungeon, "n" + sPlot + "LevelNum");

                    DebugMessage("      Levels in this step: " + IntToString(nLevelNum));

                    // get the number of plot creatures on this level
                    nItemNum = GetLocalInt(oDungeon, "n" + sPlot + "ItemNum");
                    DebugMessage("      Items in this step: " + IntToString(nItemNum));
                    nLevelItemNum = nItemNum / nLevelNum;

                    // if it doesnt divide evenly
                    if ((nLevelItemNum * nLevelNum) < nItemNum)
                    {
                        // round up
                        nLevelItemNum++;
                    }

                    DebugMessage("      Items per level: " + IntToString(nLevelItemNum));

                    // get creature details
                    nItemType = GetLocalInt(oDungeon, "n" + sPlot + "Item");
                    DebugMessage("      Items are type " + IntToString(nItemType));

                    // determine how many encounter waypoints are on this level
                    nEncounterWaypointNum = GetLocalInt(oTempHolder, "nTempEncounterWaypointNum");

                    DebugMessage("      Encounter waypoints: " + IntToString(nEncounterWaypointNum));

                    // check to see if more items of this type are needed on this level
                    nItemNum = GetLocalInt(oTempHolder, "nTempCreatureItemType" + IntToString(nCreatureType));
                    DebugMessage("      Level has " + IntToString(nItemNum) + " items of type " + IntToString(nItemType) + " with plot needing " + IntToString(nLevelItemNum));
                    if (nLevelItemNum > nItemNum)
                    {
                        // add an extra item for this plot as well
                        nLevelItemNum++;

                        // set new total number of items on this level
                        SetLocalInt(oTempHolder, "nTempCreatureItemType" + IntToString(nItemType), nLevelItemNum);

                        // determine how many are needed
                        nLevelItemNum -= nItemNum;
                    } else  // there are already enough items on this level
                    {
                        // add one more item, just in case
                        nLevelItemNum = nItemNum + 1;

                        // set new total number of items on this level
                        SetLocalInt(oTempHolder, "nTempCreatureItemType" + IntToString(nItemType), nLevelItemNum);

                        DebugMessage("        Adding an extra item, bringing total to " + IntToString(nLevelItemNum));

                        nLevelItemNum = 1;
                    }


                    // if there are waypoints
                    if (nEncounterWaypointNum > 0)
                    {
                        // add new items
                        nCurrentItem = 1;
                        while (nCurrentItem <= nLevelItemNum)
                        {
                            DebugMessage("        On item " + IntToString(nCurrentItem) + " of " + IntToString(nLevelItemNum));

                            // select a random waypoint
                            nEncounterWaypoint = Random(nEncounterWaypointNum) + 1;

                            // add creature at this waypoint
                            nArea = GetLocalInt(oTempHolder, "nTempEncounterWaypoint" + IntToString(nEncounterWaypoint) + "Area");
                            nWaypoint = GetLocalInt(oTempHolder, "nTempEncounterWaypoint" + IntToString(nEncounterWaypoint) + "Waypoint");
                            sLevel = "Area" + IntToString(nArea) + "WaypointEncounter" + IntToString(nWaypoint) + "Level" + IntToString(nCurrentLevel);

                            // add an item of this plot to the encounter waypoint
                            nWaypointPlotNum = GetLocalInt(oDungeon, "n" + sLevel + "PlotNum");
                            nWaypointPlotNum++;
                            SetLocalInt(oDungeon, "n" + sLevel + "PlotNum", nWaypointPlotNum);
                            SetLocalInt(oDungeon, "n" + sLevel + "Plot" + IntToString(nWaypointPlotNum), nPlot);
                            DebugMessage("        Added plot " + IntToString(nPlot) + " to n" + sLevel + "Plot" + IntToString(nWaypointPlotNum));

                            // add next item
                            nCurrentItem++;
                        }
                    } else // there are no waypoints on this level
                    {
                        DebugMessage("      No waypoints. Adding to emergency list.");

                        // dump everything at the first stairs up
                        sLevel = "EmergencyLevel" + IntToString(nCurrentLevel);
                        nItemNum = GetLocalInt(oDungeon, "n" + sLevel + "ItemNum");
                        DebugMessage("There are " + IntToString(nItemNum) + " items already at the emergency point.");

                        // add each item
                        nCurrentItem = 1;
                        while (nCurrentItem <= nLevelItemNum)
                        {
                            sItem = sLevel + "Item" + IntToString(nCurrentItem);
                            DebugMessage("Adding item " + sItem);
                            SetLocalInt(oDungeon, "n" + sItem, nItemType);

                            // add next item
                            nCurrentItem++;
                        }

                        // set the new number of items
                        nItemNum += nLevelItemNum;
                        SetLocalInt(oDungeon, "n" + sLevel + "ItemNum", nItemNum);
                    }
                } else if (nPlotGameplayType == 4) // items on placeables
                {
                    DebugMessage("      Gameplay is 4. Get items on placeables");


                    // get number of levels in the step
                    nLevelNum = GetLocalInt(oDungeon, "n" + sPlot + "LevelNum");

                    DebugMessage("      Levels in this step: " + IntToString(nLevelNum));

                    // get the number of plot creatures on this level
                    nItemNum = GetLocalInt(oDungeon, "n" + sPlot + "ItemNum");
                    DebugMessage("      Items in this step: " + IntToString(nItemNum));
                    nLevelItemNum = nItemNum / nLevelNum;

                    // if it doesnt divide evenly
                    if ((nLevelItemNum * nLevelNum) < nItemNum)
                    {
                        // round up
                        nLevelItemNum++;
                    }

                    DebugMessage("      Items per level: " + IntToString(nLevelItemNum));

                    // get creature details
                    nItemType = GetLocalInt(oDungeon, "n" + sPlot + "Item");
                    DebugMessage("      Items are type " + IntToString(nItemType));
                    DebugMessage("        Item resref is " + GetLocalString(oDungeon, "sListItem" + IntToString(nItemType) + "ResRef"));

                    // determine how many encounter waypoints are on this level
                    nTreasureWaypointNum = GetLocalInt(oTempHolder, "nTempTreasureWaypointNum");

                    DebugMessage("      Treasure waypoints: " + IntToString(nTreasureWaypointNum));

                    // check to see if more items of this type are needed on this level
                    nItemNum = GetLocalInt(oTempHolder, "nTempPlaceableItemType" + IntToString(nCreatureType));
                    DebugMessage("      Level has " + IntToString(nItemNum) + " items of type " + IntToString(nItemType) + " with plot needing " + IntToString(nLevelItemNum));
                    if (nLevelItemNum > nItemNum)
                    {
                        // add an extra item for this plot as well
                        nLevelItemNum++;

                        // set new total number of items on this level
                        SetLocalInt(oTempHolder, "nTempPlaceableItemType" + IntToString(nItemType), nLevelItemNum);

                        // determine how many are needed
                        nLevelItemNum -= nItemNum;
                    } else  // there are already enough items on this level
                    {
                        // add one more item, just in case
                        nLevelItemNum = nItemNum + 1;

                        // set new total number of items on this level
                        SetLocalInt(oTempHolder, "nTempPlaceableItemType" + IntToString(nItemType), nLevelItemNum);

                        DebugMessage("        Adding an extra item, bringing total to " + IntToString(nLevelItemNum));

                        nLevelItemNum = 1;
                    }


                    // if there are waypoints
                    if (nTreasureWaypointNum > 0)
                    {
                        // add new items
                        nCurrentItem = 1;
                        while (nCurrentItem <= nLevelItemNum)
                        {
                            DebugMessage("        On item " + IntToString(nCurrentItem) + " of " + IntToString(nLevelItemNum));

                            // select a random waypoint
                            nEncounterWaypoint = Random(nTreasureWaypointNum) + 1;

                            // add item at this waypoint
                            nArea = GetLocalInt(oTempHolder, "nTempTreasureWaypoint" + IntToString(nEncounterWaypoint) + "Area");
                            nWaypoint = GetLocalInt(oTempHolder, "nTempTreasureWaypoint" + IntToString(nEncounterWaypoint) + "Waypoint");
                            sLevel = "Area" + IntToString(nArea) + "WaypointTreasure" + IntToString(nWaypoint) + "Level" + IntToString(nCurrentLevel);

                            // add an item of this plot to the treasure waypoint
                            nWaypointPlotNum = GetLocalInt(oDungeon, "n" + sLevel + "ItemNum");
                            nWaypointPlotNum++;
                            SetLocalInt(oDungeon, "n" + sLevel + "ItemNum", nWaypointPlotNum);
                            SetLocalInt(oDungeon, "n" + sLevel + "Item" + IntToString(nWaypointPlotNum) + "ItemType", 2);
                            SetLocalInt(oDungeon, "n" + sLevel + "Item" + IntToString(nWaypointPlotNum) + "Size", 1);
                            SetLocalInt(oDungeon, "n" + sLevel + "Item" + IntToString(nWaypointPlotNum) + "Item", nItemType);
                            DebugMessage("        Added plot " + IntToString(nPlot) + " to n" + sLevel + "Plot" + IntToString(nWaypointPlotNum));

                            // add next item
                            nCurrentItem++;
                        }
                    } else // there are no waypoints on this level
                    {
                        DebugMessage("      No waypoints. Adding to emergency list.");

                        // dump everything at the first stairs up
                        sLevel = "EmergencyLevel" + IntToString(nCurrentLevel);
                        nItemNum = GetLocalInt(oDungeon, "n" + sLevel + "ItemNum");
                        DebugMessage("There are " + IntToString(nItemNum) + " items already at the emergency point.");

                        // add each item
                        nCurrentItem = 1;
                        while (nCurrentItem <= nLevelItemNum)
                        {
                            sItem = sLevel + "Item" + IntToString(nCurrentItem);
                            DebugMessage("Adding item " + sItem);
                            SetLocalInt(oDungeon, "n" + sItem, nItemType);

                            // add next item
                            nCurrentItem++;
                        }

                        // set the new number of items
                        nItemNum += nLevelItemNum;
                        SetLocalInt(oDungeon, "n" + sLevel + "ItemNum", nItemNum);
                    }
                } else if ((nPlotGameplayType == 2) || (nPlotGameplayType == 5)) // clear or explore
                {
                    if (nPlotGameplayType == 2)
                    {
                        DebugMessage("      Gameplay is 2. Clear areas of creatures.");
                    } else if (nPlotGameplayType == 5)
                    {
                        DebugMessage("      Gameplay is 5. Explore areas.");
                    }

                    // get starting area if on starting level
                    nStartLevel = GetLocalInt(oDungeon, "n" + sPlot + "StartLevel");
                    DebugMessage("        Starting level is " + IntToString(nStartLevel) + " and current level is " + IntToString(nCurrentLevel));
                    if (nStartLevel == nCurrentLevel)
                    {
                        nStartArea = GetLocalInt(oDungeon, "n" + sPlot + "StartArea");
                        DebugMessage("        Starting area is " + IntToString(nStartArea));
                    }

                    // determine scope of plot
                    nPlotAreaScope = GetLocalInt(oDungeon, "n" + sPlot + "AreaScope");
                    DebugMessage("        Area scope is " + IntToString(nPlotAreaScope));

                    // determine how many areas are needed
                    if (nPlotAreaScope > 1) // multiple areas
                    {
                        nNeededNum = GetPlotAreaNumber();
                    } else // single area
                    {
                        nNeededNum = 1;
                    }
//                    nNeededNum = 4;
                    DebugMessage("        First number of areas is " + IntToString(nNeededNum));

                    // if more areas needed than exist
                    nAreaNum = GetLocalInt(oTempHolder, "nTempAreaNum");
                    DebugMessage("        Number of areas on this level is " + IntToString(nAreaNum));
                    if (nNeededNum > nAreaNum - 1)
                    {
                        // reduce to maximum amount
                        nNeededNum = nAreaNum - 1;
                    }
                    DebugMessage("        Second number of areas is " + IntToString(nNeededNum));

                    // set number of areas needed
                    SetLocalInt(oDungeon, "n" + sPlotLevel + "AreaNum", nNeededNum);

                    // select areas
                    nNeeded = 1;
                    while (nNeeded <= nNeededNum)
                    {
                        DebugMessage("        Selecting area " + IntToString(nNeeded));

                        // pick a random area
                        nArea = Random(nAreaNum) + 1;
                        nNewArea = GetLocalInt(oTempHolder, "nTempArea" + IntToString(nArea) + "Area");
                        DebugMessage("          New Area nTempArea" + IntToString(nArea) + "Area in temp list is area num " + IntToString(nNewArea));
                        bFail = TRUE;
                        while (bFail == TRUE)
                        {
                            bUsed = FALSE;

                            // if this is the starting area
                            if ((nStartLevel == nCurrentLevel) && (nNewArea == nStartArea))
                            {
                                bUsed = TRUE;
                                DebugMessage("          This is the starting area on the starting level.");
                            }

/*                            // don't allow a boss area to be selected
                            nX = GetLocalInt(oDungeon, "nArea" + IntToString(nNewArea) + "Level" + IntToString(nCurrentLevel) + "X");
                            nY = GetLocalInt(oDungeon, "nArea" + IntToString(nNewArea) + "Level" + IntToString(nCurrentLevel) + "Y");
                            if (GetLocalInt(oDungeon, "bLevel" + IntToString(nCurrentLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY) + "Boss") == TRUE)
                            {
                                bUsed = TRUE;
                                DebugMessage("          This is a boss area.");
                            }*/

                            // see if this area is already used
                            nCount = 1;
                            while ((bUsed == FALSE) && (nCount < nNeeded))
                            {
                                // if this is the area being looked at
                                nOldArea = GetLocalInt(oDungeon, "n" + sPlotLevel + "Area" + IntToString(nCount));
                                DebugMessage("          Old Area n" + sPlotLevel + "Area" + IntToString(nCount) + " in plot list is area num " + IntToString(nOldArea));

                                if (nOldArea == nNewArea)
                                {
                                    bUsed = TRUE;
                                    DebugMessage("            Match.");
                                } else
                                {
                                    nCount++;
                                    DebugMessage("            Does not match.");
                                }
                            }

                            if (bUsed == TRUE)
                            {
                                nArea++;

                                if (nArea > nAreaNum)
                                {
                                    nArea = 1;
                                }

                                nNewArea = GetLocalInt(oTempHolder, "nTempArea" + IntToString(nArea) + "Area");
                                DebugMessage("          New Area nTempArea" + IntToString(nArea) + "Area in temp list is area num " + IntToString(nNewArea));
                            } else
                            {
                                bFail = FALSE;
                                DebugMessage("          Using this area.");
                            }
                        }

                        // set the area
                        SetLocalInt(oDungeon, "n" + sPlotLevel + "Area" + IntToString(nNeeded), nNewArea);
                        SetLocalInt(oDungeon, "n" + sPlotLevel + "Area_" + IntToString(nNewArea), nNeeded);
                        DebugMessage("        Setting n" + sPlotLevel + "Area" + IntToString(nNeeded) + " to " + IntToString(nNewArea));
                        nX = GetLocalInt(oDungeon, "nArea" + IntToString(nNewArea) + "Level" + IntToString(nCurrentLevel) + "X");
                        nY = GetLocalInt(oDungeon, "nArea" + IntToString(nNewArea) + "Level" + IntToString(nCurrentLevel) + "Y");
                        DebugMessage("        Area " + IntToString(nNewArea) + " located at " + IntToString(nX) + "," + IntToString(nY));

                        // go through list of people on this plot and update their explored states
                        object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU103");
                        SetLocalInt(oMicroCPU, "nPlot", nPlot);
                        SetLocalInt(oMicroCPU, "nLevel", nCurrentLevel);
                        DelayCommand(0.01, ExecuteScript("exe_id1_micplot6", oMicroCPU));

                        // cycle to next area
                        nNeeded++;
                    }
                } else if ((nPlotGameplayType == 6) || (nPlotGameplayType == 7)) // find creature or placeable
                {
                    if (nPlotGameplayType == 6)
                    {
                        DebugMessage("      Gameplay is 6. Find creature.");
                    } else if (nPlotGameplayType == 7)
                    {
                        DebugMessage("      Gameplay is 7. Find placeable.");
                    }

                    nPlotWaypointNum = GetLocalInt(oTempHolder, "nTempPlotWaypointNum");
                    DebugMessage("        There are " + IntToString(nPlotWaypointNum) + " plot waypoints.");

                    nStartLevel = GetLocalInt(oDungeon, "n" + sPlot + "StartLevel");
                    DebugMessage("        Starting level is " + IntToString(nStartLevel) + " vs current level " + IntToString(nCurrentLevel));

                    // if there are plot waypoints on this level
                    if ((nPlotWaypointNum > 1) || ((nPlotWaypointNum > 0) && (nStartLevel != nCurrentLevel)))
                    {
                        nPlotWaypoint = Random(nPlotWaypointNum) + 1;
                        nStartWaypoint = nPlotWaypoint;
                        DebugMessage("          Examining waypoint " + IntToString(nPlotWaypoint));

                        nArea = GetLocalInt(oTempHolder, "nTempPlotWaypoint" + IntToString(nPlotWaypoint) + "Area");
                        nWaypoint = GetLocalInt(oTempHolder, "nTempPlotWaypoint" + IntToString(nPlotWaypoint) + "Waypoint");
                        sLevel = "Area" + IntToString(nArea) + "WaypointPlot" + IntToString(nWaypoint) + "Level" + IntToString(nCurrentLevel);
                        DebugMessage("            sLevel is " + sLevel);

                        bUsed = GetLocalInt(oDungeon, "b" + sLevel + "Used");
                        DebugMessage("            bUsed is " + IntToString(bUsed));

                        //  increment if already used
                        if (bUsed == TRUE)
                        {
                            nPlotWaypoint++;

                            if (nPlotWaypoint > nPlotWaypointNum)
                            {
                                nPlotWaypoint = 1;
                            }
                        }

                        while ((bUsed == TRUE) && (nPlotWaypoint != nStartWaypoint))
                        {
                            DebugMessage("          Examining waypoint " + IntToString(nPlotWaypoint));

                            nArea = GetLocalInt(oTempHolder, "nTempPlotWaypoint" + IntToString(nPlotWaypoint) + "Area");
                            nWaypoint = GetLocalInt(oTempHolder, "nTempPlotWaypoint" + IntToString(nPlotWaypoint) + "Waypoint");
                            sLevel = "Area" + IntToString(nArea) + "WaypointPlot" + IntToString(nWaypoint) + "Level" + IntToString(nCurrentLevel);
                            DebugMessage("            sLevel is " + sLevel);

                            bUsed = GetLocalInt(oDungeon, "b" + sLevel + "Used");
                            DebugMessage("            bUsed is " + IntToString(bUsed));

                            //  increment if already used
                            if (bUsed == TRUE)
                            {
                                nPlotWaypoint++;

                                if (nPlotWaypoint > nPlotWaypointNum)
                                {
                                    nPlotWaypoint = 1;
                                }
                            }
                        }

                        DebugMessage("        Pre-final selection is " + IntToString(nPlotWaypoint));

                        // make sure selected point isn't starting point
                        nStartLevel = GetLocalInt(oDungeon, "n" + sPlot + "StartLevel");
                        DebugMessage("        Starting level is " + IntToString(nStartLevel) + " vs current level " + IntToString(nCurrentLevel));
                        if (nStartLevel == nCurrentLevel)
                        {
                            DebugMessage("          Starting level is the same.");
                            nStartArea = GetLocalInt(oDungeon, "n" + sPlot + "StartArea");
                            if (nStartArea == nArea)
                            {
                                DebugMessage("          Starting area is the same.");
                                nStartWaypoint = GetLocalInt(oDungeon, "n" + sPlot + "StartWaypoint");
                                if (nStartWaypoint == nWaypoint)
                                {
                                    DebugMessage("          Starting Waypoint is the same.");

                                    // increment waypoint
                                    if (bUsed == FALSE)
                                    {
                                        nPlotWaypoint++;
                                        if (nPlotWaypoint > nPlotWaypointNum)
                                        {
                                            nPlotWaypoint = 1;
                                        }
                                    }
                                    nArea = GetLocalInt(oTempHolder, "nTempPlotWaypoint" + IntToString(nPlotWaypoint) + "Area");
                                    nWaypoint = GetLocalInt(oTempHolder, "nTempPlotWaypoint" + IntToString(nPlotWaypoint) + "Waypoint");
                                    sLevel = "Area" + IntToString(nArea) + "WaypointPlot" + IntToString(nWaypoint) + "Level" + IntToString(nCurrentLevel);
                                    DebugMessage("            Emergency sLevel is " + sLevel);
                                }
                            }
                        }

                        // add new plot at this waypoint
                        SetLocalInt(oDungeon, "b" + sLevel + "Used", TRUE);
                        nWaypointPlotNum = GetLocalInt(oDungeon, "n" + sLevel + "PlotNum");
                        nWaypointPlotNum++;
                        SetLocalInt(oDungeon, "n" + sLevel + "PlotNum", nWaypointPlotNum);
                        SetLocalInt(oDungeon, "n" + sLevel + "Plot" + IntToString(nWaypointPlotNum), nPlot);
                        DebugMessage("        Added plot " + IntToString(nPlot) + " to n" + sLevel + "Plot" + IntToString(nWaypointPlotNum));

                        if (nPlotGameplayType == 6) // find creature
                        {
                            sLevelPlot = sLevel + "Plot" + IntToString(nWaypointPlotNum);
                            SetLocalInt(oDungeon, "n" + sLevelPlot + "SpawnType", 2);
                            DebugMessage("        Set n" + sLevelPlot + "SpawnType to 2");

                            sCreature = sLevelPlot + "Object";
                            nCreatureType = GetLocalInt(oDungeon, "n" + sPlot + "Creature");
                            SetLocalInt(oDungeon, "n" + sCreature, nCreatureType);
                            sName = GetLocalString(oDungeon, "s" + sPlot + "CreatureName");
                            SetLocalString(oDungeon, "s" + sCreature + "Name", sName);
                            DebugMessage("        Adding plot destination " + sCreature + " with type " + IntToString(nCreatureType));
                        } else if (nPlotGameplayType == 7) // find placeable
                        {
                            sLevelPlot = sLevel + "Plot" + IntToString(nWaypointPlotNum);
                            SetLocalInt(oDungeon, "n" + sLevelPlot + "SpawnType", 3);
                            DebugMessage("        Set n" + sLevelPlot + "SpawnType to 3");

                            sPlaceable = sLevelPlot + "Object";
                            nPlaceableType = GetLocalInt(oDungeon, "n" + sPlot + "Placeable");
                            SetLocalInt(oDungeon, "n" + sPlaceable, nPlaceableType);
                            DebugMessage("        Added plot placeable " + sPlaceable + " with type " + IntToString(nPlaceableType));
                        }
                    } else // there are no plot waypoints on this level or not enough
                    {
                        // dump everything at the first stairs up
                        if (nPlotGameplayType == 6) // find creature
                        {
                            // get number of emergency creatures
                            sLevel = "EmergencyLevel" + IntToString(nCurrentLevel);
                            nCreatureNum = GetLocalInt(oDungeon, "n" + sLevel + "CreatureNum");
                            DebugMessage("There are " + IntToString(nCreatureNum) + " creatures already at the emergency point.");

                            // get creature details
                            nCreatureType = GetLocalInt(oDungeon, "n" + sPlot + "Creature");
                            sName = GetLocalString(oDungeon, "s" + sPlot + "CreatureName");
                            DebugMessage("        Adding plot destination " + sCreature + " with type " + IntToString(nCreatureType));

                            // adding creature
                            nCreatureNum++;
                            sCreature = sLevel + "Creature" + IntToString(nCreatureNum);
                            DebugMessage("Adding creature " + sCreature);
                            SetLocalInt(oDungeon, "n" + sCreature, nCreatureType);
                            SetLocalString(oDungeon, "s" + sCreature + "Name", sName);
                            SetLocalInt(oDungeon, "n" + sCreature + "SpawnType", 2);
                        } else if (nPlotGameplayType == 7) // find placeable
                        {
                            // get number of emergency placeables
                            sLevel = "EmergencyLevel" + IntToString(nCurrentLevel);
                            nPlaceableNum = GetLocalInt(oDungeon, "n" + sLevel + "Placeable");
                            DebugMessage("There are " + IntToString(nPlaceableNum) + " placeables already at the emergency point.");

                            // get placeable details
                            nPlaceableType = GetLocalInt(oDungeon, "n" + sPlot + "Placeable");
                            DebugMessage("        Adding plot placeable with type " + IntToString(nPlaceableType));

                            // adding creature
                            nPlaceableNum++;
                            sPlaceable = sLevel + "Placeable" + IntToString(nPlaceableNum);
                            DebugMessage("Adding placeable " + sPlaceable);
                            SetLocalInt(oDungeon, "n" + sPlaceable, nPlaceableType);
                        }
                    }
                }

                // cycle to next plot
                nPlot++;

                // set new plot to examine
                SetLocalInt(oTempHolder, "nCurrentX", nPlot);

                // start at the first plot step
                SetLocalInt(oTempHolder, "nCurrentY", 1);

                // generate details of next plot
                DelayCommand(0.01, ExecuteScript("exe_id1_plothold", GetNextCPU()));
            } else // plot is not active
            {
                DebugMessage("  Plot is not active.");

                // cycle to next plot
                nPlot++;

                // set new plot to examine
                SetLocalInt(oTempHolder, "nCurrentX", nPlot);

                // generate details of next plot
                DelayCommand(0.01, ExecuteScript("exe_id1_plothold", GetNextCPU()));
            }
        } else // all plots have been examined
        {
            DebugMessage("  Plot is not within range.");

            // set step in the process
            SetLocalInt(oTempHolder, "nTempProcess", 4);

            // check for boss plots to activate
            DelayCommand(0.01, ExecuteScript("exe_id1_plothold", GetNextCPU()));
        }
    } else if (nTempProcess == 4) // boss dungeon plot
    {
        DebugMessage("  Checking for boss plot.");

        object oDungeon = GetCurrentDungeon();
        int nDungeonDepth = GetLocalInt(oDungeon, "nDungeonDepth");
        int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
        object oPC = GetFirstPC();

        int nBossQuestBoss = GetLocalInt(oDungeon, "nBossQuestBoss");
        int nBossQuestLevel = GetLocalInt(oDungeon, "nBossQuestLevel");
        int nBossPlotDepth = GetLocalInt(oDungeon, "nBossPlotDepth");

        DebugMessage("  Boss is category " + IntToString(nBossQuestLevel) + " and number " + IntToString(nBossQuestBoss));
        if (nBossQuestLevel > 0)
        {
            DebugMessage("    Boss quest is present.");

            DebugMessage("    Boss item is at depth " + IntToString(nBossPlotDepth) + " and current level is " + IntToString(nCurrentLevel));
            if (nBossPlotDepth == nCurrentLevel)
            {
                DebugMessage("      Boss item must be spawned in on this level.");

                // if there are encounter waypoints
                int nEncounterWaypointNum = GetLocalInt(oTempHolder, "nTempEncounterWaypointNum");
                DebugMessage("      Encounter waypoints: " + IntToString(nEncounterWaypointNum));
                if (nEncounterWaypointNum > 0)
                {
                    // select a random waypoint
                    int nEncounterWaypoint = Random(nEncounterWaypointNum) + 1;
                    DebugMessage("      Adding plot item to creature waypoint " + IntToString(nEncounterWaypoint));

                    // get waypoint details
                    int nArea = GetLocalInt(oTempHolder, "nTempEncounterWaypoint" + IntToString(nEncounterWaypoint) + "Area");
                    int nWaypoint = GetLocalInt(oTempHolder, "nTempEncounterWaypoint" + IntToString(nEncounterWaypoint) + "Waypoint");
                    string sLevel = "Area" + IntToString(nArea) + "WaypointEncounter" + IntToString(nWaypoint) + "Level" + IntToString(nCurrentLevel);

                    // add an item of this plot to the encounter waypoint
                    int nWaypointPlotNum = GetLocalInt(oDungeon, "n" + sLevel + "PlotNum");
                    nWaypointPlotNum++;
                    SetLocalInt(oDungeon, "n" + sLevel + "PlotNum", nWaypointPlotNum);
                    SetLocalInt(oDungeon, "n" + sLevel + "Plot" + IntToString(nWaypointPlotNum), -1);
                    DebugMessage("        Added plot -1 to n" + sLevel + "Plot" + IntToString(nWaypointPlotNum));

                    // record which area the item will be dropped in
                    SetLocalInt(oDungeon, "nBossPlotArea", nArea);
                } else // there are no creature waypoints on this level
                {
                    // if there are treasure waypoints
                    int nTreasureWaypointNum = GetLocalInt(oTempHolder, "nTempTreasureWaypointNum");
                    DebugMessage("      Treasure waypoints: " + IntToString(nTreasureWaypointNum));
                    if (nTreasureWaypointNum > 0)
                    {
                        // select a random waypoint
                        int nTreasureWaypoint = Random(nTreasureWaypointNum) + 1;
                        DebugMessage("      Adding plot item to treasure waypoint " + IntToString(nTreasureWaypoint));

                        // get waypoint details
                        int nArea = GetLocalInt(oTempHolder, "nTempTreasureWaypoint" + IntToString(nTreasureWaypoint) + "Area");
                        int nWaypoint = GetLocalInt(oTempHolder, "nTempTreasureWaypoint" + IntToString(nTreasureWaypoint) + "Waypoint");
                        string sLevel = "Area" + IntToString(nArea) + "WaypointTreasure" + IntToString(nWaypoint) + "Level" + IntToString(nCurrentLevel);

                        // add an item of this plot to the treasure waypoint
                        int nWaypointPlotNum = GetLocalInt(oDungeon, "n" + sLevel + "ItemNum");
                        nWaypointPlotNum++;
                        SetLocalInt(oDungeon, "n" + sLevel + "ItemNum", nWaypointPlotNum);
                        SetLocalInt(oDungeon, "n" + sLevel + "Item" + IntToString(nWaypointPlotNum) + "ItemType", 2);
                        SetLocalInt(oDungeon, "n" + sLevel + "Item" + IntToString(nWaypointPlotNum) + "Size", 1);

//                        string sResRef;
                        int nItem;
                        if (nBossQuestLevel == 1) // lieutenants
                        {
                            if (nBossQuestBoss == ID_LOCAL_LIEUTENANT_WEREBOAR)
                            {
//                                sResRef = "id1_bossplot_ant";
                                nItem = -1;
                            } else if (nBossQuestBoss == ID_LOCAL_LIEUTENANT_GIANTESS)
                            {
//                                sResRef = "id1_bossplot_hag";
                                nItem = -2;
                            } else if (nBossQuestBoss == ID_LOCAL_LIEUTENANT_INSECT)
                            {
//                                sResRef = "id1_bossplot_mag";
                                nItem = -3;
                            }
                        } else if (nBossQuestLevel == 2) // inner circle
                        {
                            if (nBossQuestBoss == ID_LOCAL_BOSS_DEMON)
                            {
//                                sResRef = "id1_bossplot_har";
                                nItem = -4;
                            } else if (nBossQuestBoss == ID_LOCAL_BOSS_BEHOLDER)
                            {
//                                sResRef = "id1_bossplot_gzb";
                                nItem = -5;
                            } else if (nBossQuestBoss == ID_LOCAL_BOSS_LICH)
                            {
//                                sResRef = "id1_bossplot_mas";
                                nItem = -6;
                            }
                        }

                        SetLocalInt(oDungeon, "n" + sLevel + "Item" + IntToString(nWaypointPlotNum) + "Item", nItem);
                        DebugMessage("        Added plot -1 to n" + sLevel + "Plot" + IntToString(nWaypointPlotNum) + " with item " + IntToString(nItem));

                        // record which area the item will be dropped in
                        SetLocalInt(oDungeon, "nBossPlotArea", nArea);
                    } else // there are no waypoints on this level
                    {
                        DebugMessage("      No encounter or treasure waypoints. Adding to emergency list.");

                        // dump everything at the first stairs up
                        string sLevel = "EmergencyLevel" + IntToString(nCurrentLevel);

                        // add the new item
                        int nItemNum = GetLocalInt(oDungeon, "n" + sLevel + "ItemNum");
                        DebugMessage("There are " + IntToString(nItemNum) + " items already at the emergency point.");
                        nItemNum++;
                        SetLocalInt(oDungeon, "n" + sLevel + "ItemNum", nItemNum);

                        // add item details
                        string sItem = sLevel + "Item" + IntToString(nItemNum);
                        SetLocalInt(oDungeon, "n" + sItem, -1);
                        DebugMessage("Adding item " + sItem);

                        // get the emergency stair area on this level and record it as the plot item location
                        int nStairsUp = GetLocalInt(oDungeon, "nLevel" + IntToString(nCurrentLevel) + "StairsUp1");
                        SetLocalInt(oDungeon, "nBossPlotArea", nStairsUp);
                    }
                }
            } else
            {
                DebugMessage("      Level does not match.");
            }
        } else
        {
            DebugMessage("    Boss quest is not present.");
        }

        // destroy the temporary holder object
        DestroyObject(oTempHolder);

        // return to level generation
        DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
    }
}

int GetPlotGameplayType()
{
    int nType1Frequency = GetModuleFlagValue(ID1_FLAG_PLOT_TYPE1_FREQUENCY);
    int nType2Frequency = nType1Frequency + GetModuleFlagValue(ID1_FLAG_PLOT_TYPE2_FREQUENCY);
    int nType3Frequency = nType2Frequency + GetModuleFlagValue(ID1_FLAG_PLOT_TYPE3_FREQUENCY);
    int nType4Frequency = nType3Frequency + GetModuleFlagValue(ID1_FLAG_PLOT_TYPE4_FREQUENCY);
    int nType5Frequency = nType4Frequency + GetModuleFlagValue(ID1_FLAG_PLOT_TYPE5_FREQUENCY);
    int nType6Frequency = nType5Frequency + GetModuleFlagValue(ID1_FLAG_PLOT_TYPE6_FREQUENCY);
    int nType7Frequency = nType6Frequency + GetModuleFlagValue(ID1_FLAG_PLOT_TYPE7_FREQUENCY);
    DebugMessage("nType1Frequency is " + IntToString(nType1Frequency));
    DebugMessage("nType2Frequency is " + IntToString(nType2Frequency));
    DebugMessage("nType3Frequency is " + IntToString(nType3Frequency));
    DebugMessage("nType4Frequency is " + IntToString(nType4Frequency));
    DebugMessage("nType5Frequency is " + IntToString(nType5Frequency));
    DebugMessage("nType6Frequency is " + IntToString(nType6Frequency));
    DebugMessage("nType7Frequency is " + IntToString(nType7Frequency));

    int nRandom = Random(nType7Frequency) + 1;
    DebugMessage("nRandom is " + IntToString(nRandom));

    if (nRandom <= nType1Frequency) // kill number of creatures
    {
        return 1;
    } else if (nRandom <= nType2Frequency) // clear area of creatures
    {
        return 2;
    } else if (nRandom <= nType3Frequency) // collect items dropped by creatures
    {
        return 3;
    } else if (nRandom <= nType4Frequency) // collect items found in places
    {
        return 4;
    } else if (nRandom <= nType5Frequency) // explore an area
    {
        return 5;
    } else if (nRandom <= nType6Frequency) // go to a specific creature
    {
        return 6;
    } else // go to a specific object
    {
        return 7;
    }
}

int GetPlotLevelScope(int nGameplayType)
{
    // EDIT: change to graded system
    int nRandom = d100();
    int nScope;

    if (nRandom <= 60)
    {
        nScope =  1;
    } else if (nRandom <= 90)
    {
        nScope =  2;
    } else
    {
        nScope = 3;
    }

    if ((nScope > 1) && (nGameplayType > 5))
    {
        nScope = 1;
    }

    if ((nScope > 2) && ((nGameplayType == 2) || (nGameplayType == 5)))
    {
        nScope = 2;
    }

    // EDIT: to remove scope 3
    if (nScope == 3)
    {
        nScope = 2;
    }

    return nScope;
}

int GetPlotLevelNumber()
{
    // EDIT: make more graded
    int nRandom = d100();

    if (nRandom <= 60)
    {
        return 2;
    } else if (nRandom <= 85)
    {
        return 3;
    } else
    {
        return 4;
    }
}

int GetLevelIncrement()
{
    // EDIT: make more graded
    int nRandom = d100();

    if (nRandom <= 70)
    {
        return 0;
    } else if (nRandom <= 85)
    {
        return 1;
    } else if (nRandom <= 95)
    {
        return 2;
    } else
    {
        return 3;
    }
}

int GetPlotAreaScope(int nGameplayType)
{
    // EDIT: change to graded system
    int nRandom = d100();
    int nScope;

    if (nRandom <= 60)
    {
        nScope =  1;
    } else if (nRandom <= 90)
    {
        nScope =  2;
    } else
    {
        nScope = 3;
    }

    if ((nScope > 1) && (nGameplayType > 5))
    {
        nScope = 1;
    }

    if ((nScope > 2) && ((nGameplayType == 1) || (nGameplayType == 3) || (nGameplayType == 4)))
    {
        nScope = 2;
    }

    return nScope;
}

int GetPlotAreaNumber()
{
    // EDIT: change to make more graded
    int nRandom = d100();

    if (nRandom <= 40)
    {
        return 2;
    } else if (nRandom <= 55)
    {
        return 3;
    } else if (nRandom <= 70)
    {
        return 4;
    } else if (nRandom <= 80)
    {
        return 5;
    } else if (nRandom <= 90)
    {
        return 6;
    } else if (nRandom <= 95)
    {
        return 7;
    } else
    {
        return 8;
    }
}

int GetTargetNum(int nPartySize, int nPartyLevel)
{
    int nBase = nPartySize * nPartyLevel;
    if (nBase < 2)
    {
        nBase = 2;
    } else if (nBase > 10)
    {
        nBase = 10;
    }

    int nRandom = Random(nBase + 1) + nBase;

    return nRandom;
}

