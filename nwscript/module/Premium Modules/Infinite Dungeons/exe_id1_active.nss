#include "inc_id1_debug"
#include "inc_id1_treasure"
#include "inc_id1_clean"
#include "inc_id1_flags"
#include "inc_id1_utility"
#include "inc_id1_score"
#include "inc_id_liltimmy"
#include "inc_id1_gen"


void main()
{
    object oPC = GetLocalObject(GetModule(), "oTempPC");
    object oDestinationDoor = GetLocalObject(GetModule(), "oTempDestinationDoor");
    object oDungeon = GetLocalObject(GetModule(), "oTempDungeon");

    // get level generation flag
    int bTempLevelGen = GetLocalInt(GetModule(), "bTempLevelGen");

    DebugMessage("");
    DebugMessage("Transporting player.");

    // if destination is not activated, activate
    object oArea = GetArea(oDestinationDoor);
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");

    if (oDungeon == OBJECT_INVALID)
    {
        oDungeon = GetCurrentDungeon();
    }

    if (oPC == OBJECT_INVALID)
    {
        DebugMessage("Player does not exist.");
    }

    if (oDestinationDoor == OBJECT_INVALID)
    {
        DebugMessage("Destination door passed does not exist.");

        SetLocalInt(GetModule(), "bGenerating", FALSE);
        DebugMessage("Setting bGenerating in active to FALSE");
    } else
    {
        int nDestinationIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
        int nDestination = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nDestinationIdentifier) + "Area");
        int bActivated = GetLocalInt(oDungeon, "bArea" + IntToString(nDestination) + "Level" + IntToString(nCurrentLevel) + "Activated");

        // check to see if doors or stairs
        string sTag = GetTag(OBJECT_SELF);

        if (GetTag(oDestinationDoor) == "ID1_STATIC_DOOR")
        {
            DebugMessage("  This function was called by a door.");

            // create list to transport of just the player
            SetLocalInt(GetModule(), "bTransportAll", FALSE);
        } else
        {
            DebugMessage("  This function was called by a staircase.");

            // create list of people to be transported
            SetLocalInt(GetModule(), "bTransportAll", TRUE);
        }

        if ((bActivated == FALSE) && (GetTag(oArea) != "DungeonEntrance"))
        {
            // if the area has not been generated yet on this level
            if (GetLocalInt(oDungeon, "bArea" + IntToString(nDestination) + "Level" + IntToString(nCurrentLevel) + "Generated") == FALSE)
            {
                // set as having been generated
                DebugMessage("  Area has not been generated. Generating.");
                SetLocalInt(oDungeon, "bArea" + IntToString(nDestination) + "Level" + IntToString(nCurrentLevel) + "Generated", TRUE);

                // set area generation flag
                SetLocalInt(GetModule(), "bTempAreaGen", TRUE);

                // Update - Oct 8, 2005 Grant: Award area exploration points to the player.
                // Track areas explored and maximum depth acheived.
//                AwardAreaDiscoveredPoints(oPC);
            } else
            {
                // set area generation flag
                SetLocalInt(GetModule(), "bTempAreaGen", FALSE);
            }

            // activate
            DebugMessage("  Area has not been activated. Activating.");
            SetLocalInt(oDungeon, "bArea" + IntToString(nDestination) + "Level" + IntToString(nCurrentLevel) + "Activated", TRUE);

            // spawn everything in
            DebugMessage("CPU tag is " + GetTag(OBJECT_SELF) + " and next is " + GetTag(GetNextCPU()));
            SetLocalInt(GetModule(), "nQueueMin", 1);
            DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));
        } else
        {
            DebugMessage("  Area has already been activated.");

            // make the dungeon accessible
            SetLocalInt(GetModule(), "bGenerating", FALSE);
            DebugMessage("Setting bGenerating in activation to FALSE");

            // main plot variables
            int bBacchaQuest = GetLocalInt(GetModule(), "bBacchaQuestActive");
            int bBacchaQuestCompleted = GetLocalInt(GetModule(), "bBacchaQuestCompleted");
            int bBacchaQuestItem = FALSE;
            int bBacchaDead = GetLocalInt(GetModule(), "bBacchaDead");
            int bHagathaQuest = GetLocalInt(GetModule(), "bHagathaQuestActive");
            int bHagathaQuestCompleted = GetLocalInt(GetModule(), "bHagathaQuestCompleted");
            int bHagathaQuestItem = FALSE;
            int bHagathaDead = GetLocalInt(GetModule(), "bHagathaDead");
            int bMaggrisQuest = GetLocalInt(GetModule(), "bMaggrisQuestActive");
            int bMaggrisQuestCompleted = GetLocalInt(GetModule(), "bMaggrisQuestCompleted");
            int bMaggrisQuestItem = FALSE;
            int bMaggrisDead = GetLocalInt(GetModule(), "bMaggrisDead");
            int bHaratQuest = GetLocalInt(GetModule(), "bHaratQuestActive");
            int bHaratQuestCompleted = GetLocalInt(GetModule(), "bHaratQuestCompleted");
            int bHaratQuestItem = FALSE;
            int bHaratDead = GetLocalInt(GetModule(), "bHaratDead");
            int bGzhorbQuest = GetLocalInt(GetModule(), "bGzhorbQuestActive");
            int bGzhorbQuestCompleted = GetLocalInt(GetModule(), "bGzhorbQuestCompleted");
            int bGzhorbQuestItem = FALSE;
            int bGzhorbDead = GetLocalInt(GetModule(), "bGzhorbDead");
            int bMasteriusQuest = GetLocalInt(GetModule(), "bMasteriusQuestActive");
            int bMasteriusQuestCompleted = GetLocalInt(GetModule(), "bMasteriusQuestCompleted");
            int bMasteriusQuestItem = FALSE;
            int bMasteriusDead = GetLocalInt(GetModule(), "bMasteriusDead");

            // destination items
            int bBacchaFindItem = FALSE;
            int bBacchaItemFound = GetLocalInt(GetModule(), "bBacchaQuestItemFound");
            int bHagathaFindItem = FALSE;
            int bHagathaItemFound = GetLocalInt(GetModule(), "bHagathaQuestItemFound");
            int bMaggrisFindItem = FALSE;
            int bMaggrisItemFound = GetLocalInt(GetModule(), "bMaggrisQuestItemFound");
            int bHaratFindItem = FALSE;
            int bHaratItemFound = GetLocalInt(GetModule(), "bHaratQuestItemFound");
            int bGzhorbFindItem = FALSE;
            int bGzhorbItemFound = GetLocalInt(GetModule(), "bGzhorbQuestItemFound");
            int bMasteriusFindItem = FALSE;
            int bMasteriusItemFound = GetLocalInt(GetModule(), "bMasteriusQuestItemFound");

            object oDestinationDoor2 = oDestinationDoor;

            // for each player
            object oPlayer;
            if (GetLocalInt(GetModule(), "bTransportAll") == TRUE)
            {
                oPlayer = GetFirstPC();
            } else
            {
                oPlayer = oPC;
            }
            while (oPlayer != OBJECT_INVALID)
            {
                DebugMessage("Removing cutscene mode from player " + GetName(oPlayer));

                // bring out of in cutscene mode
                if (GetCutsceneMode(oPlayer) == TRUE)
                {
                    SetCutsceneMode(oPlayer, FALSE);
                }

                // clean up this player's map
//                CleanMap(oPlayer);

                // explore destination
                object oArea = GetArea(oDestinationDoor2);
                int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
                int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");
                int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
                string sPlayer = GetPCIdentifier(oPlayer);
                string sLevel = "Area" + IntToString(nAreaNum) + "Level" + IntToString(nCurrentLevel);
                SetExploredState(oPlayer, "", nAreaNum, nCurrentLevel, 1, oDungeon);
//                DebugMessage("  Setting nPlayer_" + sPlayer + "_"+ sLevel + "Explored");
//                SetLocalInt(oDungeon, "nPlayer_" + sPlayer + "_" + sLevel + "Explored", 1);

                // reset commoner faction
                SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 100, oPC);

                // check conditions to see if this should be a cutscene
                if (GetTag(oArea) == "DungeonEntrance")
                {
                    int nMainPlot = lt_GetDungeonLevel();
                    int nTriggerPlot = GetLocalInt(GetModule(), "nTriggerPlot");
                    if ((nMainPlot == ID_LOCAL_FIRST_DUNGEON_COMPLETED) && (nTriggerPlot == 1)) // first lieutenant done
                    {
                        object oNarratorArea = GetObjectByTag("NarratorArea");
                        SetLocalInt(oNarratorArea, "NarratorCutsceneNumber", 2);
                        SetLocalObject(oNarratorArea, "TeleportWP", oDestinationDoor2);
                        oDestinationDoor = GetObjectByTag("ID1_STATIC_NARRATOR_START");
                    } else if ((nMainPlot == ID_LOCAL_THIRD_DUNGEON_COMPLETED) && (nTriggerPlot == 2)) // all lieutenants done
                    {
                        object oNarratorArea = GetObjectByTag("NarratorArea");
                        SetLocalInt(oNarratorArea, "NarratorCutsceneNumber", 3);
                        SetLocalObject(oNarratorArea, "TeleportWP", oDestinationDoor2);
                        oDestinationDoor = GetObjectByTag("ID1_STATIC_NARRATOR_START");
                    } else if ((nMainPlot == ID_LOCAL_THIRD_BOSS_DEFEATED) && (nTriggerPlot == 3)) // all inner circle done
                    {
                        object oNarratorArea = GetObjectByTag("NarratorArea");
                        SetLocalInt(oNarratorArea, "NarratorCutsceneNumber", 4);
                        SetLocalObject(oNarratorArea, "TeleportWP", oDestinationDoor2);
                        oDestinationDoor = GetObjectByTag("ID1_STATIC_NARRATOR_START");
                    } else if ((nMainPlot == ID_LOCAL_HALASTER_TIMMY) && (nTriggerPlot == 4)) // halaster done
                    {
                        object oNarratorArea = GetObjectByTag("NarratorArea");
                        SetLocalInt(oNarratorArea, "NarratorCutsceneNumber", 5);
                        SetLocalObject(oNarratorArea, "TeleportWP", oDestinationDoor2);
                        oDestinationDoor = GetObjectByTag("ID1_STATIC_NARRATOR_START");
                    }
                }

                // set the respawn point as the dungeon stairs
                SetLocalObject(oPlayer, "ptr_id1_door", oDestinationDoor);

                // warp the player
                DebugMessage("Clearing actions. Point X2.");
                DelayCommand(0.01, AssignCommand(oPlayer, ClearAllActions()));
                DelayCommand(0.02, AssignCommand(oPlayer, JumpToObject(oDestinationDoor)));
                DelayCommand(0.03, AssignCommand(oDestinationDoor, ActionOpenDoor(oDestinationDoor)));
                ExploreAreaForPlayer(GetArea(oDestinationDoor), oPlayer, FALSE);

                // setting plot to false to be safe
                if (GetPlotFlag(oPC) == TRUE)
                {
                    DebugMessage("Plot flag was set on player.");
                }
                SetPlotFlag(oPC, FALSE);

                // create microprocess searching area entering plots
                object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU42");
                SetLocalInt(oMicroCPU, "nAreaNum", nAreaNum);
                SetLocalObject(oMicroCPU, "oArea", oArea);
                DelayCommand(0.01, ExecuteScript("exe_id1_micplot4", oMicroCPU));

                // cycle to next player
                if (GetLocalInt(GetModule(), "bTransportAll") == TRUE)
                {
                    // if this is a level transition, check to see if anyone has needed plot items
                    if ((bBacchaQuest == TRUE) && (bBacchaQuestCompleted == FALSE))
                    {
                        DebugMessage("Baccha's quest is active.");
                        if (GetItemPossessedBy(oPlayer, "itm_id1_anttot_dormant") != OBJECT_INVALID)
                        {
                            DebugMessage("  Baccha's item is present.");
                            bBacchaQuestItem = TRUE;
                        }
                        if (GetItemPossessedBy(oPlayer, "id1_bossplot_ant") != OBJECT_INVALID)
                        {
                            DebugMessage("  Baccha's find item is present.");
                            bBacchaFindItem = TRUE;
                        }
                    }
                    if ((bHagathaQuest == TRUE) && (bHagathaQuestCompleted == FALSE))
                    {
                        DebugMessage("Hagatha's quest is active.");
                        if (GetItemPossessedBy(oPlayer, "itm_id1_widhair_dormant") != OBJECT_INVALID)
                        {
                            DebugMessage("  Hagatha's item is present.");
                            bHagathaQuestItem = TRUE;
                        }
                        if (GetItemPossessedBy(oPlayer, "id1_bossplot_hag") != OBJECT_INVALID)
                        {
                            DebugMessage("  Hagatha's find item is present.");
                            bHagathaFindItem = TRUE;
                        }
                    }
                    if ((bMaggrisQuest == TRUE) && (bMaggrisQuestCompleted == FALSE))
                    {
                        DebugMessage("Maggris' quest is active.");
                        if (GetItemPossessedBy(oPlayer, "itm_id1_maggegg_dormant") != OBJECT_INVALID)
                        {
                            DebugMessage("  Maggris' item is present.");
                            bMaggrisQuestItem = TRUE;
                        }
                        if (GetItemPossessedBy(oPlayer, "id1_bossplot_mag") != OBJECT_INVALID)
                        {
                            DebugMessage("  Maggris' find item is present.");
                            bMaggrisFindItem = TRUE;
                        }
                    }
                    if ((bHaratQuest == TRUE) && (bHaratQuestCompleted == FALSE))
                    {
                        DebugMessage("Harat's quest is active.");
                        if (GetItemPossessedBy(oPlayer, "itm_id1_harattg_dormant") != OBJECT_INVALID)
                        {
                            DebugMessage("  Harat's item is present.");
                            bHaratQuestItem = TRUE;
                        }
                        if (GetItemPossessedBy(oPlayer, "id1_bossplot_har1") != OBJECT_INVALID)
                        {
                            DebugMessage("  Harat's first find item is present.");
                            bHaratFindItem = TRUE;
                        } else
                        {
                            if (GetItemPossessedBy(oPlayer, "id1_bossplot_har2") != OBJECT_INVALID)
                            {
                                DebugMessage("  Harat's second find item is present.");
                                bHaratFindItem = TRUE;
                            }
                        }
                    }
                    if ((bGzhorbQuest == TRUE) && (bGzhorbQuestCompleted == FALSE))
                    {
                        DebugMessage("Gzhorb's quest is active.");
                        if (GetItemPossessedBy(oPlayer, "itm_id1_gzrbeye_dormant") != OBJECT_INVALID)
                        {
                            DebugMessage("  Gzhorb's item is present.");
                            bGzhorbQuestItem = TRUE;
                        }
                        if (GetItemPossessedBy(oPlayer, "id1_bossplot_gzb") != OBJECT_INVALID)
                        {
                            DebugMessage("  Gzhorb's find item is present.");
                            bGzhorbFindItem = TRUE;
                        }
                    }
                    if ((bMasteriusQuest == TRUE) && (bMasteriusQuestCompleted == FALSE))
                    {
                        DebugMessage("Masterius' quest is active.");
                        if (GetItemPossessedBy(oPlayer, "itm_id1_masbone_dormant") != OBJECT_INVALID)
                        {
                            DebugMessage("  Masterius' item is present.");
                            bMasteriusQuestItem = TRUE;
                        }
                        if (GetItemPossessedBy(oPlayer, "id1_bossplot_mas") != OBJECT_INVALID)
                        {
                            DebugMessage("  Masterius' find item is present.");
                            bMasteriusFindItem = TRUE;
                        }
                    }

                    // reset NPC factions
//                    SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 100, oPlayer);
//                    SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 100, oPlayer);
//                    SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 100, oPlayer);
//                    SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 0, oPlayer);

                    // cycle to next player
                    oPlayer = GetNextPC();
                } else
                {
                    oPlayer = OBJECT_INVALID;
                }
            }

            // reset little timmy's faction
//            ChangeFaction(GetObjectByTag("id1_littletimmy"), GetObjectByTag("DungeonAngel"));

            if (GetLocalInt(GetModule(), "bTransportAll") == TRUE)
            {
                SendMessageToPC(oPlayer, "Entering level " + IntToString(nCurrentLevel) + " of " + GetLocalString(oDungeon, "sDungeonName") + ".");

                // if a needed plot item isn't present
                if ((bBacchaQuest == TRUE) && (bBacchaQuestCompleted == FALSE) && (bBacchaDead == FALSE))
                {
                    if (bBacchaQuestItem == FALSE)
                    {
                        DebugMessage("Baccha's item needed.");
                        CreateItemOnObject("itm_id1_anttot1", GetFirstPC());
                    }
                    if ((bBacchaItemFound == TRUE) && (bBacchaFindItem == FALSE))
                    {
                        DebugMessage("Baccha's find item needed.");
                        CreateItemOnObject("id1_bossplot_ant", GetFirstPC());
                    }
                }
                if ((bHagathaQuest == TRUE) && (bHagathaQuestCompleted == FALSE) && (bHagathaDead == FALSE))
                {
                    if (bHagathaQuestItem == FALSE)
                    {
                        DebugMessage("Hagatha's item needed.");
                        CreateItemOnObject("itm_id1_widhair1", GetFirstPC());
                    }
                    if ((bHagathaItemFound == TRUE) && (bHagathaFindItem == FALSE))
                    {
                        DebugMessage("Hagatha's find item needed.");
                        CreateItemOnObject("id1_bossplot_hag", GetFirstPC());
                    }
                }
                if ((bMaggrisQuest == TRUE) && (bMaggrisQuestCompleted == FALSE) && (bMaggrisDead == FALSE))
                {
                    if (bMaggrisQuestItem == FALSE)
                    {
                        DebugMessage("Maggris' item needed.");
                        CreateItemOnObject("itm_id1_maggegg1", GetFirstPC());
                    }
                    if ((bMaggrisItemFound == TRUE) && (bMaggrisFindItem == FALSE))
                    {
                        DebugMessage("Maggris' find item needed.");
                        CreateItemOnObject("id1_bossplot_mag", GetFirstPC());
                    }
                }
                if ((bHaratQuest == TRUE) && (bHaratQuestCompleted == FALSE) && (bHaratDead == FALSE))
                {
                    if (bHaratQuestItem == FALSE)
                    {
                        DebugMessage("Harat's item needed.");
                        CreateItemOnObject("itm_id1_harattg1", GetFirstPC());
                    }
                    if ((bHaratItemFound == TRUE) && (bHaratFindItem == FALSE))
                    {
                        DebugMessage("Harat's find item needed.");
                        CreateItemOnObject("id1_bossplot_har1", GetFirstPC());
                    }
                }
                if ((bGzhorbQuest == TRUE) && (bGzhorbQuestCompleted == FALSE) && (bGzhorbDead == FALSE))
                {
                    if (bGzhorbQuestItem == FALSE)
                    {
                        DebugMessage("Gzhorb's item needed.");
                        CreateItemOnObject("itm_id1_gzrbeye1", GetFirstPC());
                    }
                    if ((bGzhorbItemFound == TRUE) && (bGzhorbFindItem == FALSE))
                    {
                        DebugMessage("Gzhorb's find item needed.");
                        CreateItemOnObject("id1_bossplot_gzb", GetFirstPC());
                    }
                }
                if ((bMasteriusQuest == TRUE) && (bMasteriusQuestCompleted == FALSE) && (bMasteriusDead == FALSE))
                {
                    if (bMasteriusQuestItem == FALSE)
                    {
                        DebugMessage("Masterius' item needed.");
                        CreateItemOnObject("itm_id1_masbone1", GetFirstPC());
                    }
                    if ((bMasteriusItemFound == TRUE) && (bMasteriusFindItem == FALSE))
                    {
                        DebugMessage("Masterius' find item needed.");
                        CreateItemOnObject("id1_bossplot_mas", GetFirstPC());
                    }
                }
            }
        }
    }
}

