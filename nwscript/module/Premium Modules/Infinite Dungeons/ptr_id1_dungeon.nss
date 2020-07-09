//:://////////////////////////////////////////////////////////////
//:: ptr_id1_dungeon                                            //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    This script starts the generation of a dungeon level. It only
    allows one level to be generated at a time. It sets the
    current stairs down for the level then, if the next level has
    not been generated, starts the area generation of the next
    level. If there is already a next level, it jumps the PC to
    the correct door.
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: July 2005                                      //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Include Files                                                //
//////////////////////////////////////////////////////////////////
#include "inc_id1_debug"
#include "inc_id1_store"

// int GetModuleFlag(string sFlag)
#include "inc_id1_flags"

// void TransportPlayer(object oPC, object oDestinationDoor, object oDungeon = OBJECT_INVALID)
//#include "inc_id1_trans"
#include "inc_id1_utility"

#include "inc_id_liltimmy"

//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    // prevent this from being called multiple times
    int bGenerating = GetLocalInt(GetModule(), "bGenerating");
    DebugMessage("bGenerating is " + IntToString(bGenerating));

    // if a level is not being generated already
    if (bGenerating == FALSE)
    {
        // set that a level is being generated
        SetLocalInt(GetModule(), "bGenerating", TRUE);
        DebugMessage("Setting bGenerating in dungeon to TRUE");

        DebugMessage("");
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

                if (GetDistanceBetween(OBJECT_SELF, oPlayer) <= 15.0)
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
                    } else
                    {
                        DebugMessage("    Player is in combat.");

                        bCombat = TRUE;
                    }
                } else
                {
                    DebugMessage("    Player is not close enough.");

                    bTooFar = TRUE;
                }
            } else
            {
                DebugMessage("  Player is not in the same area.");

                if (GetTag(oPlayerArea) == "DungeonEntrance")
                {
                    DebugMessage("    Player is at the dungeon entrance. They can stay there.");
                } else
                {
                    DebugMessage("    Player is definitely not close enough.");

                    bTooFar = TRUE;
                }
            }

            // cycle to next player
            oPlayer = GetNextPC();
        }

        if (bTooFar == FALSE)
        {
            if (bCombat == FALSE)
            {
                DebugMessage("");
                DebugMessage("Players acceptable. Starting level checking.");

                // get the PC
                object oPC = GetClickingObject();

                // if there is no dungeon active
                object oDungeon = GetCurrentDungeon();
                if (oDungeon != OBJECT_INVALID)
                {
                    // get the current area tag
                    object oArea = GetArea(OBJECT_SELF);

                    DebugMessage("A dungeon is active.");

                    // get tag
                    string sTag = GetTag(OBJECT_SELF);

                    // get current and max levels
                    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
                    SetLocalInt(GetModule(), "nTempPreviousLevel", nCurrentLevel);
                    DebugMessage("Setting level to clean to " + IntToString(nCurrentLevel));
                    int nMaxLevel = GetLocalInt(oDungeon, "nMaxLevel");

                    DebugMessage("Current level: " + IntToString(nCurrentLevel));
                    DebugMessage("Max level: " + IntToString(nMaxLevel));

                    if ((nCurrentLevel < nMaxLevel) || (sTag == "ID1_STATIC_STAIRSUP"))
                    {
                        // find current area
                        object oArea = GetArea(OBJECT_SELF);
                        int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
                        int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

                        DebugMessage("Current area num: " + IntToString(nAreaNum));

                        // find current stair number
                        string sStair = "nLevel" + IntToString(nCurrentLevel) + "Stairs";
                        if (sTag == "ID1_STATIC_STAIRSDOWN")
                        {
                            sStair += "Down";
                        } else if (sTag == "ID1_STATIC_STAIRSUP") // if stairs down
                        {
                            sStair += "Up";
                        }
                        int nStairNum = GetLocalInt(oDungeon, sStair);

                        DebugMessage("Number of " + sStair + ": " + IntToString(nStairNum));

                        // search list of stairs for this area
                        int nCurrentStair = 1;
                        int nStairValue = GetLocalInt(oDungeon, sStair + IntToString(nCurrentStair));
                        DebugMessage("Number of Stair " + IntToString(nCurrentStair) + " is " + IntToString(nStairValue));

                        // if there is a valid staircase
                        if (nStairValue == nAreaNum)
                        {
                            DebugMessage("  Stair has a destination.");

                            // set cutscene mode for the player
                            object oPlayer = GetFirstPC();
                            while (oPlayer != OBJECT_INVALID)
                            {
                                DebugMessage("Adding cutscene mode to player " + GetName(oPlayer));

                                if (GetTag(GetArea(oPlayer)) != "DungeonEntrance")
                                {
                                    // put in cutscene mode
                                    if (GetCutsceneMode(oPlayer) == FALSE)
                                    {
                                        DebugMessage("Cutscene mode set on PC.");
                                        SetCutsceneMode(oPlayer, TRUE);
                                    } else
                                    {
                                        DebugMessage("Cutscene mode already set on PC.");
                                    }
                                }

                                // setting plot to false to be safe
                                if (GetPlotFlag(oPlayer) == TRUE)
                                {
                                    DebugMessage("Plot flag was set on player.");
                                }
                                SetPlotFlag(oPlayer, FALSE);

                                // cycle to next player
                                oPlayer = GetNextPC();
                            }

                            // find destination
                            int nDestination;
                            int nDestinationIdentifier;
                            object oArea2;
                            object oDoor;

                            // if stairs down
                            if (sTag == "ID1_STATIC_STAIRSDOWN")
                            {
                                DebugMessage("  Going down.");

                                // level + 1
                                nCurrentLevel++;
                                DebugMessage("Set nCurrentLevel to " + IntToString(nCurrentLevel) + ". Point 12.");
                                SetLocalInt(GetModule(), "nCurrentLevel", nCurrentLevel);

                                nDestination = GetLocalInt(oDungeon, "nLevel" + IntToString(nCurrentLevel) + "StairsUp1");
                                nDestinationIdentifier = GetLocalInt(oDungeon, "nArea" + IntToString(nDestination) + "Identifier");
                                oArea2 = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nDestinationIdentifier));
                                oDoor = GetLocalObject(oArea2, "oStairsUp");
                                DebugMessage("  Destination is area " + IntToString(nDestination) + " with identifier " + IntToString(nDestinationIdentifier));
                            } else if (sTag == "ID1_STATIC_STAIRSUP") // if stairs up
                            {
                                DebugMessage("  Going up.");

                                // level - 1
                                nCurrentLevel--;
                                DebugMessage("Set nCurrentLevel to " + IntToString(nCurrentLevel) + ". Point 13.");
                                SetLocalInt(GetModule(), "nCurrentLevel", nCurrentLevel);
                                DebugMessage("  Setting nCurrentLevel to " + IntToString(nCurrentLevel));

                                if (nCurrentLevel > 0)
                                {
                                    nDestination = GetLocalInt(oDungeon, "nLevel" + IntToString(nCurrentLevel) + "StairsDown1");
                                    nDestinationIdentifier = GetLocalInt(oDungeon, "nArea" + IntToString(nDestination) + "Identifier");
                                    oArea2 = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nDestinationIdentifier));
                                    oDoor = GetLocalObject(oArea2, "oStairsDown");
                                    DebugMessage("  Destination is area " + IntToString(nDestination) + " with identifier " + IntToString(nDestinationIdentifier));
                                } else
                                {
                                    DebugMessage("  Leading up to the entrance level.");

                                    oDoor = GetObjectByTag("DungeonEntranceStairs");
                                    AssignCommand(oDoor, PlayAnimation(ANIMATION_DOOR_CLOSE));

                                    // go through each player and remove all plotgiver associates
                                    object oPlayer = GetFirstPC();
                                    object oHenchman;
                                    int nCount;
                                    while (oPlayer != OBJECT_INVALID)
                                    {
                                        DebugMessage("  Player " + GetPCIdentifier(oPC));

                                        // get henchmen of player
                                        nCount = 1;
                                        oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nCount);
                                        while (oHenchman != OBJECT_INVALID)
                                        {
                                            DebugMessage("    Henchman " + IntToString(nCount));
                                            if (GetLocalString(oHenchman, "sConversation") == "id1_plotgiver")
                                            {
                                                DebugMessage("    Is a plot giver. Deleting.");

                                                string sVariable = GetLocalString(oHenchman, "sVariable");
                                                DebugMessage("    sVariable is " + sVariable);
                                                SetLocalInt(oDungeon, "b" + sVariable + "Gone", FALSE);

                                                RemoveHenchman(oPC, oHenchman);
                                                DestroyObject(oHenchman);
                                            } else
                                            {
                                                nCount++;
                                            }
                                            oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nCount);
                                        }

                                        // next pc
                                        oPlayer = GetNextPC();
                                    }
                                }

                                if (oDoor == OBJECT_INVALID)
                                {
                                    DebugMessage("    Destination is invalid");
                                }
                            }

                            // transport the player
                            SetLocalObject(GetModule(), "oTempPC", oPC);
                            SetLocalObject(GetModule(), "oTempDestinationDoor", oDoor);
                            SetLocalObject(GetModule(), "oTempDungeon", oDungeon);
                            SetLocalInt(GetModule(), "bTempLevelGen", FALSE);
                            SetLocalObject(GetModule(), "oSpeaker", OBJECT_SELF);
                            SetLocalObject(GetModule(), "oTempArea", oArea);

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
                            DebugMessage("Stair has no destination. Returning to dungeon entrance.");

                            object oPlayer = GetFirstPC();
                            while (oPlayer != OBJECT_INVALID)
                            {
                                DebugMessage("Tranporting player " + GetName(oPlayer));

                                if (GetTag(GetArea(oPlayer)) != "DungeonEntrance")
                                {
                                    DebugMessage("Clearing actions. Point 35.");
                                    AssignCommand(oPlayer, ClearAllActions());
                                    AssignCommand(oPlayer, JumpToLocation(GetStartingLocation()));
                                }

                                // cycle to next player
                                oPlayer = GetNextPC();
                            }

                            // break out
                            SetLocalInt(GetModule(), "bGenerating", FALSE);
                            DebugMessage("Setting bGenerating in dungeon to FALSE");
                        }
                    } else
                    {
                        // set cutscene mode for the player
                        object oPlayer = GetFirstPC();
                        while (oPlayer != OBJECT_INVALID)
                        {
                            DebugMessage("Adding cutscene mode to player " + GetName(oPlayer));

                            if (GetTag(GetArea(oPlayer)) != "DungeonEntrance")
                            {
                                // put in cutscene mode
                                if (GetCutsceneMode(oPlayer) == FALSE)
                                {
                                    DebugMessage("Cutscene mode set on PC.");
                                    SetCutsceneMode(oPlayer, TRUE);
                                } else
                                {
                                    DebugMessage("Cutscene mode already set on PC.");
                                }
                            }

                            // setting plot to false to be safe
                            if (GetPlotFlag(oPlayer) == TRUE)
                            {
                                DebugMessage("Plot flag was set on player.");
                            }
                            SetPlotFlag(oPlayer, FALSE);

                            // cycle to next player
                            oPlayer = GetNextPC();
                        }

                        DebugMessage("Generating additional dungeon level.");
                        SetLocalObject(GetModule(), "oSpeaker", OBJECT_SELF);
                        SetLocalObject(GetModule(), "oTempArea", oArea);

                        // generate the level
                        SetLocalInt(GetModule(), "nLevelProcess", 0);
                        DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetObjectByTag("CPU1")));
                    }
                } else
                {
                    SpeakString("No dungeon exists. Returning to dungeon entrance.");

                    object oPlayer = GetFirstPC();
                    while (oPlayer != OBJECT_INVALID)
                    {
                        DebugMessage("Tranporting player " + GetName(oPlayer));

                        if (GetTag(GetArea(oPlayer)) != "DungeonEntrance")
                        {
                            DebugMessage("Clearing actions. Point 36.");
                            AssignCommand(oPlayer, ClearAllActions());
                            AssignCommand(oPlayer, JumpToLocation(GetStartingLocation()));
                        }

                        // setting plot to false to be safe
                        if (GetPlotFlag(oPlayer) == TRUE)
                        {
                            DebugMessage("Plot flag was set on player.");
                        }
                        SetPlotFlag(oPlayer, FALSE);

                        // cycle to next player
                        oPlayer = GetNextPC();
                    }

                    // break out
                    SetLocalInt(GetModule(), "bGenerating", FALSE);
                    DebugMessage("Setting bGenerating in dungeon to FALSE");
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
    } else
    {
        SpeakString("Another dungeon is currently being generated.");
    }
}

