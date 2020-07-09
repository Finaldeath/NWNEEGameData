#include "inc_id_liltimmy"
#include "_inc_cutscene"
#include "inc_id1_utility"

void main()
{
    object oPC = GetEnteringObject();
    cs_AreaOnEnter(oPC);

    // if this is a PC
    if (GetIsPC(oPC) == TRUE)
    {
        DebugMessage("PC entering warehouse.");

        // if this player hasn't already been added
        if (GetLocalInt(oPC, "bEntered") == FALSE)
        {
            SetLocalInt(oPC, "bEntered", TRUE);

            // if the module is still cataloging
            if (GetLocalInt(GetModule(), "bCataloging") == TRUE)
            {
                DebugMessage("");
                DebugMessage("Putting entering player into cutscene mode for catalog.");
                DebugMessage("");

                if (GetCutsceneMode(oPC) == FALSE)
                {
                    DebugMessage("Cutscene mode set on PC.");
                    SetCutsceneMode(oPC, TRUE);
                } else
                {
                    DebugMessage("Cutscene mode already set on PC.");
                }
            } else
            {
                // Check to see we played the cutscene when the cataloging was finished.
                // If we didn't, we should do it now.
                if(!cs_GetCutsceneStarted(1, OBJECT_SELF))
                {
                    DebugMessage("Entering cutscene loop.");

                    // remove cutscene mode from all players, just to make sure there are no conflicts with the cutscene system
                    // In theory, there should only be one PC in the module at this point, but let's not leave anything to chance.
                    object oPCLoop = GetFirstPC(); // new object var, don't want to overwrite oPC
                    while (oPCLoop != OBJECT_INVALID)
                    {
                        if (GetCutsceneMode(oPCLoop) == TRUE)
                        {
                            DebugMessage("Cutscene mode already set on PC.");
                        }
                        SetCutsceneMode(oPCLoop, FALSE);
                        oPCLoop = GetNextPC();
                    }

                    // start intro cutscene
                    cs_SetOption(CS_OPTION_RESTORE_PC_LOCATION, TRUE, OBJECT_SELF);
                    cs_PreCutsceneFade(CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST, OBJECT_SELF);
                    cs_StartCutscene("cut_id1_narr01", "cut_id1_narr01_e", 1.5, TRUE, TRUE, 1, OBJECT_SELF);
                }

                DebugMessage("");
                DebugMessage("Adding journal entries to incoming player.");

                // check the status of the main plot an update
                int nMainPlot = lt_GetDungeonLevel();
                DebugMessage("  Main plot state is " + IntToString(nMainPlot));
                if (nMainPlot == ID_LOCAL_FIRST_DUNGEON_COMPLETED)
                {
                    if (lt_GetFirstLieutenant() == ID_LOCAL_LIEUTENANT_WEREBOAR)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bBacchaDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 20, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 25, oPC, FALSE);
                        }
                    } else if (lt_GetFirstLieutenant() == ID_LOCAL_LIEUTENANT_GIANTESS)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bHagathaDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 21, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 26, oPC, FALSE);
                        }
                    } else if (lt_GetFirstLieutenant() == ID_LOCAL_LIEUTENANT_INSECT)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bMaggrisDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 22, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 27, oPC, FALSE);
                        }
                    }
                } else if (nMainPlot == ID_LOCAL_SECOND_DUNGEON_COMPLETED)
                {
                    if (lt_GetSecondLieutenant() == ID_LOCAL_LIEUTENANT_WEREBOAR)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bBacchaDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 30, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 35, oPC, FALSE);
                        }
                    } else if (lt_GetSecondLieutenant() == ID_LOCAL_LIEUTENANT_GIANTESS)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bHagathaDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 31, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 36, oPC, FALSE);
                        }
                    } else if (lt_GetSecondLieutenant() == ID_LOCAL_LIEUTENANT_INSECT)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bMaggrisDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 32, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 37, oPC, FALSE);
                        }
                    }
                } else if (nMainPlot == ID_LOCAL_THIRD_DUNGEON_COMPLETED)
                {
                    if (lt_GetThirdLieutenant() == ID_LOCAL_LIEUTENANT_WEREBOAR)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bBacchaDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 40, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 45, oPC, FALSE);
                        }
                    } else if (lt_GetThirdLieutenant() == ID_LOCAL_LIEUTENANT_GIANTESS)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bHagathaDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 41, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 46, oPC, FALSE);
                        }
                    } else if (lt_GetThirdLieutenant() == ID_LOCAL_LIEUTENANT_INSECT)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bMaggrisDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 42, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 47, oPC, FALSE);
                        }
                    }
                } else if (nMainPlot == ID_LOCAL_FIRST_BOSS_DEFEATED)
                {
                    if (lt_GetFirstBoss() == ID_LOCAL_BOSS_DEMON)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bHaratDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 50, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 55, oPC, FALSE);
                        }
                    } else if (lt_GetFirstBoss() == ID_LOCAL_BOSS_BEHOLDER)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bGzhorbDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 51, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 56, oPC, FALSE);
                        }
                    } else if (lt_GetFirstBoss() == ID_LOCAL_BOSS_LICH)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bMasteriusDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 52, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 57, oPC, FALSE);
                        }
                    }
                } else if (nMainPlot == ID_LOCAL_SECOND_BOSS_DEFEATED)
                {
                    if (lt_GetSecondBoss() == ID_LOCAL_BOSS_DEMON)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bHaratDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 60, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 65, oPC, FALSE);
                        }
                    } else if (lt_GetSecondBoss() == ID_LOCAL_BOSS_BEHOLDER)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bGzhorbDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 61, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 66, oPC, FALSE);
                        }
                    } else if (lt_GetSecondBoss() == ID_LOCAL_BOSS_LICH)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bMasteriusDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 62, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 67, oPC, FALSE);
                        }
                    }
                } else if (nMainPlot == ID_LOCAL_THIRD_BOSS_DEFEATED)
                {
                    if (lt_GetThirdBoss() == ID_LOCAL_BOSS_DEMON)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bHaratDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 70, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 75, oPC, FALSE);
                        }
                    } else if (lt_GetThirdBoss() == ID_LOCAL_BOSS_BEHOLDER)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bGzhorbDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 71, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 76, oPC, FALSE);
                        }
                    } else if (lt_GetThirdBoss() == ID_LOCAL_BOSS_LICH)
                    {
                        // if killed
                        if (GetLocalInt(GetModule(), "bMasteriusDead") == TRUE)
                        {
                            AddJournalQuestEntry("id1_main", 72, oPC, FALSE);
                        } else // if quest active
                        {
                            AddJournalQuestEntry("id1_main", 77, oPC, FALSE);
                        }
                    }
                } else if (nMainPlot >= ID_LOCAL_HALASTER_TIMMY)
                {
                    AddJournalQuestEntry("id1_main", 80, oPC, FALSE);
                }

                // check the status of each boss plot
                if (GetLocalInt(GetModule(), "bBacchaQuestActive") == TRUE)
                {
                    if (GetLocalInt(GetModule(), "bBacchaDead") == TRUE)
                    {
                        AddJournalQuestEntry("id1_baccha", 35, oPC, FALSE, FALSE);
                    } else if (GetLocalInt(GetModule(), "bBacchaQuestCompleted") == TRUE)
                    {
                        AddJournalQuestEntry("id1_baccha", 30, oPC, FALSE, FALSE);
                    } else if (GetLocalInt(GetModule(), "bBacchaQuestItemFound") == TRUE)
                    {
                        AddJournalQuestEntry("id1_baccha", 20, oPC, FALSE, FALSE);
                    } else
                    {
                        AddJournalQuestEntry("id1_baccha", 10, oPC, FALSE, FALSE);
                    }
                }
                if (GetLocalInt(GetModule(), "bHagathaQuestActive") == TRUE)
                {
                    if (GetLocalInt(GetModule(), "bHagathaDead") == TRUE)
                    {
                        AddJournalQuestEntry("id1_hagatha", 35, oPC, FALSE, FALSE);
                    } else if (GetLocalInt(GetModule(), "bHagathaQuestCompleted") == TRUE)
                    {
                        AddJournalQuestEntry("id1_hagatha", 30, oPC, FALSE, FALSE);
                    } else if (GetLocalInt(GetModule(), "bHagathaQuestItemFound") == TRUE)
                    {
                        AddJournalQuestEntry("id1_hagatha", 20, oPC, FALSE, FALSE);
                    } else
                    {
                        AddJournalQuestEntry("id1_hagatha", 10, oPC, FALSE, FALSE);
                    }
                }
                if (GetLocalInt(GetModule(), "bMaggrisQuestActive") == TRUE)
                {
                    if (GetLocalInt(GetModule(), "bMaggrisDead") == TRUE)
                    {
                        AddJournalQuestEntry("id1_maggris", 35, oPC, FALSE, FALSE);
                    } else if (GetLocalInt(GetModule(), "bMaggrisQuestCompleted") == TRUE)
                    {
                        AddJournalQuestEntry("id1_maggris", 30, oPC, FALSE, FALSE);
                    } else if (GetLocalInt(GetModule(), "bMaggrisQuestItemFound") == TRUE)
                    {
                        AddJournalQuestEntry("id1_maggris", 20, oPC, FALSE, FALSE);
                    } else
                    {
                        AddJournalQuestEntry("id1_maggris", 10, oPC, FALSE, FALSE);
                    }
                }
                if (GetLocalInt(GetModule(), "bHaratQuestActive") == TRUE)
                {
                    if (GetLocalInt(GetModule(), "bHaratDead") == TRUE)
                    {
                        AddJournalQuestEntry("id1_harat", 35, oPC, FALSE, FALSE);
                    } else if (GetLocalInt(GetModule(), "bHaratQuestCompleted") == TRUE)
                    {
                        AddJournalQuestEntry("id1_harat", 30, oPC, FALSE, FALSE);
                    } else if (GetLocalInt(GetModule(), "bHaratQuestItemFound") == TRUE)
                    {
                        AddJournalQuestEntry("id1_harat", 20, oPC, FALSE, FALSE);
                    } else
                    {
                        AddJournalQuestEntry("id1_harat", 10, oPC, FALSE, FALSE);
                    }
                }
                if (GetLocalInt(GetModule(), "bGzhorbQuestActive") == TRUE)
                {
                    if (GetLocalInt(GetModule(), "bGzhorbDead") == TRUE)
                    {
                        AddJournalQuestEntry("id1_gzhorb", 35, oPC, FALSE, FALSE);
                    } else if (GetLocalInt(GetModule(), "bGzhorbQuestCompleted") == TRUE)
                    {
                        AddJournalQuestEntry("id1_gzhorb", 30, oPC, FALSE, FALSE);
                    } else if (GetLocalInt(GetModule(), "bGzhorbQuestItemFound") == TRUE)
                    {
                        AddJournalQuestEntry("id1_gzhorb", 20, oPC, FALSE, FALSE);
                    } else
                    {
                        AddJournalQuestEntry("id1_gzhorb", 10, oPC, FALSE, FALSE);
                    }
                }
                if (GetLocalInt(GetModule(), "bMasteriusQuestActive") == TRUE)
                {
                    if (GetLocalInt(GetModule(), "bMasteriusDead") == TRUE)
                    {
                        AddJournalQuestEntry("id1_masterius", 35, oPC, FALSE, FALSE);
                    } else if (GetLocalInt(GetModule(), "bMasteriusQuestCompleted") == TRUE)
                    {
                        AddJournalQuestEntry("id1_masterius", 30, oPC, FALSE, FALSE);
                    } else if (GetLocalInt(GetModule(), "bMasteriusQuestItemFound") == TRUE)
                    {
                        AddJournalQuestEntry("id1_masterius", 20, oPC, FALSE, FALSE);
                    } else
                    {
                        AddJournalQuestEntry("id1_masterius", 10, oPC, FALSE, FALSE);
                    }
                }
            }

            // give all guide journal entries
            AddJournalQuestEntry("id1_guidecontrol", 1, oPC, FALSE);
            AddJournalQuestEntry("id1_guidejournal", 1, oPC, FALSE);
            AddJournalQuestEntry("id1_guidemap", 1, oPC, FALSE);
            AddJournalQuestEntry("id1_guidecamps", 1, oPC, FALSE);
            AddJournalQuestEntry("id1_guideforge", 1, oPC, FALSE);
            AddJournalQuestEntry("id1_guidehenchmen", 1, oPC, FALSE);
            AddJournalQuestEntry("id1_guidemonsters", 1, oPC, FALSE);
            AddJournalQuestEntry("id1_guidepuzzles", 1, oPC, FALSE);
            AddJournalQuestEntry("id1_guidesecrets", 1, oPC, FALSE);
        }

        DebugMessage("Dungeon plot = " + IntToString(GetLocalInt(GetModule(), "ID_MODULE_DUNGEON_LEVEL")));

        // If the a player enters after defeating halaster roll the credits.
        if (GetLocalInt(GetModule(), "ID_MODULE_DUNGEON_LEVEL") >= 15)
        {
            DebugMessage("Credits = " + IntToString(GetLocalInt(GetModule(), "ID_MODULE_CREDITS")));

            // Only roll the credits once.
            if (GetLocalInt(GetModule(), "ID_MODULE_CREDITS") == 1)
            {
                SetLocalInt(GetModule(), "ID_MODULE_CREDITS", 2);

                object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "CreditsCPU");

                ExecuteScript("exe_id1_credits", oMicroCPU);

                DestroyObject(oMicroCPU, 300.0);

                // reset level
                DebugMessage("Set nCurrentLevel to 0. Point 2.");
                SetLocalInt(GetModule(), "nCurrentLevel", 0);

                // dissociate dungeon

                // store dungeon information and delete
                object oDungeon = GetCurrentDungeon();
                int nDungeonNumber = GetLocalInt(GetModule(), "nDungeonNumber");
                if (nDungeonNumber != 0)
                {
                    string sName = "Dungeon" + IntToString(nDungeonNumber);
                    int bSuccess = StoreCampaignObject("ID_DATABASE", sName, oDungeon);
                    DebugMessage("Success of storing of " + sName + " is " + IntToString(bSuccess));
                }

                SetLocalObject(GetModule(), "oCurrentDungeon", OBJECT_INVALID);
                SetLocalInt(GetModule(), "nDungeonNumber", 0);
                DestroyObject(oDungeon);

/*
                TBD: This is probably the best candidate area for dungeon
                     deletion.

                TBD: This is the code copied and pasted from cac_id1_endhalas
                     that needs to be removed from line 64 of that file in order
                     to stop the end cutscenes from repeating on each player.

                // store dungeon information and delete
                object oDungeon = GetCurrentDungeon();
                int nDungeonNumber = GetLocalInt(GetModule(), "nDungeonNumber");
                if (nDungeonNumber != 0)
                {
                    string sName = "Dungeon" + IntToString(nDungeonNumber);
                    int bSuccess = StoreCampaignObject("ID_DATABASE", sName, oDungeon);
                    DebugMessage("Success of storing of " + sName + " is " + IntToString(bSuccess));
                }

                SetLocalObject(GetModule(), "oCurrentDungeon", OBJECT_INVALID);
                SetLocalInt(GetModule(), "nDungeonNumber", 0);
                DestroyObject(oDungeon);
*/
            } // if (GetLocalInt(GetModule(), "ID_MODULE_CREDITS") == 0)
        } // if (GetLocalInt(GetModule(), "ID_MODULE_DUNGEON_LEVEL") >= 15)
    }
}
