//:://////////////////////////////////////////////////////////////
//:: exe_id1_levelgen                                           //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    This script controls the level generation process. This
    process is divided into a number of different stages:
        0 - Cleaning the previous level
        1 - Generating initial level layout
        2 - Placing staircases in the level
        3 - Placing boss area in the level
        4 - Adding plots to this level
        5 - Linking doors between areas
        6 - Transporting the party to the new level
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: August 2005                                    //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Include Files                                                //
//////////////////////////////////////////////////////////////////

#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_gen"

// object GetNextCPU()
#include "inc_id1_utility"

void CleanLevel();
void GenerateAreas();
void GenerateStairs();
void GenerateBoss();
void GeneratePlots();
void GenerateDoors();

//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    // get the current stage variable
    int nProcess = GetLocalInt(GetModule(), "nLevelProcess");

    int nThemeCategory;
    int nThemeNum;
    int nTheme;
    object oDungeon;
    int nObjectNum;
    int nObject;
    string sThemeName;
    int nMaxLine;
    int nObjectLine;
    int bUsed;
    int nObjectCategoryNum;
    int bCreatureGenerated;
    int bMiniBossGenerated;
    string sTheme;
    string sThemeSubString;

    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
    DebugMessage("Generation is on level " + IntToString(nCurrentLevel));

    object oPC = GetLocalObject(GetModule(), "oTempPC");
    object oSpeaker = GetLocalObject(GetModule(), "oSpeaker");
    AssignCommand(oSpeaker, SpeakString("Generating Level."));
    DelayCommand(300.0, AssignCommand(oPC, ActionSpeakStringByStrRef(3043, TALKVOLUME_WHISPER)));

    // start the appropriate generation process
    switch (nProcess)
    {
        case 0:
            // clean previous level
            nProcess++;
            SetLocalInt(GetModule(), "nLevelProcess", nProcess);

            DebugMessage("");
            DebugMessage("====LEVEL GENERATION START====");
            DebugMessage("Cleaning area.");
            DebugMessage("");

            // set up first primary theme for next step
            SetLocalInt(GetModule(), "nQueueMax", 1); // theme category
            SetLocalInt(GetModule(), "nQueueMin", 1); // theme in category
            SetLocalInt(GetModule(), "nCurrentX", 1); // beginning of lists to check

            DebugMessage("");
            DebugMessage("Cleaning up previous area.");

            CleanLevel();

            break;

        case 1:
            // make sure theme-related lists are generated
            oDungeon = GetCurrentDungeon();
            nThemeCategory = GetLocalInt(GetModule(), "nQueueMax");
            DebugMessage("Theme lists.");
            DebugMessage("  Theme category is " + IntToString(nThemeCategory));
            if (nThemeCategory == 1) // primary themes
            {
                // get current and max primary themes
                nThemeNum = GetLocalInt(oDungeon, "nPrimaryTheme");
                nTheme = GetLocalInt(GetModule(), "nQueueMin");
                DebugMessage("  On theme " + IntToString(nTheme) + " of " + IntToString(nThemeNum));
                if (nTheme > nThemeNum)
                {
                    // if current is above max, set as first secondary
                    SetLocalInt(GetModule(), "nQueueMax", 2);
                    nThemeCategory = 2;
                    SetLocalInt(GetModule(), "nQueueMin", 1);
                } else
                {
                    sThemeName = GetLocalString(oDungeon, "sPrimaryTheme" + IntToString(nTheme) + "Name");
                }
            }
            if (nThemeCategory == 2) // secondary themes
            {
                // get current and max primary themes
                nThemeNum = GetLocalInt(oDungeon, "nSecondaryTheme");
                nTheme = GetLocalInt(GetModule(), "nQueueMin");
                DebugMessage("  On theme " + IntToString(nTheme) + " of " + IntToString(nThemeNum));
                if (nTheme > nThemeNum)
                {
                    // if current is above max, set done
                    SetLocalInt(GetModule(), "nQueueMax", 3);
                    nThemeCategory = 3;
                    SetLocalInt(GetModule(), "nQueueMin", 1);
                } else
                {
                    sThemeName = GetLocalString(oDungeon, "sSecondaryTheme" + IntToString(nTheme) + "Name");
                }
            }
            DebugMessage("  sThemeName is " + sThemeName);
            if ((nThemeCategory == 1) || (nThemeCategory == 2))
            {
                // get theme number
                nTheme = GetLocalInt(GetModule(), "nTheme_" + sThemeName);
                DebugMessage("  nTheme" + IntToString(nTheme));
                bCreatureGenerated = GetLocalInt(GetModule(), "bTheme" + IntToString(nTheme) + "CreatureGenerated");
                bMiniBossGenerated = GetLocalInt(GetModule(), "bTheme" + IntToString(nTheme) + "MiniBossGenerated");
                DebugMessage("  bTheme" + IntToString(nTheme) + "CreatureGenerated is " + IntToString(bCreatureGenerated));
                DebugMessage("  bTheme" + IntToString(nTheme) + "MiniBossGenerated is " + IntToString(bMiniBossGenerated));

                // creature theme list
                if (bCreatureGenerated == FALSE)
                {
                    DebugMessage("  Creatures for this theme have not been generated.");

                    nObjectNum = GetLocalInt(GetModule(), "nCreature");
                    nObject = GetLocalInt(GetModule(), "nCurrentX");
                    nMaxLine = nObject + 100;
                    DebugMessage("  On creature " + IntToString(nObject) + " of " + IntToString(nObjectNum) + " with max of " + IntToString(nMaxLine));
                    while ((nObject <= nObjectNum) && (nObject < nMaxLine))
                    {
                        // get decor item line
//                        nObjectLine = GetLocalInt(GetModule(), "nCreature" + IntToString(nObject) + "Line");
//                        DebugMessage("    Creature " + IntToString(nObject) + " is on line " + IntToString(nObjectLine));

                        // check to see if this decor item is used by this tileset
//                        bUsed = StringToInt(Get2DAString("creatures", sThemeName, nObjectLine));
                        sTheme = GetLocalString(GetModule(), "sCreature" + IntToString(nObject) + "Themes");
                        sThemeSubString = GetSubString(sTheme, nTheme - 1, 1);
                        bUsed = StringToInt(sThemeSubString);
                        DebugMessage("    Creature " + IntToString(nObject) + " has themes " + sTheme + " and substring " + IntToString(nTheme) + " is " + sThemeSubString);

                        // if so, increment tileset decor list
                        if (bUsed == TRUE)
                        {
                            nObjectCategoryNum = GetLocalInt(GetModule(), "nTheme" + IntToString(nTheme) + "Creature");
                            nObjectCategoryNum++;
                            SetLocalInt(GetModule(), "nTheme" + IntToString(nTheme) + "Creature", nObjectCategoryNum);
                            SetLocalInt(GetModule(), "nTheme" + IntToString(nTheme) + "Creature" + IntToString(nObjectCategoryNum), nObject);
                            DebugMessage("    Added nTheme" + IntToString(nTheme) + "Creature" + IntToString(nObjectCategoryNum) + " at " + IntToString(nObject));
                        }

                        nObject++;
                    }

                    // if this process is finished
                    if (nObject > nObjectNum)
                    {
                        DebugMessage("  Completed generation.");

                        SetLocalInt(GetModule(), "nCurrentX", 1);

//                        nThemeCategory++;
//                        SetLocalInt(GetModule(), "nQueueMax", nThemeCategory);
//                        nTheme = GetLocalInt(GetModule(), "nQueueMin");
//                        nTheme++;
//                        SetLocalInt(GetModule(), "nQueueMin", nTheme);

                        DebugMessage("  Setting bTheme" + IntToString(nTheme) + "CreatureGenerated");
                        SetLocalInt(GetModule(), "bTheme" + IntToString(nTheme) + "CreatureGenerated", TRUE);
                    } else
                    {
                        SetLocalInt(GetModule(), "nCurrentX", nMaxLine);
                    }
                } else if (bMiniBossGenerated == FALSE)
                {
                    DebugMessage("  Minibosses for this theme have not been generated.");

                    nObjectNum = GetLocalInt(GetModule(), "nMiniBoss");
                    nObject = GetLocalInt(GetModule(), "nCurrentX");
                    nMaxLine = nObject + 100;
                    DebugMessage("  On miniboss " + IntToString(nObject) + " of " + IntToString(nObjectNum) + " with max of " + IntToString(nMaxLine));
                    while ((nObject <= nObjectNum) && (nObject < nMaxLine))
                    {
                        // get decor item line
//                        nObjectLine = GetLocalInt(GetModule(), "nMiniBoss" + IntToString(nObject) + "Line");
//                        DebugMessage("    Miniboss " + IntToString(nObject) + " is on line " + IntToString(nObjectLine));

                        // check to see if this decor item is used by this tileset
//                        bUsed = StringToInt(Get2DAString("miniboss", sThemeName, nObjectLine));
                        sTheme = GetLocalString(GetModule(), "sMiniBoss" + IntToString(nObject) + "Themes");
                        sThemeSubString = GetSubString(sTheme, nTheme - 1, 1);
                        bUsed = StringToInt(sThemeSubString);
                        DebugMessage("    Miniboss " + IntToString(nObject) + " has themes " + sTheme + " and substring " + IntToString(nTheme) + " is " + sThemeSubString);

                        // if so, increment tileset decor list
                        if (bUsed == TRUE)
                        {
                            nObjectCategoryNum = GetLocalInt(GetModule(), "nTheme" + IntToString(nTheme) + "MiniBoss");
                            nObjectCategoryNum++;
                            SetLocalInt(GetModule(), "nTheme" + IntToString(nTheme) + "MiniBoss", nObjectCategoryNum);
                            SetLocalInt(GetModule(), "nTheme" + IntToString(nTheme) + "MiniBoss" + IntToString(nObjectCategoryNum), nObject);
                            DebugMessage("    Added nTheme" + IntToString(nTheme) + "MiniBoss" + IntToString(nObjectCategoryNum) + " at " + IntToString(nObject));
                        }

                        nObject++;
                    }

                    // if this process is finished
                    if (nObject > nObjectNum)
                    {
                        DebugMessage("  Completed generation.");

                        SetLocalInt(GetModule(), "nCurrentX", 1);

//                        nThemeCategory++;
//                        SetLocalInt(GetModule(), "nQueueMax", nThemeCategory);

                        DebugMessage("  Setting bTheme" + IntToString(nTheme) + "MiniBossGenerated");
                        SetLocalInt(GetModule(), "bTheme" + IntToString(nTheme) + "MiniBossGenerated", TRUE);

                        nTheme = GetLocalInt(GetModule(), "nQueueMin");
                        nTheme++;
                        SetLocalInt(GetModule(), "nQueueMin", nTheme);
                    } else
                    {
                        SetLocalInt(GetModule(), "nCurrentX", nMaxLine);
                    }
                } else
                {
                    nTheme = GetLocalInt(GetModule(), "nQueueMin");
                    nTheme++;
                    SetLocalInt(GetModule(), "nQueueMin", nTheme);
                }
            } else
            {
                nProcess++;
                SetLocalInt(GetModule(), "nLevelProcess", nProcess);
            }

            // return to level generation
            DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));

            break;

        case 2:
            // generate level layout
            nProcess++;
            SetLocalInt(GetModule(), "nLevelProcess", nProcess);

            DebugMessage("");
            DebugMessage("Starting area generation.");

            GenerateAreas();

            break;

        case 3:
            // add staircases
            nProcess++;
            SetLocalInt(GetModule(), "nLevelProcess", nProcess);

            DebugMessage("");
            DebugMessage("Starting stair generation.");

            GenerateStairs();

            break;

        case 4:
            // add boss lairs
            nProcess++;
            SetLocalInt(GetModule(), "nLevelProcess", nProcess);

            DebugMessage("");
            DebugMessage("Starting boss lair generation.");

            GenerateBoss();

            break;

        case 5:
            // add plots
            nProcess++;
            SetLocalInt(GetModule(), "nLevelProcess", nProcess);

            DebugMessage("");
            DebugMessage("Starting plot generation.");

            GeneratePlots();

            break;

        case 6:
            // add doors
            nProcess++;
            SetLocalInt(GetModule(), "nLevelProcess", nProcess);

            DebugMessage("");
            DebugMessage("Starting door generation.");

            GenerateDoors();

            break;

        case 7:
            // transport the party to the new level

            // clean up level generation variables
            SetLocalInt(GetModule(), "nLevelProcess", 0);

            DeleteLocalInt(GetModule(), "nCurrentX");
            DeleteLocalInt(GetModule(), "nCurrentY");
            DeleteLocalInt(GetModule(), "nCurrentStair");
            DeleteLocalInt(GetModule(), "nQueueMin");
            DeleteLocalInt(GetModule(), "nQueueMax");

            DebugMessage("");
            DebugMessage("");
            DebugMessage("====LEVEL GENERATION END====");
            DebugMessage("");

            DebugMessage("");
            DebugMessage("Starting transport script.");

            AssignCommand(oSpeaker, SpeakString("Generating Area."));

            DelayCommand(0.01, ExecuteScript("exe_id1_trans", GetNextCPU()));

            break;
    }
}

void CleanLevel()
{
    // set level generation to true
    SetLocalInt(GetModule(), "bTempLevelGen", TRUE);

    if (GetLocalInt(GetModule(), "nCurrentLevel") > 0)
    {
        // clean that level's objects
        DelayCommand(0.01, ExecuteScript("exe_id1_cleancur", GetNextCPU()));
    } else
    {
        DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
    }
}

void GenerateAreas()
{
    DebugMessage("");

    // setup
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
    object oDungeon = GetCurrentDungeon();
    int nMaxLevel = GetLocalInt(oDungeon, "nMaxLevel");
    int nDungeonDepth = GetLocalInt(oDungeon, "nDungeonDepth");

    // set the current level
    nCurrentLevel++;
    DebugMessage("Set nCurrentLevel to " + IntToString(nCurrentLevel) + ". Point 4.");
    SetLocalInt(GetModule(), "nCurrentLevel", nCurrentLevel);

    // show that an extra level has been generated
    nMaxLevel++;
    SetLocalInt(oDungeon, "nMaxLevel", nMaxLevel);
    DebugMessage("Setting current level to " + IntToString(nCurrentLevel) + " and max level to " + IntToString(nMaxLevel));

    // set the start of the queue
    SetLocalInt(GetModule(), "nQueueMax", 1);
    SetLocalInt(GetModule(), "nQueueMin", 1);

    // get the extent of the dungeon
    int nMaxX = GetLocalInt(oDungeon, "nMaxX");
    int nMaxY = GetLocalInt(oDungeon, "nMaxY");

    DebugMessage("Maximums are " + IntToString(nMaxX) + "," + IntToString(nMaxY));

    // set the random starting location
    SetLocalInt(GetModule(), "nQueue1X", Random(nMaxX) + 1);
    SetLocalInt(GetModule(), "nQueue1Y", Random(nMaxY) + 1);

    // reset the number of areas used
    SetLocalInt(GetModule(), "nAreaNumber", 0);

    // set the area generation process as started
    SetLocalInt(GetModule(), "nAreaProcess", 0);

    // reset the temp area variable
    SetLocalObject(GetModule(), "oAreaProcessArea", OBJECT_INVALID);

    // start the level generation process
    DelayCommand(0.01, ExecuteScript("exe_id1_areagen", GetNextCPU()));
}

void GenerateStairs()
{
    DebugMessage("");

    // reset the queue to the beginning
    SetLocalInt(GetModule(), "nQueueMax", 1);
    SetLocalInt(GetModule(), "nQueueMin", 1);

    // set the temporary variables
    SetLocalInt(GetModule(), "nCurrentX", 0);
    SetLocalInt(GetModule(), "nCurrentY", 0);
    SetLocalInt(GetModule(), "nCurrentStair", 0);

    // set the number of down stairs
    SetLocalInt(GetModule(), "nStairsTemp", 0);
    object oDungeon = GetCurrentDungeon();
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
    int nMaxX = GetLocalInt(oDungeon, "nMaxX");
    int nMaxY = GetLocalInt(oDungeon, "nMaxY");
    int nDungeonDepth = GetLocalInt(oDungeon, "nDungeonDepth");
    int nStairsMax = GetLocalInt(oDungeon, "nStairsMax");
    if (GetLocalInt(oDungeon, "bStairsFixed") == FALSE)
    {
        // set a random number of stairs up to the maximum
        int nRandom = Random(nStairsMax) + 1;
        DebugMessage("Setting random maximum number of stairs to " + IntToString(nRandom));
        SetLocalInt(GetModule(), "nStairsTemp", nRandom);
    } else
    {
        DebugMessage("Setting maximum number of stairs to " + IntToString(nStairsMax));
        SetLocalInt(GetModule(), "nStairsTemp", nStairsMax);
    }

    int nAreaNumber = GetLocalInt(GetModule(), "nAreaNumber");
    int nAreaNeeded = 0;

    // if a down staircase is possible, there must be at least one
    if (nCurrentLevel < nDungeonDepth)
    {
        DebugMessage("Down staircase needed.");

        nAreaNeeded++;
    } else // if on the final level of the dungeon
    {
        // check the flag to see if a boss is needed in this dungeon
        if (GetLocalInt(oDungeon, "bBossPresent") == TRUE)
        {
            DebugMessage("Boss area needed.");

            nAreaNeeded++;
        } else // a boss is not needed
        {
            DebugMessage("No boss needed.");
        }

    }

    // there must be an area for each up staircase
    if (nCurrentLevel == 1)
    {
        DebugMessage("On first level.");

        nAreaNeeded++;
    } else
    {
        DebugMessage("Not on first level.");

        nAreaNeeded += GetLocalInt(oDungeon, "nLevel" + IntToString(nCurrentLevel - 1) + "StairsDown");
    }

    DebugMessage("Have " + IntToString(nAreaNumber) + " out of " + IntToString(nAreaNeeded) + " areas needed.");
    int nTotal = nMaxX * nMaxY;
    DebugMessage(IntToString(nTotal) + " areas possible.");

    // if there are enough areas, or there can never possibly be enough areas, go ahead
    if ((nAreaNumber >= nAreaNeeded) || (nTotal < nAreaNeeded))
    {
        if (nAreaNumber >= nAreaNeeded)
        {
            DebugMessage("There are enough areas for the staircases.");
        }

        if (nTotal < nAreaNeeded)
        {
            DebugMessage("There can never be enough areas.");
        }

        // set the up staircase generation first
        SetLocalInt(GetModule(), "nStairType", ID1_UP_STAIRS);

        // start generation
        DebugMessage("Passing stair generation to CPUs.");
        DelayCommand(0.01, ExecuteScript("exe_id1_stairgen", GetNextCPU()));
    } else // there is space for enough areas, but they haven't been assigned
    {
        DebugMessage("Starting emergency area generation.");

        // go back one process in level generation
        SetLocalInt(GetModule(), "nLevelProcess", 1);

        // start emergency area generation
        DelayCommand(0.01, ExecuteScript("exe_id1_areafix", GetNextCPU()));
    }
}

void GenerateBoss()
{
    // get the dungeon
    object oDungeon = GetCurrentDungeon();

    // determine if this is the last level
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
    int nDungeonDepth = GetLocalInt(oDungeon, "nDungeonDepth");
    DebugMessage("  On level " + IntToString(nCurrentLevel) + " of " + IntToString(nDungeonDepth));

    // if this is the bottom level
    if (nCurrentLevel == nDungeonDepth)
    {
        // check to see if a boss is needed
        if (GetLocalInt(oDungeon, "bBossPresent") == TRUE)
        {
            DebugMessage("Boss needed in this dungeon.");

            // dungeon extents
            int nMaxX = GetLocalInt(oDungeon, "nMaxX");
            int nMaxY = GetLocalInt(oDungeon, "nMaxY");

            DebugMessage("Maximums are " + IntToString(nMaxX) + "," + IntToString(nMaxY));

            // set queue
            SetLocalInt(GetModule(), "nQueueMin", 1);
            SetLocalInt(GetModule(), "nQueueMax", 1);
            SetLocalInt(GetModule(), "nQueue1X", Random(nMaxX) + 1);
            SetLocalInt(GetModule(), "nQueue1Y", Random(nMaxY) + 1);

            // temporary Y
            SetLocalInt(GetModule(), "nCurrentX", 0);
            SetLocalInt(GetModule(), "nCurrentY", 0);

            // run boss generation script
            DelayCommand(0.01, ExecuteScript("exe_id1_bossgen", GetNextCPU()));
        } else
        {
            DebugMessage("No boss in this dungeon.");

            DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
        }
    } else // this is not the bottom level
    {
        // return to level generation script
        DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
    }
}

void GeneratePlots()
{
    // create temporary holding object
    object oTempHolder = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "ID1_TempHolder");

    SetLocalInt(oTempHolder, "nCurrentX", 1);
    SetLocalInt(oTempHolder, "nCurrentY", 1);
    SetLocalInt(oTempHolder, "nTempProcess", 1);

    DelayCommand(0.01, ExecuteScript("exe_id1_plotgen", GetNextCPU()));
}

void GenerateDoors()
{
    // count from from 1,1 all the way to the maximum
    SetLocalInt(GetModule(), "nCurrentX", 1);
    SetLocalInt(GetModule(), "nCurrentY", 1);

    DebugMessage("");
    DebugMessage("Generating doors.");

    // execute next script
    DelayCommand(0.01, ExecuteScript("exe_id1_doorgen", GetNextCPU()));
}

