//::////////////////////////////////////////////////////////////////////////////
//:: itm_id1_maggegg
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Item event handler for Maggris' Egg item. When used this item produces a
    hole placeable in the ground in front of the user and transports them, and
    their party, to the next level of the dungeon.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Jam 18, 2005
//::////////////////////////////////////////////////////////////////////////////


#include "inc_id1_debug"
#include "x2_inc_switches"
#include "inc_id1_utility"

const string HOLE_RESREF = "x2_plc_hole_b";

void main()
{
    DebugMessage("Running Maggris' script.");

//    int nEvent = GetUserDefinedEventNumber();

    // Item activated event.
//    if (nEvent == X2_ITEM_EVENT_ACTIVATE)
//    {
    object oUser = GetItemActivator();
    DebugMessage("Item activator is " + GetName(oUser));
    int bGenerating = GetLocalInt(GetModule(), "bGenerating");
    if (bGenerating == FALSE)
    {
        DebugMessage("bGenerating is FALSE.");

        // determine how many charges remain
        // Gather user, item and target location.
        object oItem = GetItemActivated();
        location lTarget = GetItemActivatedTargetLocation();

        string sName = GetName(oItem);
        DebugMessage("Name of egg is " + sName);

        // "Egg of the Hive Mother (5 Charges)"
        string sSubString = GetSubString(sName, 24, 1);
        int nCharges = StringToInt(sSubString);
        DebugMessage("SubString is " + sSubString);

        if (nCharges > 0)
        {
            // Determine if the players are out of combat and gathered.
            // Code from ptr_id1_dungeon.
            object oPlayer = GetFirstPC();
            object oArea = GetArea(oUser);
            object oPlayerArea;

            int bTooFar = FALSE;
            int bCombat = FALSE;

            while ((oPlayer != OBJECT_INVALID) && (bTooFar == FALSE) && (bCombat == FALSE))
            {
                DebugMessage("Checking player " + GetName(oPlayer));

                oPlayerArea = GetArea(oPlayer);
                if (oPlayerArea == oArea)
                {
                    DebugMessage("  Player is in the same area.");

                    if (GetDistanceBetween(oUser, oPlayer) <= 10.0)
                    {
                        DebugMessage("    Player is close enough.");

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
                        }// if (GetIsInCombat(oPlayer) == FALSE)
                        else
                        {
                            DebugMessage("    Player is in combat.");

                            bCombat = TRUE;
                        }
                    } // if (GetDistanceBetween(OBJECT_SELF, oPlayer) <= 10.0)
                    else
                    {
                        DebugMessage("    Player is not close enough.");

                        bTooFar = TRUE;
                    }
                } // if (oPlayerArea == oArea)
                else
                {
                    DebugMessage("  Player is not in the same area.");

                    if (GetTag(oPlayerArea) == "DungeonEntrance")
                    {
                        DebugMessage("    Player is at the dungeon entrance. They can stay there.");
                    }
                    else
                    {
                        DebugMessage("    Player is definitely not close enough.");

                        bTooFar = TRUE;
                    }
                }

                // cycle to next player
                oPlayer = GetNextPC();
            } // while ((oPlayer != OBJECT_INVALID) && (bTooFar == FALSE) && (bCombat == FALSE))



            // If the party is all together and out of combat.
            if ((bTooFar == FALSE) && (bCombat == FALSE))
            {
                if (GetTag(oPlayerArea) != "DungeonEntrance")
                {
                    // if the current level is not the final level
                    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
                    if (nCurrentLevel > 0)
                    {
                        object oDungeon = GetCurrentDungeon();
                        if (oDungeon != OBJECT_INVALID)
                        {
                            int nDungeonDepth = GetLocalInt(oDungeon, "nDungeonDepth");
                            DebugMessage("CurrentLevel is " + IntToString(nCurrentLevel) + " and depth is " + IntToString(nDungeonDepth));
                            if (nCurrentLevel < nDungeonDepth)
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

                                // Visual effects and creation of the hole.
                                effect eVFX = EffectVisualEffect(VFX_FNF_GREATER_RUIN);

                                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lTarget);

                                object oHole = DB_CreateObject(OBJECT_TYPE_PLACEABLE, HOLE_RESREF, lTarget, TRUE);

                                SetLocalObject(GetModule(), "oSpeaker", oHole);

                                // get the current area tag
                                object oArea = GetArea(oHole);

                                DebugMessage("A dungeon is active.");

                                // get current and max levels
                                int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
                                SetLocalInt(GetModule(), "nTempPreviousLevel", nCurrentLevel);
                                int nMaxLevel = GetLocalInt(oDungeon, "nMaxLevel");

                                DebugMessage("Current level: " + IntToString(nCurrentLevel));
                                DebugMessage("Max level: " + IntToString(nMaxLevel));

                                if (nCurrentLevel < nMaxLevel)
                                {
                                    int nStairValue = GetLocalInt(oDungeon, "nLevel" + IntToString(nCurrentLevel) + "StairsDown1");
                                    DebugMessage("Number of Stair 1 is " + IntToString(nStairValue));

                                    // level + 1
                                    nCurrentLevel++;
                                    DebugMessage("Set nCurrentLevel to " + IntToString(nCurrentLevel) + ". Point 12.");
                                    SetLocalInt(GetModule(), "nCurrentLevel", nCurrentLevel);

                                    int nDestination = GetLocalInt(oDungeon, "nLevel" + IntToString(nCurrentLevel) + "StairsUp1");
                                    int nDestinationIdentifier = GetLocalInt(oDungeon, "nArea" + IntToString(nDestination) + "Identifier");
                                    object oArea2 = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nDestinationIdentifier));
                                    object oDoor = GetLocalObject(oArea2, "oStairsUp");
                                    DebugMessage("  Destination is area " + IntToString(nDestination) + " with identifier " + IntToString(nDestinationIdentifier));

                                    // transport the player
                                    SetLocalObject(GetModule(), "oTempPC", oUser);
                                    SetLocalObject(GetModule(), "oTempDestinationDoor", oDoor);
                                    SetLocalObject(GetModule(), "oTempDungeon", oDungeon);
                                    SetLocalInt(GetModule(), "bTempLevelGen", FALSE);
                                    SetLocalInt(GetModule(), "bTempEggGen", TRUE);
                                    SetLocalObject(GetModule(), "oTempEgg", oHole);
                                    SetLocalObject(GetModule(), "oTempArea", oArea);
                                    SetLocalObject(GetModule(), "oSpeaker", oHole);

                                    // set starting coordinates
                                    SetLocalInt(GetModule(), "nCurrentX", 1);
                                    SetLocalInt(GetModule(), "nCurrentY", 1);

                                    SetLocalInt(GetModule(), "bGenerating", TRUE);

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
                                    DebugMessage("Generating additional dungeon level.");

                                    SetLocalInt(GetModule(), "bTempEggGen", TRUE);
                                    SetLocalObject(GetModule(), "oTempEgg", oHole);
                                    SetLocalObject(GetModule(), "oTempArea", oArea);
                                    SetLocalObject(GetModule(), "oSpeaker", oHole);

                                    // generate the level
                                    SetLocalInt(GetModule(), "nLevelProcess", 0);
                                    DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetObjectByTag("CPU1")));
                                }

                                nCharges--;
                                if (nCharges > 0)
                                {
                                    SetName(oItem, "Egg of the Hive Mother (" + IntToString(nCharges) + " Charges)");
                                } else
                                {
                                    SendMessageToPC(oUser, "The Egg of the Hive Mother has no more charges and crumbles into dust.");
                                    DelayCommand(1.0, DestroyObject(oItem));
                                }
                            } else
                            {
                                FloatingTextStringOnCreature("You cannot use the Egg of the Hive Mother since you are already on the lowest level of this dungeon.", oUser);
                            }
                        } else
                        {
                            FloatingTextStringOnCreature("A dungeon must be active to use the Egg of the Hive Mother.", oUser);
                        }
                    } else
                    {
                        FloatingTextStringOnCreature("You must be in a dungeon to use the Egg of the Hive Mother.", oUser);
                    }
                } else
                {
                    FloatingTextStringOnCreature("You must be in a dungeon to use the Egg of the Hive Mother.", oUser);
                }
            } else
            {
                FloatingTextStringOnCreature("You must gather your party to use the item.", oUser);
            }
        } else
        {
            FloatingTextStringOnCreature("The Egg of the Hive Mother has no more charges and crumbles into dust.", oUser);
            DestroyObject(oItem);
        }
    } else
    {
        FloatingTextStringOnCreature("The Egg of the Hive Mother has no more charges and crumbles into dust.", oUser);
    }

//    } // if (nEvent == X2_ITEM_EVENT_ACTIVATE)
}
