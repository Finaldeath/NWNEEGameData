#include "inc_id1_utility"
#include "inc_id1_score"
#include "inc_id_liltimmy"

void SetDungeonTheme(object oDungeon);
void SetDungeonGeometry(object oDungeon);
void SetDungeonBoss(object oDungeon);
void SetDungeonStairs(object oDungeon);
void AddThemeTilesets(int nTheme, object oDungeon);

void main()
{
    DebugMessage("");

    // set that a level is being generated
    SetLocalInt(GetModule(), "bGenerating", TRUE);
    DebugMessage("Setting bGenerating in dungeon to TRUE");

    DebugMessage("Starting party checking.");

    // go through each player and make sure they're in range
    object oPlayer = GetFirstPC();
    int bTooFar = FALSE;
    int bCombat = FALSE;
    object oArea = GetArea(OBJECT_SELF);
    object oPlayerArea;
    while ((oPlayer != OBJECT_INVALID) && (bTooFar == FALSE) && (bCombat == FALSE))
    {
        DebugMessage("Checking player " + GetName(oPlayer));

        oPlayerArea = GetArea(oPlayer);
        if (oPlayerArea == oArea)
        {
            DebugMessage("  Player is in the same area.");

            if (GetIsInCombat(oPlayer) == FALSE)
            {
                DebugMessage("    Player is not in combat. They're acceptable.");

                // if the player doesn't have a map
                if (GetItemPossessedBy(oPlayer, "itm_id1_map") == OBJECT_INVALID)
                {
                    DebugMessage("  Player does not have a dungeon map. Creating.");

                    // give player the map object
                    CreateItemOnObject("itm_id1_map", oPlayer);
                }

                // if the player doesn't have a dungeon journal
                if (GetItemPossessedBy(oPlayer, "itm_id1_journal") == OBJECT_INVALID)
                {
                    DebugMessage("  Player does not have a dungeon journal. Creating.");

                    // give player the map object
                    CreateItemOnObject("itm_id1_journal", oPlayer);
                }
            } else
            {
                DebugMessage("    Player is in combat.");

                bCombat = TRUE;
            }
        } else
        {
            DebugMessage("  Player is not in the same area.");

            bTooFar = TRUE;
        }

        // cycle to next player
        oPlayer = GetNextPC();
    }

    if (bTooFar == FALSE)
    {
        if (bCombat == FALSE)
        {
            // if 1 or 2, enter
            int nDungeonState = GetLocalInt(OBJECT_SELF, "nDungeonState");
            if ((nDungeonState == 1) || (nDungeonState == 2))
            {
                DebugMessage("");
                DebugMessage("Entering already created dungeon.");

                // get the PC
                object oPC = GetPCSpeaker();

                // if there is no dungeon active
                object oDungeon = GetCurrentDungeon();
                if (oDungeon != OBJECT_INVALID)
                {
                     DebugMessage("A dungeon is active.");

                    // get current and max levels
                    int nCurrentLevel = 0;
                    SetLocalInt(GetModule(), "nTempPreviousLevel", 0);
                    int nMaxLevel = GetLocalInt(oDungeon, "nMaxLevel");

                    DebugMessage("Current level: " + IntToString(nCurrentLevel));
                    DebugMessage("Max level: " + IntToString(nMaxLevel));

                    if (nCurrentLevel < nMaxLevel)
                    {
                        DebugMessage("  Stair has a destination.");

                        // find destination
                        int nDestination = GetLocalInt(oDungeon, "nLevel1StairsUp1");
                        int nDestinationIdentifier = GetLocalInt(oDungeon, "nArea" + IntToString(nDestination) + "Identifier");
                        object oArea2 = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nDestinationIdentifier));

                        DebugMessage("  Destination is area " + IntToString(nDestination) + " with identifier " + IntToString(nDestinationIdentifier));

                        if (oArea2 == OBJECT_INVALID)
                        {
                            DebugMessage("    Area is invalid.");
                        }

                        DebugMessage("  Going down.");
                        object oDoor = GetLocalObject(oArea2, "oStairsUp");
                        DebugMessage("Set nCurrentLevel to 1. Point 3.");
                        SetLocalInt(GetModule(), "nCurrentLevel", 1);

                        // stop generation
//                        SetLocalInt(GetModule(), "bGenerating", FALSE);
//                        DebugMessage("Setting bGenerating in dungeon to FALSE");

                        // transport the player
                        SetLocalObject(GetModule(), "oTempPC", oPC);
                        SetLocalObject(GetModule(), "oTempDestinationDoor", oDoor);
                        SetLocalObject(GetModule(), "oTempDungeon", oDungeon);
                        SetLocalInt(GetModule(), "bTempLevelGen", FALSE);
                        SetLocalObject(GetModule(), "oSpeaker", OBJECT_SELF);
                        SetLocalObject(GetModule(), "oTempArea", OBJECT_INVALID);

                        // set starting coordinates
                        SetLocalInt(GetModule(), "nCurrentX", 1);
                        SetLocalInt(GetModule(), "nCurrentY", 1);

                        if (GetLocalInt(GetModule(), "nTempPreviousLevel") > 0)
                        {
                            DelayCommand(0.01, ExecuteScript("exe_id1_cleancur", GetObjectByTag("CPU1")));
                        } else
                        {
                            SetLocalInt(GetModule(), "nActivationProcess", 0);
                            DelayCommand(0.01, ExecuteScript("exe_id1_active", GetObjectByTag("CPU1")));
                        }
                    } else
                    {
                        // set cutscene mode for the player
                        object oPlayer = GetFirstPC();
                        while (oPlayer != OBJECT_INVALID)
                        {
                            DebugMessage("Adding cutscene mode to player " + GetName(oPlayer));

                            // put in cutscene mode
                            if (GetCutsceneMode(oPlayer) == FALSE)
                            {
                                DebugMessage("Cutscene mode set on PC.");
                                SetCutsceneMode(oPlayer, TRUE);
                            } else
                            {
                                DebugMessage("Cutscene mode already set on PC.");
                            }

                            // cycle to next player
                            oPlayer = GetNextPC();
                        }

                        DebugMessage("Generating additional dungeon level.");
                        SetLocalObject(GetModule(), "oSpeaker", OBJECT_SELF);
                        SetLocalObject(GetModule(), "oTempArea", OBJECT_INVALID);
                        SetLocalInt(GetModule(), "nPreviousDungeon", 0);

                        // generate the level
                        SetLocalInt(GetModule(), "nLevelProcess", 0);
                        DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetObjectByTag("CPU1")));
                    }
                } else
                {
                    SpeakString("No dungeon exists.");

                    // break out
                    SetLocalInt(GetModule(), "bGenerating", FALSE);
                    DebugMessage("Setting bGenerating in dungeon to FALSE");
                }
            } else // if 3, create
            {
                DebugMessage("      Creating plot dungeon.");

                // set cutscene mode for the player
                object oPlayer = GetFirstPC();
                while (oPlayer != OBJECT_INVALID)
                {
                    DebugMessage("Adding cutscene mode to player " + GetName(oPlayer));

                    // put in cutscene mode
                    if (GetCutsceneMode(oPlayer) == FALSE)
                    {
                        DebugMessage("Cutscene mode set on PC.");
                        SetCutsceneMode(oPlayer, TRUE);
                    } else
                    {
                        DebugMessage("Cutscene mode already set on PC.");
                    }

                    // cycle to next player
                    oPlayer = GetNextPC();
                }

                object oPC = GetPCSpeaker();

                int nCurrentLevel = 0;

                // set this level as having come from the dungeon entrance
                SetLocalInt(GetModule(), "nTempPreviousLevel", nCurrentLevel);

                // record who made the dungeon
                SetLocalObject(GetModule(), "oGenerator", oPC);

                DebugMessage("        Setting generator object CD key: " + GetPCPublicCDKey(oPC, TRUE));

                // create new dungeon
                object oDungeon = CreateObject(OBJECT_TYPE_ITEM, "dungeonobject", GetLocation(GetObjectByTag("CPU")));
                SetLocalObject(GetModule(), "oCurrentDungeon", oDungeon);

                SetLocalInt(GetModule(), "bPlotDungeon", FALSE);

                // get position in plot
                int nPlotPosition = lt_GetDungeonLevel();
                DebugMessage("        Plot position is " + IntToString(nPlotPosition));

                string sThemeSetName = "";

                int nBoss;
                int nOldBoss = 0;
                int nPlotDungeon = 0;

                // if lieutenants
                if ((nPlotPosition == ID_LOCAL_DUNGEON_NOT_ENTERED) || (nPlotPosition == ID_LOCAL_FIRST_DUNGEON_COMPLETED) || (nPlotPosition == ID_LOCAL_SECOND_DUNGEON_COMPLETED))
                {
                    if (nPlotPosition == ID_LOCAL_DUNGEON_NOT_ENTERED)
                    {
                        nBoss = lt_GetFirstLieutenant();
                        nPlotDungeon = -1;
                        lt_SetDungeonLevel(ID_LOCAL_FIRST_DUNGEON_CREATED);
                    } else if (nPlotPosition == ID_LOCAL_FIRST_DUNGEON_COMPLETED)
                    {
                        nBoss = lt_GetSecondLieutenant();
                        nOldBoss = lt_GetFirstLieutenant();
                        nPlotDungeon = -2;
                        lt_SetDungeonLevel(ID_LOCAL_SECOND_DUNGEON_CREATED);
                    } else if (nPlotPosition == ID_LOCAL_SECOND_DUNGEON_COMPLETED)
                    {
                        nBoss = lt_GetThirdLieutenant();
                        nOldBoss = lt_GetSecondLieutenant();
                        nPlotDungeon = -3;
                        lt_SetDungeonLevel(ID_LOCAL_THIRD_DUNGEON_CREATED);
                    }

                    if (nBoss == ID_LOCAL_LIEUTENANT_WEREBOAR)
                    {
                        sThemeSetName = "BACCHA";
                        SetLocalString(oDungeon, "sDungeonName", "Lord Antoine's Den");
                    } else if (nBoss == ID_LOCAL_LIEUTENANT_GIANTESS)
                    {
                        sThemeSetName = "HAGATHA";
                        SetLocalString(oDungeon, "sDungeonName", "Widow Hagatha's Home");
                    } else if (nBoss == ID_LOCAL_LIEUTENANT_INSECT)
                    {
                        sThemeSetName = "MAGGRIS";
                        SetLocalString(oDungeon, "sDungeonName", "Maggris' Hive");
                    }

                    if (nOldBoss == ID_LOCAL_LIEUTENANT_WEREBOAR)
                    {
                        DebugMessage("        Baccha was the previous boss.");
                        if (GetLocalInt(GetModule(), "bBacchaQuestActive") == TRUE)
                        {
                            DebugMessage("          Quest active.");
                            SetLocalInt(oDungeon, "nBossQuestLevel", 1); // lieutenant
                            SetLocalInt(oDungeon, "nBossQuestBoss", ID_LOCAL_LIEUTENANT_WEREBOAR); // baccha
                        }
                    } else if (nOldBoss == ID_LOCAL_LIEUTENANT_GIANTESS)
                    {
                        DebugMessage("        Hagatha was the previous boss.");
                        if (GetLocalInt(GetModule(), "bHagathaQuestActive") == TRUE)
                        {
                            DebugMessage("          Quest active.");
                            SetLocalInt(oDungeon, "nBossQuestLevel", 1); // lieutenant
                            SetLocalInt(oDungeon, "nBossQuestBoss", ID_LOCAL_LIEUTENANT_GIANTESS); // hagatha
                        }
                    } else if (nOldBoss == ID_LOCAL_LIEUTENANT_INSECT)
                    {
                        DebugMessage("        Maggris was the previous boss.");
                        if (GetLocalInt(GetModule(), "bMaggrisQuestActive") == TRUE)
                        {
                            DebugMessage("          Quest active.");
                            SetLocalInt(oDungeon, "nBossQuestLevel", 1); // lieutenant
                            SetLocalInt(oDungeon, "nBossQuestBoss", ID_LOCAL_LIEUTENANT_INSECT); // maggris
                        }
                    }
                } else if ((nPlotPosition == ID_LOCAL_THIRD_DUNGEON_COMPLETED) || (nPlotPosition == ID_LOCAL_FIRST_BOSS_DEFEATED) || (nPlotPosition == ID_LOCAL_SECOND_BOSS_DEFEATED))
                {
                    if (nPlotPosition == ID_LOCAL_THIRD_DUNGEON_COMPLETED)
                    {
                        nBoss = lt_GetFirstBoss();
                        nOldBoss = lt_GetThirdLieutenant();
                        nPlotDungeon = -4;
                        lt_SetDungeonLevel(ID_LOCAL_FIRST_BOSS_CREATED);
                    } else if (nPlotPosition == ID_LOCAL_FIRST_BOSS_DEFEATED)
                    {
                        nBoss = lt_GetSecondBoss();
                        nOldBoss = lt_GetFirstBoss();
                        nPlotDungeon = -5;
                        lt_SetDungeonLevel(ID_LOCAL_SECOND_BOSS_CREATED);
                    } else if (nPlotPosition == ID_LOCAL_SECOND_BOSS_DEFEATED)
                    {
                        nBoss = lt_GetThirdBoss();
                        nOldBoss = lt_GetSecondBoss();
                        nPlotDungeon = -6;
                        lt_SetDungeonLevel(ID_LOCAL_THIRD_BOSS_CREATED);
                    }

                    if (nBoss == ID_LOCAL_BOSS_DEMON)
                    {
                        sThemeSetName = "HARAT";
                        SetLocalString(oDungeon, "sDungeonName", "Harat's Sanctum");
                    } else if (nBoss == ID_LOCAL_BOSS_BEHOLDER)
                    {
                        sThemeSetName = "GZHORB";
                        SetLocalString(oDungeon, "sDungeonName", "G'Zhorb's Pit");
                    } else if (nBoss == ID_LOCAL_BOSS_LICH)
                    {
                        sThemeSetName = "MASTERIUS";
                        SetLocalString(oDungeon, "sDungeonName", "Masterius' Crypt");
                    }
                    if (nPlotPosition == ID_LOCAL_THIRD_DUNGEON_COMPLETED)
                    {
                        if (nOldBoss == ID_LOCAL_LIEUTENANT_WEREBOAR)
                        {
                            DebugMessage("        Baccha was the previous boss.");
                            if (GetLocalInt(GetModule(), "bBacchaQuestActive") == TRUE)
                            {
                                DebugMessage("          Quest active.");
                                SetLocalInt(oDungeon, "nBossQuestLevel", 1); // lieutenant
                                SetLocalInt(oDungeon, "nBossQuestBoss", ID_LOCAL_LIEUTENANT_WEREBOAR); // baccha
                            }
                        } else if (nOldBoss == ID_LOCAL_LIEUTENANT_GIANTESS)
                        {
                            DebugMessage("        Hagatha was the previous boss.");
                            if (GetLocalInt(GetModule(), "bHagathaQuestActive") == TRUE)
                            {
                                DebugMessage("          Quest active.");
                                SetLocalInt(oDungeon, "nBossQuestLevel", 1); // lieutenant
                                SetLocalInt(oDungeon, "nBossQuestBoss", ID_LOCAL_LIEUTENANT_GIANTESS); // hagatha
                            }
                        } else if (nOldBoss == ID_LOCAL_LIEUTENANT_INSECT)
                        {
                            DebugMessage("        Maggris was the previous boss.");
                            if (GetLocalInt(GetModule(), "bMaggrisQuestActive") == TRUE)
                            {
                                DebugMessage("          Quest active.");
                                SetLocalInt(oDungeon, "nBossQuestLevel", 1); // lieutenant
                                SetLocalInt(oDungeon, "nBossQuestBoss", ID_LOCAL_LIEUTENANT_INSECT); // maggris
                            }
                        }
                    } else
                    {
                        if (nOldBoss == ID_LOCAL_BOSS_DEMON)
                        {
                            DebugMessage("        Harat was the previous boss.");
                            if (GetLocalInt(GetModule(), "bHaratQuestActive") == TRUE)
                            {
                                DebugMessage("          Quest active.");
                                SetLocalInt(oDungeon, "nBossQuestLevel", 2); // inner circle
                                SetLocalInt(oDungeon, "nBossQuestBoss", ID_LOCAL_BOSS_DEMON); // harat
                            }
                        } else if (nOldBoss == ID_LOCAL_BOSS_BEHOLDER)
                        {
                            DebugMessage("        Gzhorb was the previous boss.");
                            if (GetLocalInt(GetModule(), "bGzhorbQuestActive") == TRUE)
                            {
                                DebugMessage("          Quest active.");
                                SetLocalInt(oDungeon, "nBossQuestLevel", 2); // inner circle
                                SetLocalInt(oDungeon, "nBossQuestBoss", ID_LOCAL_BOSS_BEHOLDER); // gzhorb
                            }
                        } else if (nOldBoss == ID_LOCAL_BOSS_LICH)
                        {
                            DebugMessage("        Masterius was the previous boss.");
                            if (GetLocalInt(GetModule(), "bMasteriusQuestActive") == TRUE)
                            {
                                DebugMessage("          Quest active.");
                                SetLocalInt(oDungeon, "nBossQuestLevel", 2); // inner circle
                                SetLocalInt(oDungeon, "nBossQuestBoss", ID_LOCAL_BOSS_LICH); // masterius
                            }
                        }
                    }
                } else if (nPlotPosition == ID_LOCAL_THIRD_BOSS_DEFEATED) // if halaster
                {
                    sThemeSetName = "HALASTER";
                    SetLocalString(oDungeon, "sDungeonName", "Halaster's Domain");
                    nOldBoss = lt_GetThirdBoss();
                    nPlotDungeon = -7;

                    if (nOldBoss == ID_LOCAL_BOSS_DEMON)
                    {
                        DebugMessage("        Harat was the previous boss.");
                        if (GetLocalInt(GetModule(), "bHaratQuestActive") == TRUE)
                        {
                            DebugMessage("          Quest active.");
                            SetLocalInt(oDungeon, "nBossQuestLevel", 2); // inner circle
                            SetLocalInt(oDungeon, "nBossQuestBoss", ID_LOCAL_BOSS_DEMON); // harat
                        }
                    } else if (nOldBoss == ID_LOCAL_BOSS_BEHOLDER)
                    {
                        DebugMessage("        Gzhorb was the previous boss.");
                        if (GetLocalInt(GetModule(), "bGzhorbQuestActive") == TRUE)
                        {
                            DebugMessage("          Quest active.");
                            SetLocalInt(oDungeon, "nBossQuestLevel", 2); // inner circle
                            SetLocalInt(oDungeon, "nBossQuestBoss", ID_LOCAL_BOSS_BEHOLDER); // gzhorb
                        }
                    } else if (nOldBoss == ID_LOCAL_BOSS_LICH)
                    {
                        DebugMessage("        Masterius was the previous boss.");
                        if (GetLocalInt(GetModule(), "bMasteriusQuestActive") == TRUE)
                        {
                            DebugMessage("          Quest active.");
                            SetLocalInt(oDungeon, "nBossQuestLevel", 2); // inner circle
                            SetLocalInt(oDungeon, "nBossQuestBoss", ID_LOCAL_BOSS_LICH); // masterius
                        }
                    }
                }

                // set the dungeon number on the dungeon object
                SetLocalInt(GetModule(), "nDungeonNumber", nPlotDungeon);

//                SetLocalObject(GetModule(), "oDungeonNumber" + IntToString(nPlotDungeon), oDungeon);

                DebugMessage("        Dungeon Number: " + IntToString(nPlotDungeon));

                // set dungeon variables
                SetLocalInt(oDungeon, "nMaxLevel", 0);

                if (GetLocalInt(GetModule(), "bMiniPlot") == TRUE)
                {
                    SetLocalInt(oDungeon, "nDungeonDepth", 1);
                    SetLocalInt(oDungeon, "nMaxX", 1);
                    SetLocalInt(oDungeon, "nMaxY", 2);
                } else
                {
                    // specific plot dungeon geometry
                    if (nPlotDungeon == -7)
                    {
                        SetLocalInt(oDungeon, "nDungeonDepth", 5);
                        SetLocalInt(oDungeon, "nMaxX", 6);
                        SetLocalInt(oDungeon, "nMaxY", 6);
                    }
                    if ((nPlotDungeon == -6) || (nPlotDungeon == -5))
                    {
                        SetLocalInt(oDungeon, "nDungeonDepth", 4);
                        SetLocalInt(oDungeon, "nMaxX", 5);
                        SetLocalInt(oDungeon, "nMaxY", 5);
                    }
                    if ((nPlotDungeon == -4) || (nPlotDungeon == -3))
                    {
                        SetLocalInt(oDungeon, "nDungeonDepth", 3);
                        SetLocalInt(oDungeon, "nMaxX", 4);
                        SetLocalInt(oDungeon, "nMaxY", 4);
                    }
                    if ((nPlotDungeon == -2) || (nPlotDungeon == -1))
                    {
                        SetLocalInt(oDungeon, "nDungeonDepth", 2);
                        SetLocalInt(oDungeon, "nMaxX", 3);
                        SetLocalInt(oDungeon, "nMaxY", 3);
                    }
                }

                // the level for the boss plot
                int nPlotDepth = Random(GetLocalInt(oDungeon, "nDungeonDepth")) + 1;
                SetLocalInt(oDungeon, "nBossPlotDepth", nPlotDepth);

                // set dungeon theme
                int nThemeSet = GetLocalInt(GetModule(), "nThemeSet_" + sThemeSetName);

                DebugMessage("          Theme set chosen was " + sThemeSetName + " which is number " + IntToString(nThemeSet));

                SetLocalString(oDungeon, "sThemeSetName", sThemeSetName);

                // get the number of primary themes
                int nPrimaryThemeNum = GetLocalInt(GetModule(), "nThemeSet" + IntToString(nThemeSet) + "Primary");

                // if there is a primary theme in this theme set
                if (nPrimaryThemeNum > 0)
                {
                    DebugMessage("            There are " + IntToString(nPrimaryThemeNum) + " primary themes.");

                    // set the number of primary themes
                    SetLocalInt(oDungeon, "nPrimaryTheme", nPrimaryThemeNum);

                    // record each primary theme
                    int nCurrentPrimaryTheme = 1;
                    string sPrimaryThemeName;
                    int nPrimaryTheme;
                    while (nCurrentPrimaryTheme <= nPrimaryThemeNum)
                    {
                        // get theme name
                        nPrimaryTheme = GetLocalInt(GetModule(), "nThemeSet" + IntToString(nThemeSet) + "Primary" + IntToString(nCurrentPrimaryTheme));
                        sPrimaryThemeName = GetLocalString(GetModule(), "sTheme" + IntToString(nPrimaryTheme) + "Name");

                        // set theme on dungeon
                        SetLocalString(oDungeon, "sPrimaryTheme" + IntToString(nCurrentPrimaryTheme) + "Name", sPrimaryThemeName);

                        DebugMessage("              Setting primary theme " + IntToString(nCurrentPrimaryTheme) + " to " + sPrimaryThemeName);

                        // EDIT: add tilesets this theme brings
                        AddThemeTilesets(nPrimaryTheme, oDungeon);

                        nCurrentPrimaryTheme++;
                    }

                    // get the number of secondary themes
                    int nSecondaryThemeNum = GetLocalInt(GetModule(), "nThemeSet" + IntToString(nThemeSet) + "Secondary");

                    // if there is a secondary theme
                    if (nSecondaryThemeNum > 0)
                    {
                        DebugMessage("            There are " + IntToString(nSecondaryThemeNum) + " secondary themes.");

                        // set the number of primary themes
                        SetLocalInt(oDungeon, "nSecondaryTheme", nSecondaryThemeNum);

                        // record each primary theme
                        int nCurrentSecondaryTheme = 1;
                        string sSecondaryThemeName;
                        int nSecondaryTheme;
                        while (nCurrentSecondaryTheme <= nSecondaryThemeNum)
                        {
                            // get theme name
                            nSecondaryTheme = GetLocalInt(GetModule(), "nThemeSet" + IntToString(nThemeSet) + "Secondary" + IntToString(nCurrentSecondaryTheme));
                            sSecondaryThemeName = GetLocalString(GetModule(), "sTheme" + IntToString(nSecondaryTheme) + "Name");

                            // set theme on dungeon
                            SetLocalString(oDungeon, "sSecondaryTheme" + IntToString(nCurrentSecondaryTheme) + "Name", sSecondaryThemeName);

                            DebugMessage("              Setting secondary theme " + IntToString(nCurrentSecondaryTheme) + " to " + sSecondaryThemeName);

                            // EDIT: add tilesets this theme brings
                            AddThemeTilesets(nSecondaryTheme, oDungeon);

                            nCurrentSecondaryTheme++;
                        }
                    } else // there are no secondary themes
                    {
                        DebugMessage("            No secondary themes in this theme set.");

                        // there are no secondary themes
                        SetLocalInt(oDungeon, "nSecondaryTheme", 0);
                    }
                } else // there is no primary theme in this set
                {
                    DebugMessage("          No primary themes in this theme set. Setting to THEME_ALL.");

                    // set the only primary theme as THEME_ALL
                    SetLocalInt(oDungeon, "nPrimaryTheme", 1);
                    SetLocalString(oDungeon, "sPrimaryTheme1Name", "THEME_ALL");
                    SetLocalInt(oDungeon, "nSecondaryTheme", 0);

                    // EDIT: add all tilesets
                    int nTilesetNum = GetLocalInt(GetModule(), "nTileset");
                    int nTileset = 1;
                    while (nTileset <= nTilesetNum)
                    {
                        SetLocalInt(oDungeon, "bTileset" + IntToString(nTileset) + "Present", TRUE);
                        nTileset++;
                    }
                }


                // dungeon boss
                SetLocalInt(oDungeon, "bBossPresent", TRUE);

                string sBossArea = "BossArea_" + sThemeSetName;

                // if it is a valid area
                if (GetObjectByTag(sBossArea) != OBJECT_INVALID)
                {
                    DebugMessage("Specific themeset boss area " + sBossArea + " is valid.");

                    SetLocalInt(oDungeon, "bBossSpecific", TRUE);

                    SetLocalString(oDungeon, "sBossAreaResRef", sBossArea);
                } else
                {
                    DebugMessage("Specific themeset boss area " + sBossArea + " does not exist.");
                }

                // staircases
                SetDungeonStairs(oDungeon);

                // store the temporary PC
                SetLocalObject(GetModule(), "oTempPC", oPC);
                SetLocalObject(GetModule(), "oSpeaker", OBJECT_SELF);
                SetLocalObject(GetModule(), "oTempArea", OBJECT_INVALID);

                // EDIT: insert database rebuild
                DelayCommand(0.01, ExecuteScript("exe_id1_rebuild", GetObjectByTag("CPU1")));

                // generate the level
//                SetLocalInt(GetModule(), "nLevelProcess", 0);
//                DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetObjectByTag("CPU1")));
            }
        } else
        {
            SpeakString("You cannot use a level exit while a player is in combat.");

            // break out
            SetLocalInt(GetModule(), "bGenerating", FALSE);
            DebugMessage("Setting bGenerating in dungeon to FALSE");
        }
    } else
    {
        SpeakString("All party members must be close to the door to transport you to the next level.");

        // break out
        SetLocalInt(GetModule(), "bGenerating", FALSE);
        DebugMessage("Setting bGenerating in dungeon to FALSE");
    }
}

void SetDungeonTheme(object oDungeon)
{
    DebugMessage("        Setting dungeon theme.");

    // get dungeon theme flag
    int nThemeType = GetModuleFlag(ID1_FLAG_THEME_TYPE);
    int nThemeSelection = GetModuleFlag(ID1_FLAG_THEME_SELECTION);
    int nSelection = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);

    DebugMessage("          Theme type is " + IntToString(nThemeType) + " and selection is " + IntToString(nThemeSelection) + " with value " + IntToString(nSelection));

    // if a theme set
    if (nThemeType == ID1_THEME_TYPE_THEMESET)
    {
        DebugMessage("          Theme set chosen.");

        // if a specific theme set is chosen
        if (nThemeSelection == ID1_THEME_SELECTION_RANDOM)
        {
            int nThemeSetNum = GetLocalInt(GetModule(), "nThemeSet");
            int nSelection = Random(nThemeSetNum) + 1;
            DebugMessage("          Random theme set was " + IntToString(nSelection) + " out of " + IntToString(nThemeSetNum));
        } else
        {
            // if out of bounds, set as theme set all
            int nThemeSetNum = GetLocalInt(GetModule(), "nThemeSet");
            if ((nSelection < 1) || (nSelection > nThemeSetNum))
            {
                nSelection = 1;
            }
            DebugMessage("          Theme set selected was " + IntToString(nSelection) + " out of " + IntToString(nThemeSetNum));
        }

        // copy primary themes
        int nPrimaryNum = GetLocalInt(GetModule(), "nThemeSet" + IntToString(nSelection) + "Primary");
        SetLocalInt(oDungeon, "nPrimaryTheme", nPrimaryNum);
        int nTheme;
        string sTheme;
        int nPrimary = 1;
        while (nPrimary <= nPrimaryNum)
        {
            nTheme = GetLocalInt(GetModule(), "nThemeSet" + IntToString(nSelection) + "Primary" + IntToString(nPrimary));
            sTheme = GetLocalString(GetModule(), "sTheme" + IntToString(nTheme) + "Name");
            SetLocalString(oDungeon, "sPrimaryTheme" + IntToString(nPrimary) + "Name", sTheme);
            DebugMessage("          Setting primary theme " + IntToString(nPrimary) + " to " + sTheme);

            nPrimary++;
        }

        // copy secondary themes
        int nSecondaryNum = GetLocalInt(GetModule(), "nThemeSet" + IntToString(nSelection) + "Secondary");
        SetLocalInt(oDungeon, "nSecondaryTheme", nSecondaryNum);
        int nSecondary = 1;
        while (nSecondary <= nSecondaryNum)
        {
            nTheme = GetLocalInt(GetModule(), "nThemeSet" + IntToString(nSelection) + "Secondary" + IntToString(nSecondary));
            sTheme = GetLocalString(GetModule(), "sTheme" + IntToString(nTheme) + "Name");
            SetLocalString(oDungeon, "sSecondaryTheme" + IntToString(nSecondary) + "Name", sTheme);
            DebugMessage("          Setting secondary theme " + IntToString(nSecondary) + " to " + sTheme);

            nSecondary++;
        }
    } else // if a single theme
    {
        DebugMessage("          Single theme chosen.");

        // if a specific theme set is chosen
        if (nThemeSelection == ID1_THEME_SELECTION_RANDOM)
        {
            int nThemeNum = GetLocalInt(GetModule(), "nTheme");
            int nSelection = Random(nThemeNum) + 1;
            DebugMessage("          Random theme was " + IntToString(nSelection) + " out of " + IntToString(nThemeNum));
        } else
        {
            // if out of bounds, set as theme all
            int nThemeNum = GetLocalInt(GetModule(), "nTheme");
            if ((nSelection < 1) || (nSelection > nThemeNum))
            {
                nSelection = 1;
            }
            DebugMessage("          Theme selected was " + IntToString(nSelection) + " out of " + IntToString(nThemeNum));
        }

        // set primary theme
        SetLocalInt(oDungeon, "nPrimaryTheme", 1);
        string sTheme = GetLocalString(GetModule(), "sTheme" + IntToString(nSelection) + "Name");
        SetLocalString(oDungeon, "sPrimaryTheme1Name", sTheme);
        DebugMessage("          Set primary theme to " + sTheme);

        // set secondary theme
        SetLocalInt(oDungeon, "nSecondaryTheme", 0);
        DebugMessage("          No secondary theme.");
    }
}

void SetDungeonGeometry(object oDungeon)
{
    // set dungeon depth
    int nDungeonDepth = GetModuleFlagValue(ID1_FLAG_DUNGEON_DEPTH);
    if (nDungeonDepth < 1)
    {
        nDungeonDepth = 1;
    }

    // if the depth is fixed
    int nDepth;
    if (GetModuleFlag(ID1_FLAG_DUNGEON_DEPTH) == ID1_DUNGEON_DEPTH_FIXED)
    {
        nDepth = nDungeonDepth;
    } else // if the depth is random
    {
        nDepth = Random(nDungeonDepth) + 1;
    }
    SetLocalInt(oDungeon, "nDungeonDepth", nDepth);
    DebugMessage("Dungeon depth is " + IntToString(nDepth));


    // set maximum x coordinate
    int nMaxX = GetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_X);
    if (nMaxX < 1)
    {
        nMaxX = 1;
    } else if (nMaxX > 20)
    {
        nMaxX = 20;
    }
    SetLocalInt(oDungeon, "nMaxX", nMaxX);

    // set maximum y coordinate
    int nMaxY = GetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_Y);
    if (nMaxY < 2)
    {
        if (nMaxX < 2)
        {
            nMaxY = 2;
        } else
        {
            nMaxY = 1;
        }
    } else if (nMaxY > 20)
    {
        nMaxY = 20;
    }
    SetLocalInt(oDungeon, "nMaxY", nMaxY);
}

void SetDungeonBoss(object oDungeon)
{
    // if there is a boss in this dungeon
    if (GetModuleFlag(ID1_FLAG_BOSS_AREA_SELECTION) != ID1_BOSS_AREA_SELECTION_NONE)
    {
        DebugMessage("Boss area will be spawned.");

        // boss area will be spawned
        SetLocalInt(oDungeon, "bBossPresent", TRUE);

        // if themeset
        if (GetModuleFlag(ID1_FLAG_BOSS_AREA_SELECTION) == ID1_BOSS_AREA_SELECTION_THEMESET)
        {
            // if selected area has a themeset, set it
            string sThemeSet = GetLocalString(oDungeon, "sThemeSetName");
            DebugMessage("Themeset area BossArea_" + sThemeSet + " was chosen.");

            SetLocalString(oDungeon, "sBossAreaResRef", "BossArea_" + sThemeSet);
        }

        if (GetModuleFlag(ID1_FLAG_BOSS_AREA_SELECTION) == ID1_BOSS_AREA_SELECTION_FIXED_SPECIFIC)
        {
            // if selected area has a themeset, set it
            int nArea = GetModuleFlagValue(ID1_FLAG_BOSS_AREA_SELECTION);
            int nAreaNum = GetLocalInt(GetModule(), "sBossAreas" + IntToString(nArea));
            object oArea = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nAreaNum));
            string sArea = GetTag(oArea);
            DebugMessage("Specific boss area " + sArea + " was chosen.");

            SetLocalString(oDungeon, "sBossAreaResRef", sArea);
        }

        if (GetModuleFlag(ID1_FLAG_BOSS_AREA_SELECTION) == ID1_BOSS_AREA_SELECTION_FIXED_THEMESET)
        {
            // if selected area has a themeset, set it
            int nThemeSet = GetModuleFlagValue(ID1_FLAG_BOSS_AREA_SELECTION);
            string sThemeSet = GetLocalString(GetModule(), "sThemeSet" + IntToString(nThemeSet) + "Name");
            int nThemeSetNum = GetLocalInt(GetModule(), "nBossThemeSetArea_" + sThemeSet);
            object oThemeSet = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nThemeSetNum));
            string sThemeSetTag = GetTag(oThemeSet);
            DebugMessage("Specific themeset area " + sThemeSetTag + " was chosen.");

            SetLocalString(oDungeon, "sBossAreaResRef", sThemeSetTag);
        }
    }
}

void SetDungeonStairs(object oDungeon)
{
    if (GetModuleFlag(ID1_FLAG_STAIRS_NUMBER) == ID1_STAIRS_NUMBER_FIXED)
    {
        DebugMessage("Stair number fixed.");
        SetLocalInt(oDungeon, "bStairsFixed", TRUE);
    } else
    {
        DebugMessage("Stair number random.");
        SetLocalInt(oDungeon, "bStairsFixed", FALSE);
    }

    int nStairNum = GetModuleFlagValue(ID1_FLAG_STAIRS_NUMBER);

    DebugMessage("Number of stairs: " + IntToString(nStairNum));

    SetLocalInt(oDungeon, "nStairsMax", nStairNum);
}

void AddThemeTilesets(int nTheme, object oDungeon)
{
    // examine each tileset and set its variable to true on the dungeon if present
    DebugMessage("Adding tilesets for theme " + IntToString(nTheme));
    int nTilesetNum = GetLocalInt(GetModule(), "nTileset");
    int nTileset = 1;
    string sThemes;
    string sSubString;
    while (nTileset <= nTilesetNum)
    {
        sThemes = GetLocalString(GetModule(), "sTileset" + IntToString(nTileset) + "Themes");
        DebugMessage("  sTileset" + IntToString(nTileset) + "Themes is " + sThemes);
        sSubString = GetSubString(sThemes, nTheme - 1, 1);
        if (sSubString == "1")
        {
            SetLocalInt(oDungeon, "bTileset" + IntToString(nTileset) + "Present", TRUE);
            DebugMessage("    bTileset" + IntToString(nTileset) + "Present");
        }
        nTileset++;
    }
}

