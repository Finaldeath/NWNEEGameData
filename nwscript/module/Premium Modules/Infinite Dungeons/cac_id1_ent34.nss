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
            DebugMessage("      Creating custom dungeon.");

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
            location lLocation = GetLocation(GetObjectByTag("CPU"));
            object oDungeon = CreateObject(OBJECT_TYPE_ITEM, "dungeonobject", lLocation);
            SetLocalObject(GetModule(), "oCurrentDungeon", oDungeon);

            // set the dungeon number on the dungeon object
            int nDungeonNumber = 1;
            string sName = "Dungeon" + IntToString(nDungeonNumber);
            DebugMessage("        Examining " + sName);
            object oTempDungeon = RetrieveCampaignObject("ID_DATABASE", sName, lLocation);
            if (oTempDungeon == OBJECT_INVALID)
            {
                DebugMessage("        Dungeon does not exist.");
            } else
            {
                DebugMessage("        Dungeon exists already. Advancing.");
                nDungeonNumber++;
                DestroyObject(oTempDungeon);
            }

            while ((oTempDungeon != OBJECT_INVALID) && (nDungeonNumber < 100))
            {
                sName = "Dungeon" + IntToString(nDungeonNumber);
                DebugMessage("        Examining " + sName);
                oTempDungeon = RetrieveCampaignObject("ID_DATABASE", sName, lLocation);
                if (oTempDungeon == OBJECT_INVALID)
                {
                    DebugMessage("        Dungeon does not exist.");
                } else
                {
                    DebugMessage("        Dungeon exists already. Advancing.");
                    nDungeonNumber++;
                    DestroyObject(oTempDungeon);
                }
            }
            DebugMessage("        Dungeon Number: " + IntToString(nDungeonNumber));

            SetLocalInt(GetModule(), "nDungeonNumber", nDungeonNumber);
            SetLocalObject(GetModule(), "oCurrentDungeon", oDungeon);

            // create the dungeon name
            sName = "The ";
            int nMax = GetLocalInt(GetModule(), "nLinesDungeonAdjectiveNum");
            int nNum = Random(nMax) + 1;
            string sString = GetLocalString(GetModule(), "sLinesDungeonAdjective" + IntToString(nNum));
            sName += sString + " ";
            nMax = GetLocalInt(GetModule(), "nLinesDungeonSubjectNum");
            nNum = Random(nMax) + 1;
            sString = GetLocalString(GetModule(), "sLinesDungeonSubject" + IntToString(nNum));
            sName += sString + " of ";
            nMax = GetLocalInt(GetModule(), "nLinesDungeonObjectNum");
            nNum = Random(nMax) + 1;
            sString = GetLocalString(GetModule(), "sLinesDungeonObject" + IntToString(nNum));
            sName += sString;
            SetLocalString(oDungeon, "sDungeonName", sName);
            DebugMessage("        Dungeon is " + sName);

            // set dungeon variables
            SetLocalInt(oDungeon, "nMaxLevel", 0);

            // dungeon geometry
            SetDungeonGeometry(oDungeon);

            // dungeon theme
            SetDungeonTheme(oDungeon);

            // dungeon boss
            SetDungeonBoss(oDungeon);

            // staircases
            SetDungeonStairs(oDungeon);

            // store the temporary PC
            SetLocalObject(GetModule(), "oTempPC", oPC);
            SetLocalObject(GetModule(), "oSpeaker", OBJECT_SELF);
            SetLocalObject(GetModule(), "oTempArea", OBJECT_INVALID);
            SetLocalInt(GetModule(), "nPreviousDungeon", 0);

            // EDIT: insert database rebuild
            DelayCommand(0.01, ExecuteScript("exe_id1_rebuild", GetObjectByTag("CPU1")));

            // generate the level
//            SetLocalInt(GetModule(), "nLevelProcess", 0);
//            DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetObjectByTag("CPU1")));
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
            nSelection = Random(nThemeSetNum) + 1;
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
            string sThemeSetName = GetLocalString(GetModule(), "sThemeSet" + IntToString(nSelection) + "Name");
            SetLocalString(oDungeon, "sThemeSetName", sThemeSetName);
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

            // EDIT: add tilesets this theme brings
            AddThemeTilesets(nTheme, oDungeon);

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

            // EDIT: add tilesets this theme brings
            AddThemeTilesets(nTheme, oDungeon);

            nSecondary++;
        }
    } else // if a single theme
    {
        DebugMessage("          Single theme chosen.");

        // if a specific theme set is chosen
        if (nThemeSelection == ID1_THEME_SELECTION_RANDOM)
        {
            int nThemeNum = GetLocalInt(GetModule(), "nTheme");
            nSelection = Random(nThemeNum) + 1;
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

        // EDIT: add tilesets this theme brings
        AddThemeTilesets(nSelection, oDungeon);

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
            DebugMessage("Themeset name is " + sThemeSet);
            if (sThemeSet != "")
            {
                DebugMessage("Themeset area BossArea_" + sThemeSet + " was chosen.");
                SetLocalString(oDungeon, "sBossAreaResRef", "BossArea_" + sThemeSet);
            }
        }

        if (GetModuleFlag(ID1_FLAG_BOSS_AREA_SELECTION) == ID1_BOSS_AREA_SELECTION_FIXED_SPECIFIC)
        {
            // if selected area has a themeset, set it
            int nArea = GetModuleFlagValue(ID1_FLAG_BOSS_AREA_SELECTION);
            int nAreaNum = GetLocalInt(GetModule(), "nBossAreas" + IntToString(nArea));
            object oArea = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nAreaNum));
            string sArea = GetTag(oArea);
            DebugMessage("Specific boss area " + sArea + " was chosen.");

            SetLocalString(oDungeon, "sBossAreaResRef", sArea);
        }

        if (GetModuleFlag(ID1_FLAG_BOSS_AREA_SELECTION) == ID1_BOSS_AREA_SELECTION_FIXED_THEMESET)
        {
            // if selected area has a themeset, set it
            int nThemeSet = GetModuleFlagValue(ID1_FLAG_BOSS_AREA_SELECTION);
            int nTemp = GetLocalInt(GetModule(), "nBossThemeSetAreas" + IntToString(nThemeSet));
            object oTemp = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nTemp));
            string sThemeSetTag = GetTag(oTemp);

/*            int nThemeSet = GetModuleFlagValue(ID1_FLAG_BOSS_AREA_SELECTION);
            string sThemeSet = GetLocalString(GetModule(), "sThemeSet" + IntToString(nThemeSet) + "Name");
            int nThemeSetNum = GetLocalInt(GetModule(), "nBossThemeSetArea_" + sThemeSet);
            object oThemeSet = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nThemeSetNum));
            string sThemeSetTag = GetTag(oThemeSet);*/

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

