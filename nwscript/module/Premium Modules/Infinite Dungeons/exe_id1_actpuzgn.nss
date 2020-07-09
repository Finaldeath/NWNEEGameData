#include "inc_id1_debug"
#include "inc_id1_camp"
#include "inc_id1_flags"
#include "inc_id1_utility"
#include "inc_id1_creature"

void main()
{
    DebugMessage("");
    DebugMessage("Puzzle and camp generation.");

    object oPC = GetLocalObject(GetModule(), "oTempPC");
    object oDestinationDoor = GetLocalObject(GetModule(), "oTempDestinationDoor");
    object oDungeon = GetLocalObject(GetModule(), "oTempDungeon");
    object oArea = GetArea(oDestinationDoor);
    int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

    // get current level
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");

    // get coordinates
    int nX = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "Level" + IntToString(nCurrentLevel) + "X");
    int nY = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "Level" + IntToString(nCurrentLevel) + "Y");

    string sTileset = GetLocalString(oDungeon, "sArea" + IntToString(nAreaNum) + "Tileset");
    int nTileset = GetLocalInt(GetModule(), "nTileset_" + sTileset);
    DebugMessage("sArea" + IntToString(nAreaNum) + "Tileset is " + sTileset + " and nTileset is " + IntToString(nTileset));

    // get number of puzzle points
    int nPuzzleNum = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "WaypointPuzzle");

    int nPartyLevel = GetPartyLevel(oPC, FALSE);
    int nPartySize = GetPartySize(oPC, FALSE);
    int nPartySizeLevel = GetPartyLevelSize(nPartyLevel, nPartySize);
    int nPartyDifficultyLevel = nPartySizeLevel + GetModuleFlagValue(ID1_FLAG_ENCOUNTER_DIFFICULTY);

    int nPuzzleFrequency = GetModuleFlagValue(ID1_FLAG_PUZZLE_FREQUENCY);
    int nCampFrequency = GetModuleFlagValue(ID1_FLAG_CAMP_FREQUENCY);
    int nAreaPercentage = GetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_AREA_PERCENTAGE);
    int nTreasurePercentage = GetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_TREASURE_PERCENTAGE);
    int nExperiencePercentage = GetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_EXPERIENCE_PERCENTAGE);
    int nTotalPercentage = nAreaPercentage + nTreasurePercentage + nExperiencePercentage;
    DebugMessage("Area percentage is " + IntToString(nAreaPercentage) + ", treasure percentage is " + IntToString(nTreasurePercentage) + ", experience percentage is " + IntToString(nExperiencePercentage) + ", total is " + IntToString(nTotalPercentage));

    int nPuzzleDifficulty = GetModuleFlag(ID1_FLAG_PUZZLE_DIFFICULTY);
    int nPuzzleDifficultyNum;

    if (nPuzzleDifficulty == ID1_PUZZLE_DIFFICULTY_EASY)
    {
        nPuzzleDifficultyNum = GetLocalInt(GetModule(), "nPuzzleEasy");
    } else if (nPuzzleDifficulty == ID1_PUZZLE_DIFFICULTY_NORMAL)
    {
        nPuzzleDifficultyNum = GetLocalInt(GetModule(), "nPuzzleNormal");
    } else if (nPuzzleDifficulty == ID1_PUZZLE_DIFFICULTY_HARD)
    {
        nPuzzleDifficultyNum = GetLocalInt(GetModule(), "nPuzzleHard");
    }

    int nPuzzle = 1;
    int bPresent;
    string sPuzzle;
    object oPuzzle;
    object oCamp;
    object oCampNote;
    string sLevel;
    int nReward;
    object oMicroCPU;
    int nMicroNum;
    int nContainerNum = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "Container");
    int nContainer;
    int nDungeonContainer;
    object oSecretEntrance;
    object oSecretExit;
    object oSecretWaypoint;
    int nSecretWaypoint;
    string sSecretWaypoint;
    int bActive;
    float fDistance;
    float fValue;
    int nRandom;
    int nDungeonPuzzle;
    string sResRef;
    while (nPuzzle <= nPuzzleNum)
    {
        // if there is a puzzle here
        nRandom = d100();
        DebugMessage("    Examining puzzle point " + IntToString(nPuzzle) + " with random " + IntToString(nRandom) + " and frequency " + IntToString(nPuzzleFrequency));
        if (nRandom <= nPuzzleFrequency)
        {
            sLevel = "Area" + IntToString(nAreaNum) + "WaypointPuzzle" + IntToString(nPuzzle) + "Level" + IntToString(nCurrentLevel);
            SetLocalInt(oDungeon, "b" + sLevel + "Used", TRUE);

            // if there is a camp here
            nRandom = d100();
            if (nRandom <= nCampFrequency)
            {
                DebugMessage("    There is a camp at puzzle point " + IntToString(nPuzzle));

                // generate camp
                SetLocalInt(oDungeon, "b" + sLevel + "Camp", TRUE);

                // set for map icon
                string sIcon = "Level" + IntToString(nCurrentLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY);
                SetLocalInt(oDungeon, "b" + sIcon + "Camp", TRUE);

                GenerateEncampment(sLevel, sIcon);
            } else // if its actually a puzzle
            {
                DebugMessage("    There is a puzzle at puzzle point " + IntToString(nPuzzle));
                oPuzzle = GetLocalObject(oArea, "oWaypointPuzzle" + IntToString(nPuzzle));
                if (oPuzzle != OBJECT_INVALID)
                {
                    DebugMessage("    Puzzle waypoint oWaypointPuzzle" + IntToString(nPuzzle) + " is valid.");
                } else
                {
                    DebugMessage("    Puzzle waypoint oWaypointPuzzle" + IntToString(nPuzzle) + " is not valid.");
                }

                // record puzzle information
                SetLocalInt(oDungeon, "b" + sLevel + "Used", TRUE);

                nRandom = Random(nPuzzleDifficultyNum) + 1;
                if (nPuzzleDifficulty == ID1_PUZZLE_DIFFICULTY_EASY)
                {
                    nPuzzleDifficultyNum = GetLocalInt(GetModule(), "nPuzzleEasy");
                    sPuzzle = GetLocalString(GetModule(), "sPuzzleEasy" + IntToString(nRandom) + "Script");
                } else if (nPuzzleDifficulty == ID1_PUZZLE_DIFFICULTY_NORMAL)
                {
                    nPuzzleDifficultyNum = GetLocalInt(GetModule(), "nPuzzleNormal");
                    sPuzzle = GetLocalString(GetModule(), "sPuzzleNormal" + IntToString(nRandom) + "Script");
                } else if (nPuzzleDifficulty == ID1_PUZZLE_DIFFICULTY_HARD)
                {
                    nPuzzleDifficultyNum = GetLocalInt(GetModule(), "nPuzzleHard");
                    sPuzzle = GetLocalString(GetModule(), "sPuzzleHard" + IntToString(nRandom) + "Script");
                }

                // check to see if this script is already used by the dungeon
                nDungeonPuzzle = GetLocalInt(oDungeon, "nListPuzzle_" + sPuzzle);
                if (nDungeonPuzzle == 0)
                {
                    nDungeonPuzzle = GetLocalInt(oDungeon, "nListPuzzleNum");
                    nDungeonPuzzle++;
                    SetLocalInt(oDungeon, "nListPuzzleNum", nDungeonPuzzle);
                    SetLocalString(oDungeon, "sListPuzzle" + IntToString(nDungeonPuzzle) + "Script", sPuzzle);
                    SetLocalInt(oDungeon, "nListPuzzle_" + sPuzzle, nDungeonPuzzle);
                }
                SetLocalInt(oDungeon, "n" + sLevel + "Script", nDungeonPuzzle);
                DebugMessage("      Random puzzle picked was " + IntToString(nRandom) + " with script " + sPuzzle);

                // determine treasure type for this puzzle
                nRandom = Random(nTotalPercentage) + 1;
                if (nRandom <= nAreaPercentage) // secret area
                {
                    SetLocalInt(oDungeon, "n" + sLevel + "Reward", 1);
                    DebugMessage("  Puzzle reward set to 1");

                    oSecretEntrance = GetNearestObjectByTag("ID1_STATIC_WP_SECRET", oPuzzle);
                    if (oSecretEntrance != OBJECT_INVALID)
                    {
                        DebugMessage("Entrance was valid.");
                    } else
                    {
                        DebugMessage("Entrance was not valid.");
                    }
                    oSecretExit = GetNearestObjectByTag("ID1_STATIC_WP_SECRET", oSecretEntrance);
                    if (oSecretExit != OBJECT_INVALID)
                    {
                        DebugMessage("Exit was valid.");
                    } else
                    {
                        DebugMessage("Exit was not valid.");
                    }

                    // if there is a secret encounter waypoint nearby
                    oSecretWaypoint = GetNearestObjectByTag("ID1_STATIC_WP_SECRET_ENCOUNTER", oSecretExit);
                    if (oSecretWaypoint != OBJECT_INVALID)
                    {
                        DebugMessage("Secret encounter waypoint was valid.");

                        // if the point is close enough
                        fDistance = fabs(GetDistanceBetween(oSecretExit, oSecretWaypoint));
                        DebugMessage("Distance from secret entrance to waypoint = " + FloatToString(fDistance));
                        if (fDistance <= 20.0)
                        {
                            // if the point is not used
                            nSecretWaypoint = GetLocalInt(oSecretWaypoint, "nNumber");
                            sSecretWaypoint = "Area" + IntToString(nAreaNum) + "WaypointSecretEncounter" + IntToString(nSecretWaypoint) + "Level" + IntToString(nCurrentLevel);
                            bActive = GetLocalInt(oDungeon, "b" + sSecretWaypoint + "Used");
                            DebugMessage("Waypoint b" + sSecretWaypoint + "Used is " + IntToString(bActive));
                            if (bActive == FALSE)
                            {
                                oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU44");
                                SetLocalString(oMicroCPU, "sVariable", sSecretWaypoint);
                                SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                                SetLocalInt(oMicroCPU, "bHold", TRUE);
                                SetLocalInt(oMicroCPU, "nBaseLevel", nPartyDifficultyLevel);
                                SetLocalInt(oMicroCPU, "nBaseSize", nPartySize);
                                SetLocalInt(oMicroCPU, "nPercentage", 100);
                                SetLocalInt(oMicroCPU, "bBoss", FALSE);
                                SetLocalInt(oMicroCPU, "nTileset", nTileset);
                                SetLocalInt(oMicroCPU, "nTheme", -1);

                                // increment number of active microprocessors
                                nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                                nMicroNum++;
                                SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

                                DelayCommand(0.01, ExecuteScript("exe_id1_micenc", oMicroCPU));
                            }
                        }
                    } else
                    {
                        DebugMessage("Secret encounter waypoint was not valid.");
                    }

                    // get nearest secret treasure point
                    oSecretWaypoint = GetNearestObjectByTag("ID1_STATIC_WP_SECRET_TREASURE", oSecretExit);
                    if (oSecretWaypoint != OBJECT_INVALID)
                    {
                        DebugMessage("Secret treasure waypoint was valid.");

                        // if not active
                        nSecretWaypoint = GetLocalInt(oSecretWaypoint, "nNumber");
                        sSecretWaypoint = "Area" + IntToString(nAreaNum) + "WaypointSecretTreasure" + IntToString(nSecretWaypoint) + "Level" + IntToString(nCurrentLevel);
                        bActive = GetLocalInt(oDungeon, "b" + sSecretWaypoint + "Used");
                        DebugMessage("Waypoint b" + sSecretWaypoint + "Used is " + IntToString(bActive));
                        if (bActive == FALSE)
                        {
                            fDistance = fabs(GetDistanceBetween(oSecretExit, oSecretWaypoint));
                            DebugMessage("Distance from secret entrance to waypoint = " + FloatToString(fDistance));
                            if (fDistance <= 20.0)
                            {
                                SetLocalInt(oDungeon, "b" + sSecretWaypoint + "Used", TRUE);
                                DebugMessage("Set b" + sSecretWaypoint + "Used to true.");

                                // select chest
                                nRandom = Random(nContainerNum) + 1;
                                nContainer = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "Container" + IntToString(nRandom));
                                sResRef = GetLocalString(GetModule(), "sContainer" + IntToString(nContainer) + "ResRef");
                                nDungeonContainer = GetLocalInt(oDungeon, "nListContainer_" + sResRef);
                                if (nDungeonContainer == 0) // if not in the list, add
                                {
                                    nDungeonContainer = GetLocalInt(oDungeon, "nListContainerNum");
                                    nDungeonContainer++;
                                    SetLocalInt(oDungeon, "nListContainerNum", nDungeonContainer);
                                    SetLocalString(oDungeon, "sListContainer" + IntToString(nDungeonContainer) + "ResRef", sResRef);
                                    SetLocalInt(oDungeon, "nListContainer_" + sResRef, nDungeonContainer);
                                }
                                SetLocalInt(oDungeon, "n" + sSecretWaypoint + "Container", nDungeonContainer);
                                DebugMessage("        Set container n" + sSecretWaypoint + "Container to " + IntToString(nDungeonContainer));

                                // generate treasure
                                oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU45");
                                SetLocalInt(oMicroCPU, "nLevel", nPartyLevel);
                                SetLocalString(oMicroCPU, "sContainer", sSecretWaypoint);
                                fValue = GetModuleFlagValue(ID1_FLAG_TREASURE_CHEST_VALUE) / 100.0;
                                SetLocalFloat(oMicroCPU, "fValueMultiplier", fValue);
                                SetLocalInt(oMicroCPU, "bGoldPresent", TRUE);
                                SetLocalInt(oMicroCPU, "bGemPresent", TRUE);
                                SetLocalInt(oMicroCPU, "bItemPresent", TRUE);
                                SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                                SetLocalInt(oMicroCPU, "bHold", TRUE);

                                // increment number of active microprocessors
                                nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                                nMicroNum++;
                                SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

                                DelayCommand(0.01, ExecuteScript("exe_id1_mictre", oMicroCPU));
                            }
                        }
                    } else
                    {
                        DebugMessage("Secret treasure waypoint was not valid.");
                    }
                } else if (nRandom <= (nAreaPercentage + nTreasurePercentage)) // treasure
                {
                    SetLocalInt(oDungeon, "n" + sLevel + "Reward", 2);
                    DebugMessage("  Puzzle reward set to 2");

                    // pick container
                    nRandom = Random(nContainerNum) + 1;
                    nContainer = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "Container" + IntToString(nRandom));
                    sResRef = GetLocalString(GetModule(), "sContainer" + IntToString(nContainer) + "ResRef");
                    DebugMessage("        nTileset" + IntToString(nTileset) + "Container" + IntToString(nRandom) + " is " + sResRef);
                    nDungeonContainer = GetLocalInt(oDungeon, "nListContainer_" + sResRef);
                    if (nDungeonContainer == 0) // if not in the list, add
                    {
                        nDungeonContainer = GetLocalInt(oDungeon, "nListContainerNum");
                        nDungeonContainer++;
                        SetLocalInt(oDungeon, "nListContainerNum", nDungeonContainer);
                        SetLocalString(oDungeon, "sListContainer" + IntToString(nDungeonContainer) + "ResRef", sResRef);
                        SetLocalInt(oDungeon, "nListContainer_" + sResRef, nDungeonContainer);
                    }
                    SetLocalInt(oDungeon, "n" + sLevel + "Container", nDungeonContainer);
                    DebugMessage("        Set container n" + sLevel + "Container to " + IntToString(nDungeonContainer));

                    // generate treasure
                    oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU46");
                    SetLocalInt(oMicroCPU, "nLevel", nPartyLevel);
                    SetLocalString(oMicroCPU, "sContainer", sLevel);
                    fValue = GetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_TREASURE_VALUE) / 100.0;
                    SetLocalFloat(oMicroCPU, "fValueMultiplier", fValue);
                    SetLocalInt(oMicroCPU, "bGoldPresent", TRUE);
                    SetLocalInt(oMicroCPU, "bGemPresent", TRUE);
                    SetLocalInt(oMicroCPU, "bItemPresent", TRUE);
                    SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                    SetLocalInt(oMicroCPU, "bHold", TRUE);

                    // increment number of active microprocessors
                    nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                    nMicroNum++;
                    SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

                    DelayCommand(0.01, ExecuteScript("exe_id1_mictre", oMicroCPU));
                } else // experience
                {
                    SetLocalInt(oDungeon, "n" + sLevel + "Reward", 3);
                    DebugMessage("  Puzzle reward set to 3");

                    nReward = nPartyLevel * 200;
                    SetLocalInt(oDungeon, "n" + sLevel + "Experience", nReward);
                    DebugMessage("Set experience reward to " + IntToString(nReward));
                }

                // set for map icon
                SetLocalInt(oDungeon, "bLevel" + IntToString(nCurrentLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY) + "Puzzle", TRUE);
            }
        }

        nPuzzle++;
    }

    DebugMessage("Entering into holding pattern..");
    DelayCommand(0.01, ExecuteScript("exe_id1_acthold", GetNextCPU()));
}

