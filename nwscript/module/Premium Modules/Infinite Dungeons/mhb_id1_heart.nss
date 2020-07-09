//::///////////////////////////////////////////////
//:: Infinate Dungeons Module Heartbeat
//:: mhb_id_modhb
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This is the ID module heartbeat script.

Currently it only acts as a fake heartbeat for party members.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: Aug 28  2005
//:://////////////////////////////////////////////

#include "inc_id1_debug"
#include "inc_id1_score"

//#include "inc_id1_utility"

void DetectSecretDoor(object oPC, int nCurrentLevel, object oDungeon);

void main()
{

    DebugMessage("");
    DebugMessage("Module heartbeat.");

    object oPC = GetFirstPC();
    int nCount = 0;

    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
    object oDungeon = GetCurrentDungeon();
    if (nCurrentLevel > 0)
    {
        if (oDungeon != OBJECT_INVALID)
        {
            int bEntrance = TRUE;

            while (oPC != OBJECT_INVALID)
            {
                nCount++;

                DebugMessage("Examining PC " + IntToString(nCount));

                if (GetIsInCombat(oPC) == FALSE)
                {
                    // EDIT: create microprocess
                    DetectSecretDoor(oPC, nCurrentLevel, oDungeon);
                }

        /*        if (GetTag(GetArea(oPC)) != "DungeonEntrance")
                {
                    bEntrance = FALSE;
                }*/

                // cycle to next PC
                oPC = GetNextPC();
            }

            DebugMessage("  Done with " + IntToString(nCount) + " PCs.");
        } else
        {
            DebugMessage("  Not a valid dungeon.");
        }
    } else
    {
        DebugMessage("  Not on a valid level.");
    }

/*    if (bEntrance == TRUE)
    {
        int bGenerating = GetLocalInt(GetModule(), "bGenerating");
        if (bGenerating == FALSE)
        {
            if (GetLocalInt(GetModule(), "nCurrentLevel") != 0)
            {
                DebugMessage("Set nCurrentLevel to 0. Point 7.");
                SetLocalInt(GetModule(), "nCurrentLevel", 0);

                SendMessageToPC(GetFirstPC(), "All remaining players are in the warehouse. Resetting dungeon level.");
            }
        }
    }*/
}

void DetectSecretDoor(object oPC, int nCurrentLevel, object oDungeon)
{
//    object oWaypoint;// = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, GetLocation(oPC), TRUE, OBJECT_TYPE_WAYPOINT);
//    int nCount = 0;
//    string sTag;
    int nRoll;
    int nRoll2;
    location lWaypoint;
    float fFacing;
//    object oExit;
    object oDoor;

    // get the area the player is in
    object oArea = GetArea(oPC);

    // get the area number
    int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

    // EDIT: get nearest waypoints to player

    // get the number of secret waypoint
    int nWaypointNum = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "WaypointSecretDoor");

    string sTileset;
    int nTileset;
    int nDoorNum;
    int nDoor;
    string sDoor;

    // check each waypoint against each player
    int nWaypoint = 1;
    object oWaypoint;
    string sWaypoint;
    int nDC;
    while (nWaypoint <= nWaypointNum)
    {
        DebugMessage("Checking waypoint " + IntToString(nWaypoint) + " of " + IntToString(nWaypointNum));

        oWaypoint = GetLocalObject(oArea, "oWaypointSecretDoor" + IntToString(nWaypoint));

        // the variable string for this waypoint
        sWaypoint = "Area" + IntToString(nAreaNum) + "WaypointSecretDoor" + IntToString(nWaypoint) + "Level" + IntToString(nCurrentLevel);

        // if this waypoint is used in this level
        if (GetLocalInt(oDungeon, "b" + sWaypoint + "Used") == TRUE)
        {
            // if the door has not been detected
            if (GetLocalInt(oDungeon, "b" + sWaypoint + "Detected") == FALSE)
            {
                DebugMessage("Door has not been detected.");

                // if the player can see the door
                if (LineOfSightObject(oPC, oWaypoint) == TRUE)
                {
                    DebugMessage("Secret door can be seen.");

                    // if the player is close enough to detect the door
                    if (GetDistanceBetween(oPC, oWaypoint) <= 5.0)
                    {
                        DebugMessage("Player is within detection distance.");

                        nRoll = GetSkillRank(SKILL_SEARCH, oPC);

                        DebugMessage("Search roll before detect mode: " + IntToString(nRoll));

                        if (GetDetectMode(oPC) == DETECT_MODE_ACTIVE)
                        {
                            DebugMessage("In detect mode.");

                            nRoll += 20;
                        } else
                        {
                            DebugMessage("Not in detect mode.");

                            nRoll += d20();
                        }

                        nRoll2 = GetSkillRank(SKILL_SPOT, oPC);

                        DebugMessage("Spot roll before detect mode: " + IntToString(nRoll));

                        if (GetDetectMode(oPC) == DETECT_MODE_ACTIVE)
                        {
                            DebugMessage("In detect mode.");

                            nRoll2 += 10;
                        } else
                        {
                            DebugMessage("Not in detect mode.");

                            nRoll2 += d10();
                        }

                        nDC = GetLocalInt(oDungeon, "n" + sWaypoint + "DC");

                        DebugMessage("Detect roll was Search " + IntToString(nRoll) + " and Spot " + IntToString(nRoll2) + " vs DC " + IntToString(nDC));

                        // check to see if the roll succeeded
                        if ((nRoll >= nDC) || (nRoll2 <= nDC))
                        {
                            DebugMessage("Door found.");

                            // Update - Oct 4, 2005 Grant: Award some points for
                            // the discovery.
                            AwardSecretDiscoveredPoints(oPC, nDC);

                            SetLocalInt(oDungeon, "b" + sWaypoint + "Detected", TRUE);

                            nDoor = GetLocalInt(oDungeon, "n" + sWaypoint + "Door");
                            sDoor = GetLocalString(oDungeon, "sListSecretDoor" + IntToString(nDoor) + "ResRef");
                            DebugMessage("sListSecretDoor" + IntToString(nDoor) + "ResRef is " + sDoor);

                            // create door at that waypoint
                            lWaypoint = GetLocation(oWaypoint);
                            fFacing = GetFacing(oWaypoint);
                            fFacing += 180.0;
                            oDoor = CreateObject(OBJECT_TYPE_PLACEABLE, sDoor, lWaypoint, FALSE, "SecretDoor");
                            DelayCommand(0.01, AssignCommand(oDoor, SetFacing(fFacing)));

                            // find nearest exit
                            oWaypoint = GetNearestObjectByTag("ID1_STATIC_WP_SECRET_DOOR_EXIT", oDoor);

                            // check to see if valid and not active
                            lWaypoint = GetLocation(oWaypoint);
                            fFacing = GetFacing(oWaypoint);
                            fFacing += 180.0;
                            oDoor = CreateObject(OBJECT_TYPE_PLACEABLE, sDoor, lWaypoint, FALSE, "SecretDoorExit");
                            DelayCommand(0.01, AssignCommand(oDoor, SetFacing(fFacing)));
                        } else
                        {
                            DebugMessage("Roll failed.");
                        }
                    } else
                    {
                        DebugMessage("Player is too far to detect the secret door.");
                    }

                } else
                {
                    DebugMessage("Secret door cannot be seen.");
                }
            } else
            {
                DebugMessage("Secret door already detected.");
            }
        } else
        {
            DebugMessage("Secret door is not used in this level.");
        }

        nWaypoint++;
    }
}

