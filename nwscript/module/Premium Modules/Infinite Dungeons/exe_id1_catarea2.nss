//:://////////////////////////////////////////////////////////////
//:: exe_id1_catarea                                            //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    EDIT:
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: July 2005                                      //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Include Files                                                //
//////////////////////////////////////////////////////////////////
#include "inc_id1_debug"

// int GetDoorType(object oDoor)
#include "inc_id1_gen"

// object GetNextCPU()
#include "inc_id1_utility"


//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    object oArea = GetLocalObject(OBJECT_SELF, "oArea");

    // cycle through all waypoints
    if (GetIsObjectValid(oArea))
    {
        DebugMessage("Cataloging area " + GetTag(oArea));

        // set number of actual areas found
        int nAreas = GetLocalInt(GetModule(), "nQueueMax");
        nAreas++;
        SetLocalInt(GetModule(), "nQueueMax", nAreas);

        // record number on this area
        SetLocalInt(oArea, "nAreaIdentifier", nAreas);
        SetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nAreas), oArea);
        DebugMessage("  Area Identifier is " + IntToString(GetLocalInt(oArea, "nAreaIdentifier")));

        // find tileset
        SetLocalString(oArea, "sTileset", GetTilesetResRef(oArea));

        // set base value for door configuration
        SetLocalInt(oArea, "nDoor", 0);

        // set base number of staircases in the area
        SetLocalInt(oArea, "nStairsUp", 0);
        SetLocalInt(oArea, "nStairsDown", 0);

        // set base number for each of the different types of waypoints in the area
        SetLocalInt(oArea, "nWaypointEncounter", 0); // number of encounter spawnpoints
        SetLocalInt(oArea, "nWaypointBoss", 0); // number of boss spawnpoints
        SetLocalInt(oArea, "nWaypointBossGuard", 0); // number of boss guard spawnpoints
        SetLocalInt(oArea, "nWaypointTreasure", 0); // number of treasure spawnpoints
        SetLocalInt(oArea, "nWaypointSecret", 0); // number of secret spawnpoints
        SetLocalInt(oArea, "nWaypointSecretTreasure", 0); // number of secret treasure spawnpoints
        SetLocalInt(oArea, "nWaypointSecretEncounter", 0); // number of secret encounter spawnpoints
        SetLocalInt(oArea, "nWaypointSecretDoor", 0); // number of secret door spawnpoints
        SetLocalInt(oArea, "nWaypointPlot", 0); // number of plot spawnpoints
        SetLocalInt(oArea, "nWaypointDecorWall", 0); // number of wall decor spawnpoints
        SetLocalInt(oArea, "nWaypointDecorOpen", 0); // number of open area decor spawnpoints
        SetLocalInt(oArea, "nWaypointPuzzle", 0); // number of puzzle spawnpoints
        SetLocalInt(oArea, "nWaypointTrap", 0); // number of trap spawnpoints
        SetLocalInt(oArea, "nGenericDoor", 0); // number of generic doorways in this level

        // get the first object in area
        object oObject = GetFirstObjectInArea(oArea);

        // object tag
        string sTag;

        // door configuration variable
        int nDoor;

        // new door configuration
        int nDoorType;

        // number of staircases currently
        int nStairsUp;
        int nStairsDown;

        // waypoint counter
        int nWaypoint;

        // cycle through objects in the area
        while (oObject != OBJECT_INVALID)
        {
            // get the tag of the current
            sTag = GetTag(oObject);


            //////////////////////////////////////////////////////////////////
            // Doors                                                        //
            //////////////////////////////////////////////////////////////////

            if (sTag == "ID1_STATIC_DOOR")
            {
                // get the current number of doors
                nDoor = GetLocalInt(oArea, "nDoor");

                // add the new door to the door configuration
                nDoorType = GetDoorType(oObject);
                nDoor += nDoorType;

                // set the new door configuration
                SetLocalInt(oArea, "nDoor", nDoor);

                // add a link to the door object
                if (nDoorType == ID1_DOOR_NORTH)
                {
                    DebugMessage("  Setting North door.");
                    SetLocalObject(oArea, "oDoorNorth", oObject);
                } else if (nDoorType == ID1_DOOR_EAST)
                {
                    DebugMessage("  Setting East door.");
                    SetLocalObject(oArea, "oDoorEast", oObject);
                } else if (nDoorType == ID1_DOOR_SOUTH)
                {
                    DebugMessage("  Setting South door.");
                    SetLocalObject(oArea, "oDoorSouth", oObject);
                } else if (nDoorType == ID1_DOOR_WEST)
                {
                    DebugMessage("  Setting West door.");
                    SetLocalObject(oArea, "oDoorWest", oObject);
                }
            }


            //////////////////////////////////////////////////////////////////
            // Staircases                                                   //
            //////////////////////////////////////////////////////////////////

            // staircase up
            if (sTag == "ID1_STATIC_STAIRSUP")
            {
                DebugMessage("  Adding Up Staircase.");

                nStairsUp = GetLocalInt(oArea, "nStairsUp");
                SetLocalInt(oArea, "nStairsUp", nStairsUp + 1);
                SetLocalObject(oArea, "oStairsUp", oObject);
            }

            // staircase down
            if (sTag == "ID1_STATIC_STAIRSDOWN")
            {
                DebugMessage("  Adding Down Staircase.");

                nStairsDown = GetLocalInt(oArea, "nStairsDown");
                SetLocalInt(oArea, "nStairsDown", nStairsDown + 1);
                SetLocalObject(oArea, "oStairsDown", oObject);
            }


            //////////////////////////////////////////////////////////////////
            // Waypoints                                                    //
            //////////////////////////////////////////////////////////////////

            // encounter waypoint
            if (sTag == "ID1_STATIC_WP_ENCOUNTER")
            {
                // increment number of waypoints of this type
                nWaypoint = GetLocalInt(oArea, "nWaypointEncounter");
                nWaypoint++;
                SetLocalInt(oArea, "nWaypointEncounter", nWaypoint);
                DebugMessage("  Storing waypoint at WaypointEncounter" + IntToString(nWaypoint));

                // record a link to this waypoint
                SetLocalObject(oArea, "oWaypointEncounter" + IntToString(nWaypoint), oObject);
                SetLocalInt(oObject, "nNumber", nWaypoint);
            }

            // boss waypoint
            if (sTag == "ID1_STATIC_WP_BOSS")
            {
                // increment number of waypoints of this type
                nWaypoint = GetLocalInt(oArea, "nWaypointBoss");
                nWaypoint++;
                SetLocalInt(oArea, "nWaypointBoss", nWaypoint);
                DebugMessage("  Storing waypoint at WaypointBoss" + IntToString(nWaypoint));

                // record a link to this waypoint
                SetLocalObject(oArea, "oWaypointBoss" + IntToString(nWaypoint), oObject);
                SetLocalInt(oObject, "nNumber", nWaypoint);
            }

            // boss guard waypoint
            if (sTag == "ID1_STATIC_WP_BOSS_GUARD")
            {
                // increment number of waypoints of this type
                nWaypoint = GetLocalInt(oArea, "nWaypointBossGuard");
                nWaypoint++;
                SetLocalInt(oArea, "nWaypointBossGuard", nWaypoint);
                DebugMessage("  Storing waypoint at WaypointBossGuard" + IntToString(nWaypoint));

                // record a link to this waypoint
                SetLocalObject(oArea, "oWaypointBossGuard" + IntToString(nWaypoint), oObject);
                SetLocalInt(oObject, "nNumber", nWaypoint);
            }

            // treasure waypoint
            if (sTag == "ID1_STATIC_WP_TREASURE")
            {
                // increment number of waypoints of this type
                nWaypoint = GetLocalInt(oArea, "nWaypointTreasure");
                nWaypoint++;
                SetLocalInt(oArea, "nWaypointTreasure", nWaypoint);
                DebugMessage("  Storing waypoint at WaypointTreasure" + IntToString(nWaypoint));

                // record a link to this waypoint
                SetLocalObject(oArea, "oWaypointTreasure" + IntToString(nWaypoint), oObject);
                SetLocalInt(oObject, "nNumber", nWaypoint);
            }

            // secret waypoint
            if (sTag == "ID1_STATIC_WP_SECRET")
            {
                // increment number of waypoints of this type
                nWaypoint = GetLocalInt(oArea, "nWaypointSecret");
                nWaypoint++;
                SetLocalInt(oArea, "nWaypointSecret", nWaypoint);
                DebugMessage("  Storing waypoint at WaypointSecret" + IntToString(nWaypoint));

                // record a link to this waypoint
                SetLocalObject(oArea, "oWaypointSecret" + IntToString(nWaypoint), oObject);
                SetLocalInt(oObject, "nNumber", nWaypoint);
            }

            // secret treasure waypoint
            if (sTag == "ID1_STATIC_WP_SECRET_TREASURE")
            {
                // increment number of waypoints of this type
                nWaypoint = GetLocalInt(oArea, "nWaypointSecretTreasure");
                nWaypoint++;
                SetLocalInt(oArea, "nWaypointSecretTreasure", nWaypoint);
                DebugMessage("  Storing waypoint at WaypointSecretTreasure" + IntToString(nWaypoint));

                // record a link to this waypoint
                SetLocalObject(oArea, "oWaypointSecretTreasure" + IntToString(nWaypoint), oObject);
                SetLocalInt(oObject, "nNumber", nWaypoint);
            }

            // secret encounter waypoint
            if (sTag == "ID1_STATIC_WP_SECRET_ENCOUNTER")
            {
                // increment number of waypoints of this type
                nWaypoint = GetLocalInt(oArea, "nWaypointSecretEncounter");
                nWaypoint++;
                SetLocalInt(oArea, "nWaypointSecretEncounter", nWaypoint);
                DebugMessage("  Storing waypoint at WaypointSecretEncounter" + IntToString(nWaypoint));

                // record a link to this waypoint
                SetLocalObject(oArea, "oWaypointSecretEncounter" + IntToString(nWaypoint), oObject);
                SetLocalInt(oObject, "nNumber", nWaypoint);
            }

            // secret door waypoint
            if (sTag == "ID1_STATIC_WP_SECRET_DOOR")
            {
                // increment number of waypoints of this type
                nWaypoint = GetLocalInt(oArea, "nWaypointSecretDoor");
                nWaypoint++;
                SetLocalInt(oArea, "nWaypointSecretDoor", nWaypoint);
                DebugMessage("  Storing waypoint at WaypointSecretDoor" + IntToString(nWaypoint));

                // record a link to this waypoint
                SetLocalObject(oArea, "oWaypointSecretDoor" + IntToString(nWaypoint), oObject);
                SetLocalInt(oObject, "nNumber", nWaypoint);
            }

            // plot waypoint
            if (sTag == "ID1_STATIC_WP_PLOT")
            {
                // increment number of waypoints of this type
                nWaypoint = GetLocalInt(oArea, "nWaypointPlot");
                nWaypoint++;
                SetLocalInt(oArea, "nWaypointPlot", nWaypoint);
                DebugMessage("  Storing waypoint at WaypointPlot" + IntToString(nWaypoint));

                // record a link to this waypoint
                SetLocalObject(oArea, "oWaypointPlot" + IntToString(nWaypoint), oObject);
                SetLocalInt(oObject, "nNumber", nWaypoint);
            }

            // wall decor waypoint
            if (sTag == "ID1_STATIC_WP_DECOR_WALL")
            {
                // increment number of waypoints of this type
                nWaypoint = GetLocalInt(oArea, "nWaypointDecorWall");
                nWaypoint++;
                SetLocalInt(oArea, "nWaypointDecorWall", nWaypoint);
                DebugMessage("  Storing waypoint at WaypointDecorWall" + IntToString(nWaypoint));

                // record a link to this waypoint
                SetLocalObject(oArea, "oWaypointDecorWall" + IntToString(nWaypoint), oObject);
                SetLocalInt(oObject, "nNumber", nWaypoint);
            }

            // open decor waypoint
            if (sTag == "ID1_STATIC_WP_DECOR_OPEN")
            {
                // increment number of waypoints of this type
                nWaypoint = GetLocalInt(oArea, "nWaypointDecorOpen");
                nWaypoint++;
                SetLocalInt(oArea, "nWaypointDecorOpen", nWaypoint);
                DebugMessage("  Storing waypoint at WaypointDecorOpen" + IntToString(nWaypoint));

                // record a link to this waypoint
                SetLocalObject(oArea, "oWaypointDecorOpen" + IntToString(nWaypoint), oObject);
                SetLocalInt(oObject, "nNumber", nWaypoint);
            }

            // puzzle waypoint
            if (sTag == "ID1_STATIC_WP_PUZZLE")
            {
                // increment number of waypoints of this type
                nWaypoint = GetLocalInt(oArea, "nWaypointPuzzle");
                nWaypoint++;
                SetLocalInt(oArea, "nWaypointPuzzle", nWaypoint);
                DebugMessage("  Storing waypoint at WaypointPuzzle" + IntToString(nWaypoint));

                // record a link to this waypoint
                SetLocalObject(oArea, "oWaypointPuzzle" + IntToString(nWaypoint), oObject);
                SetLocalInt(oObject, "nNumber", nWaypoint);
            }

            // trap waypoint
            if (sTag == "ID1_STATIC_WP_TRAP")
            {
                // increment number of waypoints of this type
                nWaypoint = GetLocalInt(oArea, "nWaypointTrap");
                nWaypoint++;
                SetLocalInt(oArea, "nWaypointTrap", nWaypoint);
                DebugMessage("  Storing waypoint at WaypointTrap" + IntToString(nWaypoint));

                // record a link to this waypoint
                SetLocalObject(oArea, "oWaypointTrap" + IntToString(nWaypoint), oObject);
                SetLocalInt(oObject, "nNumber", nWaypoint);
            }

            // generic doors
            if (sTag == "ID1_STATIC_GENERICDOOR")
            {
                // increment number of generic doors
                nWaypoint = GetLocalInt(oArea, "nGenericDoor");
                nWaypoint++;
                SetLocalInt(oArea, "nGenericDoor", nWaypoint);
                DebugMessage("  Storing door at GenericDoor" + IntToString(nWaypoint));

                // record a link to this generic door
                SetLocalObject(oArea, "oGenericDoor" + IntToString(nWaypoint), oObject);
                SetLocalInt(oObject, "nNumber", nWaypoint);

                AssignCommand(oObject, SetIsDestroyable(FALSE, FALSE, FALSE));
            }


            // get next object in area
            oObject = GetNextObjectInArea(oArea);
        }


        // check area type and store it
        int nAreaType = GetAreaType(oArea);
        DebugMessage("  Final area type " + IntToString(nAreaType));


        // area variable string
        string sAreaVar;

        if ((nAreaType > 0) && (nAreaType <= 15))
        {
            // separate the up and down staircases from the normal list
            if (GetLocalInt(oArea, "nStairsUp") > 0)
            {
                // assemble lists of the different types of doors
                sAreaVar = "nStairsUpAreaType" + IntToString(nAreaType);
                DebugMessage("  Added " + sAreaVar);
            } else if (GetLocalInt(oArea, "nStairsDown") > 0)
            {
                // assemble lists of the different types of doors
                sAreaVar = "nStairsDownAreaType" + IntToString(nAreaType);
                DebugMessage("  Added " + sAreaVar);
            } else
            {
                // assemble lists of the different types of doors
                sAreaVar = "nNoStairsAreaType" + IntToString(nAreaType);
                DebugMessage("  Added " + sAreaVar);
            }

            // add another instance of this area type to the list
            int nAreaCount = GetLocalInt(GetModule(), sAreaVar);
            nAreaCount++;
            SetLocalInt(GetModule(), sAreaVar, nAreaCount);

            // store a reference to the area in the list
            SetLocalInt(GetModule(), sAreaVar + "_" + IntToString(nAreaCount), nAreas);
        }

        DebugMessage("  Added area " + IntToString(nAreas) + " to " + sAreaVar);
        DebugMessage("  " + IntToString(GetLocalInt(oArea, "nDoor")) + " doors, " + IntToString(GetLocalInt(oArea, "nStairsUp")) + " stairs up, " + IntToString(GetLocalInt(oArea, "nStairsDown")) + " stairs down.");
    }

    int nMicroDead = GetLocalInt(GetModule(), "nMicroDead");
    nMicroDead++;
    SetLocalInt(GetModule(), "nMicroDead", nMicroDead);

    DestroyObject(OBJECT_SELF);
}

