#include "inc_id1_score"
#include "inc_id_liltimmy"
#include "inc_id1_utility"

void main()
{
    DebugMessage("");

    int bGenerating = GetLocalInt(GetModule(), "bGenerating");
    if (bGenerating == FALSE)
    {
        SetLocalInt(GetModule(), "bGenerating", TRUE);

        // get the player who clicked the portal
        object oPC = GetLastUsedBy();
        if (GetCutsceneMode(oPC) == FALSE)
        {
            DebugMessage("Cutscene mode set on PC.");
            SetCutsceneMode(oPC, TRUE);
        } else
        {
            DebugMessage("Cutscene mode already set on PC.");
        }

        // find which boss this is
        string sTelTag = GetTag(OBJECT_SELF);
        DebugMessage("Teleporter tag is " + sTelTag);

        // get the tag of that boss' lair and which dungeon it is
        string sBossTag;
        int nBossDungeon = 0;
        if (sTelTag == "id1_bactel")
        {
            sBossTag = "BACCHA";
            if (lt_GetFirstLieutenant() == ID_LOCAL_LIEUTENANT_WEREBOAR)
            {
                nBossDungeon = -1;
            }
            if (lt_GetSecondLieutenant() == ID_LOCAL_LIEUTENANT_WEREBOAR)
            {
                nBossDungeon = -2;
            }
            if (lt_GetThirdLieutenant() == ID_LOCAL_LIEUTENANT_WEREBOAR)
            {
                nBossDungeon = -3;
            }
        } else if (sTelTag == "id1_hagtel")
        {
            sBossTag = "HAGATHA";
            if (lt_GetFirstLieutenant() == ID_LOCAL_LIEUTENANT_GIANTESS)
            {
                nBossDungeon = -1;
            }
            if (lt_GetSecondLieutenant() == ID_LOCAL_LIEUTENANT_GIANTESS)
            {
                nBossDungeon = -2;
            }
            if (lt_GetThirdLieutenant() == ID_LOCAL_LIEUTENANT_GIANTESS)
            {
                nBossDungeon = -3;
            }
        } else if (sTelTag == "id1_magtel")
        {
            sBossTag = "MAGGRIS";
            if (lt_GetFirstLieutenant() == ID_LOCAL_LIEUTENANT_INSECT)
            {
                nBossDungeon = -1;
            }
            if (lt_GetSecondLieutenant() == ID_LOCAL_LIEUTENANT_INSECT)
            {
                nBossDungeon = -2;
            }
            if (lt_GetThirdLieutenant() == ID_LOCAL_LIEUTENANT_INSECT)
            {
                nBossDungeon = -3;
            }
        } else if (sTelTag == "id1_hartel")
        {
            sBossTag = "HARAT";
            if (lt_GetFirstBoss() == ID_LOCAL_BOSS_DEMON)
            {
                nBossDungeon = -4;
            }
            if (lt_GetSecondBoss() == ID_LOCAL_BOSS_DEMON)
            {
                nBossDungeon = -5;
            }
            if (lt_GetThirdBoss() == ID_LOCAL_BOSS_DEMON)
            {
                nBossDungeon = -6;
            }
        } else if (sTelTag == "id1_gzbtel")
        {
            sBossTag = "GZHORB";
            if (lt_GetFirstBoss() == ID_LOCAL_BOSS_BEHOLDER)
            {
                nBossDungeon = -4;
            }
            if (lt_GetSecondBoss() == ID_LOCAL_BOSS_BEHOLDER)
            {
                nBossDungeon = -5;
            }
            if (lt_GetThirdBoss() == ID_LOCAL_BOSS_BEHOLDER)
            {
                nBossDungeon = -6;
            }
        } else if (sTelTag == "id1_mastel")
        {
            sBossTag = "MASTERIUS";
            if (lt_GetFirstBoss() == ID_LOCAL_BOSS_LICH)
            {
                nBossDungeon = -4;
            }
            if (lt_GetSecondBoss() == ID_LOCAL_BOSS_LICH)
            {
                nBossDungeon = -5;
            }
            if (lt_GetThirdBoss() == ID_LOCAL_BOSS_LICH)
            {
                nBossDungeon = -6;
            }
        } else if (sTelTag == "id1_haltel")
        {
            sBossTag = "HALASTER";
            nBossDungeon = -7;
        }
        DebugMessage("Boss tag is BossArea_" + sBossTag);
        DebugMessage("nBossDungeon is " + IntToString(nBossDungeon));

        // if a boss dungeon exists for this
        if (nBossDungeon < 0)
        {
            // check to see if a dungeon is active
            object oDungeon = GetCurrentDungeon();
            int nCurrentDungeon = GetLocalInt(GetModule(), "nDungeonNumber");
            DebugMessage("  Current Dungeon: " + IntToString(nCurrentDungeon));

            // is this the correct dungeon
            if ((nCurrentDungeon == 0) || (nCurrentDungeon == nBossDungeon))
            {
                // if no dungeon selected
                if (nCurrentDungeon == 0)
                {
                    // save the previous dungeon number
                    SetLocalInt(GetModule(), "nPreviousDungeon", 0);

                    // retrieve the boss dungeon
                    string sName = "Dungeon" + IntToString(nBossDungeon);
                    location lLocation = GetLocation(GetObjectByTag("CPU"));
                    object oDungeon = RetrieveCampaignObject("ID_DATABASE", sName, lLocation);
                    if (oDungeon == OBJECT_INVALID)
                    {
                        DebugMessage("    Could not retrieve dungeon.");
                    } else
                    {
                        DebugMessage("    " + sName + " was retrieved.");
                    }

                    // set the current dungeon to the boss lair
                    SetLocalInt(GetModule(), "nDungeonNumber", nBossDungeon);
                    SetLocalObject(GetModule(), "oCurrentDungeon", oDungeon);
                    DebugMessage("        Dungeon Number: " + IntToString(nBossDungeon));

                    object oBossArea = GetObjectByTag("BossArea_" + sBossTag);
                    DebugMessage("        Retrieved area " + GetTag(oBossArea));
                    object oFirstObject = GetFirstObjectInArea(oBossArea);
                    DebugMessage("        First object " + GetTag(oFirstObject));
                    object oTeleporter = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER", oFirstObject);
                    DebugMessage("        Teleporter object " + GetTag(oTeleporter));

                    // set temporary destination details
                    SetLocalInt(GetModule(), "nTempPreviousLevel", 0);

                    SetLocalObject(GetModule(), "oTempPC", oPC);
                    SetLocalObject(GetModule(), "oTempDestinationDoor", oTeleporter);
                    SetLocalObject(GetModule(), "oTempDungeon", oDungeon);
                    SetLocalInt(GetModule(), "bTempLevelGen", FALSE);

                    // set the respawn point as the boss teleporter
                    SetLocalObject(oPC, "ptr_id1_door", oTeleporter);

                    // set the level to transit to
                    int nBossLevel = GetLocalInt(oDungeon, "nDungeonDepth");
                    DebugMessage("Set nCurrentLevel to " + IntToString(nBossLevel) + ". Point 9.");
                    SetLocalInt(GetModule(), "nCurrentLevel", nBossLevel);

                    // set starting coordinates
                    SetLocalInt(GetModule(), "nCurrentX", 1);
                    SetLocalInt(GetModule(), "nCurrentY", 1);

                    // run activation script
                    SetLocalInt(GetModule(), "nActivationProcess", 0);
                    DelayCommand(0.01, ExecuteScript("exe_id1_active", GetObjectByTag("CPU1")));
                } else  // if it is the current dungeon
                {
                    // check to see if the boss level is active
                    object oDungeon = GetCurrentDungeon();
                    int nDungeonDepth = GetLocalInt(oDungeon, "nDungeonDepth");
                    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
                    DebugMessage("  Dungeon Depth " + IntToString(nDungeonDepth) + ", Current Level " + IntToString(nCurrentLevel));

                    // if the boss level is the one active
                    if ((nDungeonDepth == nCurrentLevel) || (nCurrentLevel == 0))
                    {
                        object oDungeon = GetCurrentDungeon();
                        object oBossArea = GetObjectByTag("BossArea_" + sBossTag);
                        DebugMessage("        Retrieved area " + GetTag(oBossArea));
                        object oFirstObject = GetFirstObjectInArea(oBossArea);
                        DebugMessage("        First object " + GetTag(oFirstObject));
                        object oTeleporter = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER", oFirstObject);
                        DebugMessage("        Teleporter object " + GetTag(oTeleporter));

                        // set temporary destination details
                        SetLocalInt(GetModule(), "nTempPreviousLevel", 0);

                        SetLocalObject(GetModule(), "oTempPC", oPC);
                        SetLocalObject(GetModule(), "oTempDestinationDoor", oTeleporter);
                        SetLocalObject(GetModule(), "oTempDungeon", oDungeon);
                        SetLocalInt(GetModule(), "bTempLevelGen", FALSE);

                        // set the respawn point as the boss teleporter
                        SetLocalObject(oPC, "ptr_id1_door", oTeleporter);

                        if (nCurrentLevel == 0)
                        {
                            // set the level to transit to
                            int nBossLevel = GetLocalInt(oDungeon, "nDungeonDepth");
                            DebugMessage("Set nCurrentLevel to " + IntToString(nBossLevel) + ". Point 10.");
                            SetLocalInt(GetModule(), "nCurrentLevel", nBossLevel);
                        }

                        // set starting coordinates
                        SetLocalInt(GetModule(), "nCurrentX", 1);
                        SetLocalInt(GetModule(), "nCurrentY", 1);

                        // run activation script
                        SetLocalInt(GetModule(), "nActivationProcess", 0);
                        DelayCommand(0.01, ExecuteScript("exe_id1_active", GetObjectByTag("CPU1")));
                    } else // if a different level of the dungeon is active
                    {
                        SpeakString("Another level of that dungeon is active already.");
                        SetLocalInt(GetModule(), "bGenerating", FALSE);
                        if (GetCutsceneMode(oPC) == TRUE)
                        {
                            SetCutsceneMode(oPC, FALSE);
                        }
                    }
                }
            } else // a different dungeon is active
            {
                // check to make sure every player is in the dungeon entrance
                int bInDungeon = FALSE;
                object oPlayer = GetFirstPC();
                object oArea;
                string sAreaTag;
                while ((oPlayer != OBJECT_INVALID) && (bInDungeon == FALSE))
                {
                    DebugMessage("  Checking player " + GetPCIdentifier(oPlayer));

                    oArea = GetArea(oPlayer);
                    sAreaTag = GetTag(oArea);
                    DebugMessage("    Area tag is " + sAreaTag);
                    if (sAreaTag == "DungeonEntrance")
                    {
                        DebugMessage("    Player is not in dungeon.");
                    } else
                    {
                        DebugMessage("    Player is in dungeon.");
                        bInDungeon = TRUE;
                    }

                    // check next player
                    oPlayer = GetNextPC();
                }

                // if no one was in the dungeon
                if (bInDungeon == FALSE)
                {
                    // save the current dungeon
                    int nDungeonNumber = GetLocalInt(GetModule(), "nDungeonNumber");
                    if (nDungeonNumber != 0)
                    {
                        string sName = "Dungeon" + IntToString(nDungeonNumber);
                        int bSuccess = StoreCampaignObject("ID_DATABASE", sName, oDungeon);
                        DebugMessage("Success of storing of " + sName + " is " + IntToString(bSuccess));
                    }
                    DestroyObject(oDungeon);

                    // record that this was the previous dungeon
                    SetLocalInt(GetModule(), "nPreviousDungeon", nDungeonNumber);

                    // retrieve the boss dungeon
                    string sName = "Dungeon" + IntToString(nBossDungeon);
                    location lLocation = GetLocation(GetObjectByTag("CPU"));
                    object oDungeon = RetrieveCampaignObject("ID_DATABASE", sName, lLocation);
                    if (oDungeon == OBJECT_INVALID)
                    {
                        DebugMessage("    Could not retrieve dungeon.");
                    } else
                    {
                        DebugMessage("    " + sName + " was retrieved.");
                    }

                    // set the current dungeon to the boss lair
                    SetLocalInt(GetModule(), "nDungeonNumber", nBossDungeon);
                    SetLocalObject(GetModule(), "oCurrentDungeon", oDungeon);
                    DebugMessage("        Dungeon Number: " + IntToString(nBossDungeon));

                    object oBossArea = GetObjectByTag("BossArea_" + sBossTag);
                    DebugMessage("        Retrieved area " + GetTag(oBossArea));
                    object oFirstObject = GetFirstObjectInArea(oBossArea);
                    DebugMessage("        First object " + GetTag(oFirstObject));
                    object oTeleporter = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER", oFirstObject);
                    DebugMessage("        Teleporter object " + GetTag(oTeleporter));

                    // set temporary destination details
                    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
                    SetLocalInt(GetModule(), "nTempPreviousLevel", nCurrentLevel);
                    DebugMessage("Previous level was " + IntToString(nCurrentLevel));

                    SetLocalObject(GetModule(), "oTempPC", oPC);
                    SetLocalObject(GetModule(), "oTempDestinationDoor", oTeleporter);
                    SetLocalObject(GetModule(), "oTempDungeon", oDungeon);
                    SetLocalInt(GetModule(), "bTempLevelGen", FALSE);

                    // set the respawn point as the boss teleporter
                    SetLocalObject(oPC, "ptr_id1_door", oTeleporter);

                    // set the level to transit to
                    int nBossLevel = GetLocalInt(oDungeon, "nDungeonDepth");
                    DebugMessage("Set nCurrentLevel to " + IntToString(nBossLevel) + ". Point 11.");
                    SetLocalInt(GetModule(), "nCurrentLevel", nBossLevel);

                    // set starting coordinates
                    SetLocalInt(GetModule(), "nCurrentX", 1);
                    SetLocalInt(GetModule(), "nCurrentY", 1);

                    // run activation script
                    SetLocalInt(GetModule(), "nActivationProcess", 0);
                    DelayCommand(0.01, ExecuteScript("exe_id1_active", GetObjectByTag("CPU1")));
                } else // if someone was in the dungeon
                {
                    SpeakString("A player is on another level of an active dungeon. Exit the dungeon to use the teleporter.");
                    SetLocalInt(GetModule(), "bGenerating", FALSE);
                    if (GetCutsceneMode(oPC) == TRUE)
                    {
                        SetCutsceneMode(oPC, FALSE);
                    }
                }
            }
        }
    }
}
