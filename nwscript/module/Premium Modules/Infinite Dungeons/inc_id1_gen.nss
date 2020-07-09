//:://////////////////////////////////////////////////////////////
//:: inc_id1_gen                                                //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    This is a generic include script for functions used
    throughout the level generation process.
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: July 2005                                      //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Include Files                                                //
//////////////////////////////////////////////////////////////////

#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_utility"
#include "inc_id1_score"


//////////////////////////////////////////////////////////////////
// Constant Definitions                                         //
//////////////////////////////////////////////////////////////////

// door positions
const int ID1_DOOR_NORTH = 1;
const int ID1_DOOR_EAST = 2;
const int ID1_DOOR_SOUTH = 4;
const int ID1_DOOR_WEST = 8;

// stairs
const int ID1_NO_STAIRS = 0;
const int ID1_UP_STAIRS = 1;
const int ID1_DOWN_STAIRS = 2;
const int ID1_BOSS_AREA = 3;


//////////////////////////////////////////////////////////////////
// Function Prototypes                                          //
//////////////////////////////////////////////////////////////////

// Returns the door configuration of the area (0-15).
// - oArea: The door whose facing is to be determined.
// * Returns a number between 0 and 15 which represents the door
//   configuration of the area. Each door is represented by a
//   number which are all added to form a total. (north = 1,
//   east = 2, south = 4, west = 8)
int GetAreaType(object oArea);

// Return the area located at the specified coordinates on the
// specified level.
// - iX: The X location of the area.
// - iY: The Y location of the area.
// - iLevel: The level of the dungeon on which this area is
//           located.
// * Returns the area located at the specified coordinates. If no
//   area exists, it returns OBJECT_INVALID.
object GetAreaByCoordinates(int iX, int iY, int iLevel, object oDungeon = OBJECT_INVALID);

// Return the area located at the specified coordinates on the
// specified level.
// - iX: The X location of the area.
// - iY: The Y location of the area.
// - iLevel: The level of the dungeon on which this area is
//           located.
// * Returns the ID of the area located at the specified coordinates.
//   If no area exists, it returns 0.
int GetAreaIDByCoordinates(int iX, int iY, int iLevel, object oDungeon = OBJECT_INVALID);

int GetAreaNumByCoordinates(int iX, int iY, int iLevel, object oDungeon = OBJECT_INVALID);


// Check to see if the given door configuration number contains a
// door of the specified type (ID1_DOOR_NORTH, ID1_DOOR_EAST,
// ID1_DOOR_SOUTH, ID1_DOOR_WEST).
// - iDoorNumber: The door configuration number to be examined.
// - iDoorType: The type of door that is being searched for
//              (ID1_DOOR_NORTH, ID1_DOOR_EAST, ID1_DOOR_SOUTH,
//              ID1_DOOR_WEST).
// * Returns TRUE or FALSE.
int HasDoorType(int iDoorNumber, int iDoorType);

// Check to see if the specified location is already in the queue
// and, if not, add it to the queue.
// - iX: The X location to be added to the queue.
// - iY: The Y location to be added to the queue.
// * No return value.
void AddToQueue(int iX, int iY, string sTileset);

// Check to see if the specified location is already in the queue.
// - iX: The X location to be added to the queue.
// - iY: The Y location to be added to the queue.
// * Returns TRUE or FALSE based on if it finds this location in
//   the queue.
int PresentInQueue(int iX, int iY);

// Checks to see if the coordinates given are between 1 and the
// maximum X and Y values for this level.
// - iX: The X location to be checked.
// - iY: The Y location to be checked.
// * Returns TRUE or FALSE.
int IsAreaOutOfBounds(int iX, int iY);

// Checks to see if an area with the given door configuration is
// available in a specified tileset, on the specified level, with
// the specified staircase requirement.
// - iTileset: The tileset of the required area.
// - iDoorType: The door configuration of the area (0-15).
// - iLevel: The level on which the area will be used.
// - iStairs: The staircase requirement of this area
//            (ID1_NO_STAIRS, ID1_UP_STAIRS, ID1_DOWN_STAIRS).
// * Return an available area of the required type. If no such
//   area exists, it returns OBJECT_INVALID.
object GetUnusedArea(string sTileset, int nDistance, int iDoorType, int iLevel, int iStairs = ID1_NO_STAIRS, object oDungeon = OBJECT_INVALID);

// Determine the facing of a door and return its type
// (ID1_DOOR_NORTH, ID1_DOOR_EAST, ID1_DOOR_SOUTH, ID1_DOOR_WEST).
// - oDoor: The door whose facing is to be determined.
// * Returns ID1_DOOR_NORTH, ID1_DOOR_EAST, ID1_DOOR_SOUTH or
//   ID1_DOOR_WEST based on the facing of the object passed into
//   the function. If it does not have one of the specified
//   facings, return 0.
int GetDoorType(object oDoor);

// Add a specific area's details to the dungeon object.
// - sDungeonArea: The string including this area's place in the
//                 dungeon's area list.
// - oArea: The area to be added.
// - oDungeon: The dungeon to which the area is being added.
// * No return value.
void AddAreaToDungeon(string sDungeonArea, object oArea, object oDungeon);

// Explore the given area for the given PC.
// - oPC: The player who is exploring the area.
// - oArea: The area which is being explored.
// - nState: The state to which the area is to be set to. (1 =
//           hard explore, 2 = current area, 3 = party explore, 4 = soft explore)
//void ExploreArea(object oPC, int nArea, object oDungeon = OBJECT_INVALID, int nState = 1);

// Return the explored state of the given area for the given PC.
// - oPC: The player who is being queried.
// - oArea: The area to be examined.
// * Returns the explored state of the given area for the given
//   PC. (1 = hard explore, 2 = current area, 3 = party explore, 4 = soft explore)

// Check the doors exit of the specified area and add each exit to
// the queue.
// - iX: The X location of the area.
// - iY: The Y location of the area.
// - iLevel: The level of the dungeon on which this area is
//           located.
// * No return value.
void GenerateArea(int iX, int iY, int iLevel, string sTileset);

// Check to see if this location is out of bounds or if it has
// already been assigned an area.
// - iX: The X location of the area.
// - iY: The Y location of the area.
// - iLevel: The level of the dungeon on which this area is
//           located.
// * Returns TRUE or FALSE as to if this lcoation can be used for
//   a new area.
int IsAreaUseable(int iX, int iY, int iLevel);

// Sets the specified location on the specified level to be the
// passed area.
// - nX: The X location of the area.
// - nY: The Y location of the area.
// - nCurrentLevel: The level of the dungeon on which this area is
//           located.
// - oArea: The area object to be assigned to that location.
// - oDungeon: The dungeon object where the area is being set.
//             Defaults to OBJECT_INVALID.
// * No return value.
void SetArea(int nX, int nY, int nAreaIdentifier, int nLevel, object oDungeon);

// Removes the area from a given level of the dungeon.
// - nCurrentLevel: The level of the dungeon on which this area is
//           located.
// - oArea: The area object to be removed from the level.
// - oDungeon: The dungeon object the area is being removed from.
//             Defaults to OBJECT_INVALID.
// * No return value.
void RemoveArea(int nCurrentLevel, int nAreaIdentifier, object oDungeon);

void AddAdjacentAreas(int nX, int nY, int nCurrentLevel, object oDungeon = OBJECT_INVALID);

string GetAreaTileset(object oArea);

int GetTilesetDistance(string sTileset, object oArea, object oDungeon = OBJECT_INVALID);


// For testing purposes only.

// Show the number of each type of area, based on door
// configuration, in the specified level.
// - iLevel: The level to see the statistics of.
// * No return value.
void DisplayLevelStats(int iLevel);

// Return the door of the specified type in the specified area.
// - oArea: The area being searched for the specific door.
// - iDoorType: The type of door that is being searched for
//              (ID1_DOOR_NORTH, ID1_DOOR_EAST, ID1_DOOR_SOUTH,
//              ID1_DOOR_WEST).
// * Returns the door object with the required facing. If no such
//   door exists, it returns OBJECT_INVALID.
object GetDirectionDoor(object oArea, int iDoorType);

// Searches through the areas used in the dungeon, and returns the
// number this area occupies in that list.
// - nAreaIdentifier: The unique identifying number of the area
// - oDungeon: The dungeon object with all the dungeon information
//             on it.
// * Returns the number place of this area in the area list.
int GetAreaListNumber(int nAreaIdentifier, object oDungeon);

//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

// Returns the door configuration of the area (0-15).
// - oArea: The door whose facing is to be determined.
// * Returns a number between 0 and 15 which represents the door
//   configuration of the area. Each door is represented by a
//   number which are all added to form a total. (north = 1,
//   east = 2, south = 4, west = 8)
int GetAreaType(object oArea)
{
    return GetLocalInt(oArea, "nDoor");
}

// Return the area located at the specified coordinates on the
// specified level.
// - iX: The X location of the area.
// - iY: The Y location of the area.
// - iLevel: The level of the dungeon on which this area is
//           located.
// * Returns the area located at the specified coordinates. If no
//   area exists, it returns OBJECT_INVALID.
object GetAreaByCoordinates(int iX, int iY, int iLevel, object oDungeon = OBJECT_INVALID)
{
    int nAreaIdentifier = GetAreaIDByCoordinates(iX, iY, iLevel, oDungeon);

    DebugMessage("Returned area ID " + IntToString(nAreaIdentifier) + ".");

    // return the stored variable (OBJECT_INVALID if it doesn't exist)
    return GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nAreaIdentifier));
}

// Return the area located at the specified coordinates on the
// specified level.
// - iX: The X location of the area.
// - iY: The Y location of the area.
// - iLevel: The level of the dungeon on which this area is
//           located.
// * Returns the ID of the area located at the specified
//   coordinates. If no area exists, it returns 0.
int GetAreaIDByCoordinates(int iX, int iY, int iLevel, object oDungeon = OBJECT_INVALID)
{
    int nAreaNum = GetAreaNumByCoordinates(iX, iY, iLevel, oDungeon);

    if (oDungeon == OBJECT_INVALID)
    {
        oDungeon = GetCurrentDungeon();
    }

    DebugMessage("Grabbing variable nArea" + IntToString(nAreaNum) + "Identifier.");
    return GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "Identifier");
}

int GetAreaNumByCoordinates(int iX, int iY, int iLevel, object oDungeon = OBJECT_INVALID)
{
    // generate the area variable name
    string sTemp = "nLevel" + IntToString(iLevel) + "Area" + IntToString(iX) + "_" + IntToString(iY);

    if (oDungeon == OBJECT_INVALID)
    {
        oDungeon = GetCurrentDungeon();
    }

    DebugMessage("Grabbing variable " + sTemp + ".");
    return GetLocalInt(oDungeon, sTemp);
}


// Check to see if the given door configuration number contains a
// door of the specified type (ID1_DOOR_NORTH, ID1_DOOR_EAST, ID1_DOOR_SOUTH,
// ID1_DOOR_WEST).
// - iDoorNumber: The door configuration number to be examined.
// - iDoorType: The type of door that is being searched for
//              (ID1_DOOR_NORTH, ID1_DOOR_EAST, ID1_DOOR_SOUTH, ID1_DOOR_WEST).
// * Returns TRUE or FALSE.
int HasDoorType(int iDoorNumber, int iDoorType)
{
    // if the area has a west door
    if (iDoorNumber >= 8)
    {
        // if searching for the west door
        if (iDoorType == ID1_DOOR_WEST)
        {
            return TRUE;
        }

        // remove the possibility of a west door
        iDoorNumber -= 8;
    }

    // if the area has a south door
    if (iDoorNumber >= 4)
    {
        // if searching for the south door
        if (iDoorType == ID1_DOOR_SOUTH)
        {
            return TRUE;
        }

        // remove the possibility of a south door
        iDoorNumber -= 4;
    }

    // if the area has an east door
    if (iDoorNumber >= 2)
    {
        // if searching for the east door
        if (iDoorType == ID1_DOOR_EAST)
        {
            return TRUE;
        }

        // remove the possibility of an east door
        iDoorNumber -= 2;
    }

    // if the area has a north door
    if (iDoorNumber >= 1)
    {
        // if searching for the north door
        if (iDoorType == ID1_DOOR_NORTH)
        {
            return TRUE;
        }
    }

    return FALSE;
}

// Check to see if the specified location is already in the queue
// and, if not, add it to the queue.
// - iX: The X location to be added to the queue.
// - iY: The Y location to be added to the queue.
// * No return value.
void AddToQueue(int iX, int iY, string sTileset)
{
    int iQueueX;
    int iQueueY;

    // find the current max of the queue
    int iQueueMax = GetLocalInt(GetModule(), "nQueueMax");

    if (PresentInQueue(iX, iY))
    {
        return;
    }

    // if not, add to queue and increment the queue
    iQueueMax++;
    SetLocalInt(GetModule(), "nQueueMax", iQueueMax);

    SetLocalInt(GetModule(), "nQueue" + IntToString(iQueueMax) + "X", iX);
    SetLocalInt(GetModule(), "nQueue" + IntToString(iQueueMax) + "Y", iY);
    SetLocalString(GetModule(), "sQueue" + IntToString(iQueueMax) + "Tileset", sTileset);
}

// Check to see if the specified location is already in the queue.
// - iX: The X location to be added to the queue.
// - iY: The Y location to be added to the queue.
// * Returns TRUE or FALSE based on if it finds this location in
//   the queue.
int PresentInQueue(int iX, int iY)
{
    int iQueueX;
    int iQueueY;

    // find the current max of the queue
    int iQueueMax = GetLocalInt(GetModule(), "nQueueMax");

    // check the queue to see if its there already
    int iCurrent = 1;

    // cycle through the queue until found
    while (iCurrent <= iQueueMax)
    {
        // get the variables from the queue
        iQueueX = GetLocalInt(GetModule(), "nQueue" + IntToString(iCurrent) + "X");
        iQueueY = GetLocalInt(GetModule(), "nQueue" + IntToString(iCurrent) + "Y");

        if ((iQueueX == iX) && (iQueueY == iY))
        {
            return TRUE;
        }

        // cycle to next member of the queue
        iCurrent++;
    }

    return FALSE;
}

// Checks to see if the coordinates given are between 1 and the
// maximum X and Y values for this level.
// - iX: The X location to be checked.
// - iY: The Y location to be checked.
// * Returns TRUE or FALSE.
int IsAreaOutOfBounds(int iX, int iY)
{
    object oDungeon = GetCurrentDungeon();
    int iMaxX = GetLocalInt(oDungeon, "nMaxX");
    int iMaxY = GetLocalInt(oDungeon, "nMaxY");

    // check to see if its out of bounds
    if ((iX < 1) || (iX > iMaxX) || (iY < 1) || (iY > iMaxY))
    {
        return TRUE;
    }

    return FALSE;
}

// Checks to see if an area with the given door configuration is
// available in a specified tileset, on the specified level, with
// the specified staircase requirement.
// - iTileset: The tileset of the required area.
// - iDoorType: The door configuration of the area (0-15).
// - iLevel: The level on which the area will be used.
// - iStairs: The staircase requirement of this area (ID1_NO_STAIRS,
//            ID1_UP_STAIRS, ID1_DOWN_STAIRS).
// * Return an available area of the required type. If no such
//   area exists, it returns OBJECT_INVALID.
object GetUnusedArea(string sTileset, int nDistance, int iDoorType, int iLevel, int iStairs = ID1_NO_STAIRS, object oDungeon = OBJECT_INVALID)
{
    // cycle through all areas and classify them by tileset and number of doors and waypoints in them
    int iNum = 1;
    int iMax = 0;
    int iCurrent;
    int nStart;
    int bTemp = FALSE;
    int iTemp2 = 0;
    int nDistanceStored = 4;
    int nDistanceTemp = 4;
    int nAreaIdentifierStored;

    // determine the list to search based on what type of stairs are in the room
    string sTemp2;
    if (iStairs == ID1_UP_STAIRS)
    {
        sTemp2 = "nStairsUpAreaType" + IntToString(iDoorType);
    } else if (iStairs == ID1_DOWN_STAIRS)
    {
        sTemp2 = "nStairsDownAreaType" + IntToString(iDoorType);
    } else if (iStairs == ID1_BOSS_AREA)
    {
        sTemp2 = "nBossAreaType" + IntToString(iDoorType);
    } else
    {
        sTemp2 = "nNoStairsAreaType" + IntToString(iDoorType);
    }

    string sTemp3 = "";

    object oArea;

    // get maximum number of that type of area
    iMax = GetLocalInt(GetModule(), sTemp2);

    // start at a random position in the list
    iCurrent = Random(iMax) + 1;
    nStart = iCurrent;

    DebugMessage("  There are " + IntToString(iMax) + " areas of type " + sTemp2);

    // if there are available areas
    if (iMax > 0)
    {
        DebugMessage("  Selected position " + IntToString(iCurrent) + " in the list.");
        DebugMessage("  Searching for tileset " + sTileset);

        if (oDungeon == OBJECT_INVALID)
        {
            oDungeon = GetCurrentDungeon();
        }

        int nAreaIdentifier;
        int nAreaNum;



        // EDIT: check first one
        // copied from inside loop
        DebugMessage("    Getting area " + sTemp2 + "_" + IntToString(iCurrent));

        // get area identifier
        nAreaIdentifier = GetLocalInt(GetModule(), sTemp2 + "_" + IntToString(iCurrent));
        DebugMessage("      Identifier: " + IntToString(nAreaIdentifier));

        // find area number on dungeon
        nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");
        DebugMessage("      Area Number: " + IntToString(nAreaNum));

        // get used state
        sTemp3 = "bArea" + IntToString(nAreaNum) + "Level" + IntToString(iLevel) + "Used";
        int bTemp2 = GetLocalInt(oDungeon, sTemp3);
        DebugMessage("      " + sTemp3 + " = " + IntToString(bTemp2));

        // if the area hasn't been used on this level
        if (bTemp2 == FALSE)
        {
            DebugMessage("        " + sTemp3 + " has not been used.");

            // check to see if it is a closer match to the desired area
            oArea = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nAreaIdentifier));
            nDistanceTemp = GetTilesetDistance(sTileset, oArea, oDungeon);
            DebugMessage("        Distance is " + IntToString(nDistanceTemp));

            if (nDistanceTemp < nDistanceStored)
            {
                nDistanceStored = nDistanceTemp;
                nAreaIdentifierStored = nAreaIdentifier;

                // if it is within the required distance
                if (nDistanceTemp <= nDistance)
                {
                    bTemp = TRUE;
                } else
                {
                    iCurrent++;

                    // loop if the end of the list is reached
                    if (iCurrent > iMax)
                    {
                        iCurrent = 1;
                    }
                }
            } else
            {
                iCurrent++;

                // loop if the end of the list is reached
                if (iCurrent > iMax)
                {
                    iCurrent = 1;
                }
            }
        } else
        {
            iCurrent++;

            // loop if the end of the list is reached
            if (iCurrent > iMax)
            {
                iCurrent = 1;
            }
        }




        // search through all in list (looping), until you find one or come back where you started
        while ((iCurrent != nStart) && (bTemp == FALSE))
        {
            DebugMessage("  Getting area " + sTemp2 + "_" + IntToString(iCurrent));

            // get area identifier
            nAreaIdentifier = GetLocalInt(GetModule(), sTemp2 + "_" + IntToString(iCurrent));
            DebugMessage("    Identifier: " + IntToString(nAreaIdentifier));

            // find area number on dungeon
            nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");
            DebugMessage("    Area Number: " + IntToString(nAreaNum));

            // get used state
            sTemp3 = "bArea" + IntToString(nAreaNum) + "Level" + IntToString(iLevel) + "Used";
            int bTemp2 = GetLocalInt(oDungeon, sTemp3);
            DebugMessage("      " + sTemp3 + " = " + IntToString(bTemp2));

            // if the area hasn't been used on this level
            if (GetLocalInt(oDungeon, sTemp3) == FALSE)
            {
                DebugMessage("        " + sTemp3 + " has not been used.");

                // check to see if it is a closer match to the desired area
                oArea = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nAreaIdentifier));
                nDistanceTemp = GetTilesetDistance(sTileset, oArea, oDungeon);
                DebugMessage("        Distance is " + IntToString(nDistanceTemp));

                if (nDistanceTemp < nDistanceStored)
                {
                    nDistanceStored = nDistanceTemp;
                    nAreaIdentifierStored = nAreaIdentifier;

                    // if it is within the required distance
                    if (nDistanceTemp <= nDistance)
                    {
                        bTemp = TRUE;
                    } else
                    {
                        iCurrent++;

                        // loop if the end of the list is reached
                        if (iCurrent > iMax)
                        {
                            iCurrent = 1;
                        }
                    }
                } else
                {
                    iCurrent++;

                    // loop if the end of the list is reached
                    if (iCurrent > iMax)
                    {
                        iCurrent = 1;
                    }
                }
            } else
            {
                iCurrent++;

                // loop if the end of the list is reached
                if (iCurrent > iMax)
                {
                    iCurrent = 1;
                }
            }
        }

        // if an area was found
        if (nDistanceStored <= nDistance)
        {
            return GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nAreaIdentifierStored));
        } else
        {
            return OBJECT_INVALID;
        }
    } else // no available areas
    {
        return OBJECT_INVALID;
    }
}

// Determine the facing of a door and return its type (ID1_DOOR_NORTH,
// ID1_DOOR_EAST, ID1_DOOR_SOUTH, ID1_DOOR_WEST).
// - oDoor: The door whose facing is to be determined.
// * Returns ID1_DOOR_NORTH, ID1_DOOR_EAST, ID1_DOOR_SOUTH or ID1_DOOR_WEST based
//   on the facing of the object passed into the function. If it
//   does not have one of the specified facings, return 0.
int GetDoorType(object oDoor)
{
    // get the facing of the door
    float fFacing = GetFacing(oDoor);

    if ((fFacing >= 45.0) && (fFacing < 135.0)) // north
    {
        return ID1_DOOR_NORTH;
    } else if ((fFacing >= 315.0) || (fFacing < 45.0)) // east
    {
        return ID1_DOOR_EAST;
    } else if ((fFacing >= 225.0) && (fFacing < 315.0)) // south
    {
        return ID1_DOOR_SOUTH;
    } else if ((fFacing >= 135.0) && (fFacing < 225.0)) // west
    {
        return ID1_DOOR_WEST;
    }

    return 0;
}

// Add a specific area's details to the dungeon object.
// - sDungeonArea: The string including this area's place in the
//                 dungeon's area list.
// - oArea: The area to be added.
// - oDungeon: The dungeon to which the area is being added.
// * No return value.
void AddAreaToDungeon(string sDungeonArea, object oArea, object oDungeon)
{
    // tileset
    string sTileset = GetTilesetResRef(oArea);
    SetLocalString(oDungeon, "s" + sDungeonArea + "Tileset", sTileset);

    DebugMessage("Setting s" + sDungeonArea + "Tileset to " + sTileset);
    DebugMessage("Setting n" + sDungeonArea + " variables.");

    // door
    SetLocalInt(oDungeon, "n" + sDungeonArea + "Door", GetLocalInt(oArea, "nDoor"));

    // stairs
    SetLocalInt(oDungeon, "n" + sDungeonArea + "StairsUp", GetLocalInt(oArea, "nStairsUp"));
    SetLocalInt(oDungeon, "n" + sDungeonArea + "StairsDown", GetLocalInt(oArea, "nStairsDown"));

    // number waypoints
    SetLocalInt(oDungeon, "n" + sDungeonArea + "WaypointEncounter", GetLocalInt(oArea, "nWaypointEncounter"));
    SetLocalInt(oDungeon, "n" + sDungeonArea + "WaypointBoss", GetLocalInt(oArea, "nWaypointBoss"));
    SetLocalInt(oDungeon, "n" + sDungeonArea + "WaypointBossGuard", GetLocalInt(oArea, "nWaypointBossGuard"));
    SetLocalInt(oDungeon, "n" + sDungeonArea + "WaypointTreasure", GetLocalInt(oArea, "nWaypointTreasure"));
    SetLocalInt(oDungeon, "n" + sDungeonArea + "WaypointSecret", GetLocalInt(oArea, "nWaypointSecret"));
    SetLocalInt(oDungeon, "n" + sDungeonArea + "WaypointSecretTreasure", GetLocalInt(oArea, "nWaypointSecretTreasure"));
    SetLocalInt(oDungeon, "n" + sDungeonArea + "WaypointSecretEncounter", GetLocalInt(oArea, "nWaypointSecretEncounter"));
    SetLocalInt(oDungeon, "n" + sDungeonArea + "WaypointSecretDoor", GetLocalInt(oArea, "nWaypointSecretDoor"));
    SetLocalInt(oDungeon, "n" + sDungeonArea + "WaypointPlot", GetLocalInt(oArea, "nWaypointPlot"));
    SetLocalInt(oDungeon, "n" + sDungeonArea + "WaypointDecorWall", GetLocalInt(oArea, "nWaypointDecorWall"));
    SetLocalInt(oDungeon, "n" + sDungeonArea + "WaypointDecorOpen", GetLocalInt(oArea, "nWaypointDecorOpen"));
    SetLocalInt(oDungeon, "n" + sDungeonArea + "WaypointPuzzle", GetLocalInt(oArea, "nWaypointPuzzle"));
    SetLocalInt(oDungeon, "n" + sDungeonArea + "WaypointTrap", GetLocalInt(oArea, "nWaypointTrap"));
    SetLocalInt(oDungeon, "n" + sDungeonArea + "GenericDoor", GetLocalInt(oArea, "nGenericDoor"));
}

// Explore the given area for the given PC.
// - oPC: The player who is exploring the area.
// - oArea: The area which is being explored.
// - nState: The state to which the area is to be set to. (1 =
//           hard explore, 2 = party explore, 3 = soft explore)
//void ExploreArea(object oPC, int nArea, object oDungeon = OBJECT_INVALID, int nState = 1)

// Check to see if this location is out of bounds or if it has
// already been assigned an area.
// - iX: The X location of the area.
// - iY: The Y location of the area.
// - nCurrentLevel: The level of the dungeon on which this area is
//           located.
// * Returns TRUE or FALSE as to if this lcoation can be used for
//   a new area.
int IsAreaUseable(int iX, int iY, int nCurrentLevel)
{
    // check to see if the area is out of bounds
    if (IsAreaOutOfBounds(iX, iY))
    {
        return FALSE;
    }

    // check to see if the area already is assigned
    if (GetAreaByCoordinates(iX, iY, nCurrentLevel) != OBJECT_INVALID)
    {
        return FALSE;
    }

    return TRUE;
}

// Check the doors exit of the specified area and add each exit to
// the queue.
// - iX: The X location of the area.
// - iY: The Y location of the area.
// - nCurrentLevel: The level of the dungeon on which this area is
//           located.
// * No return value.
void GenerateArea(int iX, int iY, int nCurrentLevel, string sTileset)
{
    // get the area
    object oArea = GetAreaByCoordinates(iX, iY, nCurrentLevel);

    if (oArea == OBJECT_INVALID)
    {
        DebugMessage("Did not return a valid area in GenerateArea.");
    }

    // look at the doors this area has
    int iDoorType = GetAreaType(oArea);
    string sAreaTag = GetTag(oArea);

    DebugMessage("Area " + sAreaTag + " is type " + IntToString(iDoorType) + " and tileset " + sTileset);

    // does this area have a north door
    if (GetLocalObject(oArea, "oDoorNorth") != OBJECT_INVALID)
    {
        DebugMessage("Found north door");

        // check to see if the north area is unused
        if (IsAreaUseable(iX, iY + 1, nCurrentLevel))
        {
            // add the north area to the queue
            AddToQueue(iX, iY + 1, sTileset);
        }
    }

    // does this area have an east door
    if (GetLocalObject(oArea, "oDoorEast") != OBJECT_INVALID)
    {
        DebugMessage("Found east door");

        // check to see if the east area is unused
        if (IsAreaUseable(iX + 1, iY, nCurrentLevel))
        {
            // add the east area to the queue
            AddToQueue(iX + 1, iY, sTileset);
        }
    }

    // does this area have a south door
    if (GetLocalObject(oArea, "oDoorSouth") != OBJECT_INVALID)
    {
        DebugMessage("Found south door");

        // check to see if the south area is unused
        if (IsAreaUseable(iX, iY - 1, nCurrentLevel))
        {
            // add the south area to the queue
            AddToQueue(iX, iY - 1, sTileset);
        }
    }

    // does this area have a west door
    if (GetLocalObject(oArea, "oDoorWest") != OBJECT_INVALID)
    {
        DebugMessage("Found west door");

        // check to see if the west area is unused
        if (IsAreaUseable(iX - 1, iY, nCurrentLevel))
        {
            // add the west area to the queue
            AddToQueue(iX - 1, iY, sTileset);
        }
    }
}

// Sets the specified location on the specified level to be the
// passed area.
// - nX: The X location of the area.
// - nY: The Y location of the area.
// - nCurrentLevel: The level of the dungeon on which this area is
//           located.
// - oArea: The area object to be assign to that location.
// * No return value.
void SetArea(int nX, int nY, int nAreaIdentifier, int nCurrentLevel, object oDungeon)
{
    DebugMessage("Setting area.");

    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");
    DebugMessage("Area number " + IntToString(nAreaNum) + " with identifier " + IntToString(nAreaIdentifier));

    // if the area does not exist in the list
    if (nAreaNum == 0)
    {
        DebugMessage("Area is not already in list. Appending.");

        nAreaNum = GetLocalInt(oDungeon, "nAreaNum");

        // add this area on to the end of the area list
        nAreaNum++;
        SetLocalInt(oDungeon, "nAreaNum", nAreaNum);

        // add the new number and identifier to the list
        SetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "Identifier", nAreaIdentifier);
        SetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area", nAreaNum);
        DebugMessage("Setting nArea" + IntToString(nAreaNum) + "Identifier to " + IntToString(nAreaIdentifier));
        DebugMessage("Setting nIdentifier" + IntToString(nAreaIdentifier) + "Area to " + IntToString(nAreaNum));

        // add new area statistics to dungeon
        object oArea = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nAreaIdentifier));
        AddAreaToDungeon("Area" + IntToString(nAreaNum), oArea, oDungeon);
    } else
    {
        DebugMessage("Area is already in list.");
    }

    string sDungeon = "Area" + IntToString(nAreaNum) + "Level" + IntToString(nCurrentLevel);

    // mark that are has been used in this level
    SetLocalInt(oDungeon, "b" + sDungeon + "Used", TRUE);

    // record the coordinates of this area on the level in the area information
    SetLocalInt(oDungeon, "n" + sDungeon + "X", nX);
    SetLocalInt(oDungeon, "n" + sDungeon + "Y", nY);

    string sTemp = "nLevel" + IntToString(nCurrentLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY);

    // record the coordinates of this area on the level in the level information
    SetLocalInt(oDungeon, sTemp, nAreaNum);
    DebugMessage("Setting " + sTemp + " to be area " + IntToString(nAreaNum) + ".");


    int nTemp = GetLocalInt(oDungeon, sTemp);
    DebugMessage("Retrieved value is " + IntToString(nTemp) + ".");

    nTemp = GetAreaIDByCoordinates(nX, nY, nCurrentLevel);
    DebugMessage("GetAreaIDByCoordinates value is " + IntToString(nTemp) + ".");

}

// Removes the area from a given level of the dungeon.
// - nCurrentLevel: The level of the dungeon on which this area is
//           located.
// - oArea: The area object to be removed from the level.
// - oDungeon: The dungeon object the area is being removed from.
//             Defaults to OBJECT_INVALID.
// * No return value.
void RemoveArea(int nCurrentLevel, int nAreaIdentifier, object oDungeon)
{
    DebugMessage("Removing area.");

    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

    DebugMessage("Area number " + IntToString(nAreaNum) + " with identifier " + IntToString(nAreaIdentifier));

    string sDungeon = "Area" + IntToString(nAreaNum) + "Level" + IntToString(nCurrentLevel);

    // mark that are has been used in this level
    SetLocalInt(oDungeon, "b" + sDungeon + "Used", FALSE);

    // record the coordinates of this area on the level in the area information
    DeleteLocalInt(oDungeon, "n" + sDungeon + "X");
    DeleteLocalInt(oDungeon, "n" + sDungeon + "Y");
}

void AddAdjacentAreas(int nX, int nY, int nCurrentLevel, object oDungeon = OBJECT_INVALID)
{
    object oArea = GetAreaByCoordinates(nX, nY, nCurrentLevel);
    object oArea2;
    string sTileset = GetAreaTileset(oArea);

    if (oDungeon == OBJECT_INVALID)
    {
        oDungeon = GetCurrentDungeon();
    }

    // if there is an area north, add it
    if (GetLocalObject(oArea, "oDoorNorth") != OBJECT_INVALID)
    {
        DebugMessage("There is a north door.");

        oArea2 = GetAreaByCoordinates(nX, nY + 1, nCurrentLevel);

        if (oArea2 != OBJECT_INVALID)
        {
            DebugMessage("There is an area north.");

            if (GetLocalObject(oArea2, "oDoorSouth") != OBJECT_INVALID)
            {
                DebugMessage("Adding area to North to emergency queue.");

                AddToQueue(nX, nY + 1, sTileset);
            }
        }
    }

    // if there is an area east, add it
    if (GetLocalObject(oArea, "oDoorEast") != OBJECT_INVALID)
    {
        DebugMessage("There is a east door.");

        oArea2 = GetAreaByCoordinates(nX + 1, nY, nCurrentLevel);

        if (oArea2 != OBJECT_INVALID)
        {
            DebugMessage("There is an area east.");

            if (GetLocalObject(oArea2, "oDoorWest") != OBJECT_INVALID)
            {
                DebugMessage("Adding area to East to emergency queue.");

                AddToQueue(nX + 1, nY, sTileset);
            }
        }
    }

    // if there is an area south, add it
    if (GetLocalObject(oArea, "oDoorSouth") != OBJECT_INVALID)
    {
        DebugMessage("There is a south door.");

        oArea2 = GetAreaByCoordinates(nX, nY - 1, nCurrentLevel);

        if (oArea2 != OBJECT_INVALID)
        {
            DebugMessage("There is an area south.");

            if (GetLocalObject(oArea2, "oDoorNorth") != OBJECT_INVALID)
            {
                DebugMessage("Adding area to South to emergency queue.");

                AddToQueue(nX, nY - 1, sTileset);
            }
        }
    }

    // if there is an area west, add it
    if (GetLocalObject(oArea, "oDoorWest") != OBJECT_INVALID)
    {
        DebugMessage("There is a west door.");

        oArea2 = GetAreaByCoordinates(nX - 1, nY, nCurrentLevel);

        if (oArea2 != OBJECT_INVALID)
        {
            DebugMessage("There is an area west.");

            if (GetLocalObject(oArea2, "oDoorEast") != OBJECT_INVALID)
            {
                DebugMessage("Adding area to West to emergency queue.");

                AddToQueue(nX - 1, nY, sTileset);
            }
        }
    }
}

string GetAreaTileset(object oArea)
{
    return GetLocalString(oArea, "sTileset");
}

int GetTilesetDistance(string sTileset, object oArea, object oDungeon = OBJECT_INVALID)
{
    // if no tileset is specified
    if (sTileset == "")
    {
        // anything is acceptable
        return 0;
    } else // if a tileset was specified
    {
        if (oDungeon == OBJECT_INVALID)
        {
            oDungeon = GetCurrentDungeon();
        }

        if (oArea == OBJECT_INVALID)
        {
            DebugMessage("          Area does not exist.");
        }

        // get the tileset of the current area
        string sAreaTileset = GetTilesetResRef(oArea);

        DebugMessage("          Getting distance between tileset " + sTileset + " and area " + GetTag(oArea) + " of resref " + sAreaTileset);

        // get tileset number for adjacent tileset
        int nTileset = GetLocalInt(GetModule(), "nTileset_" + sTileset);

        // get tileset number for area tileset
        int nAreaTileset = GetLocalInt(GetModule(), "nTileset_" + sAreaTileset);

        DebugMessage("          nTileset is " + IntToString(nTileset));
        DebugMessage("          nAreaTileset is " + IntToString(nAreaTileset));

        string sTheme;
        int nTheme;
        int nDistance;
        int bPresent;

        // if the area tileset is in a primary theme, return the distance
        int nPrimaryThemeNum = GetLocalInt(oDungeon, "nPrimaryTheme");

        DebugMessage("          Checking " + IntToString(nPrimaryThemeNum) + " primary themes.");

        int nPrimaryTheme = 1;
        while (nPrimaryTheme <= nPrimaryThemeNum)
        {
            // get the primary theme number
            sTheme = GetLocalString(oDungeon, "sPrimaryTheme" + IntToString(nPrimaryTheme) + "Name");
            nTheme = GetLocalInt(GetModule(), "nTheme_" + sTheme);

            DebugMessage("            Primary theme " + IntToString(nPrimaryTheme) + " is " + sTheme + " which is number " + IntToString(nTheme));

            // check to see if this tileset is in the theme
            bPresent = GetLocalInt(GetModule(), "bTileset" + IntToString(nAreaTileset) + "Theme" + IntToString(nTheme));

            DebugMessage("            bTileset" + IntToString(nAreaTileset) + "Theme" + IntToString(nTheme) + " = " + IntToString(bPresent));

            // is this tileset in the theme
            if (bPresent == TRUE)
            {
                // get distance
                nDistance = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "Distance" + IntToString(nAreaTileset));

                DebugMessage("              Tileset is distance " + IntToString(nDistance));

                return nDistance;
            } else
            {
                DebugMessage("              Tileset is not in theme. Variable bTileset" + IntToString(nAreaTileset) + "Theme" + IntToString(nTheme));
            }

            // examine the next theme
            nPrimaryTheme++;
        }

        // if the area tileset is in a primary theme, return the distance
        int nSecondaryThemeNum = GetLocalInt(oDungeon, "nSecondaryTheme");

        DebugMessage("          Checking " + IntToString(nSecondaryThemeNum) + " secondary themes.");

        int nSecondaryTheme = 1;
        while (nSecondaryTheme <= nSecondaryThemeNum)
        {
            // get the primary theme number
            sTheme = GetLocalString(oDungeon, "sSecondaryTheme" + IntToString(nSecondaryTheme) + "Name");
            nTheme = GetLocalInt(GetModule(), "nTheme_" + sTheme);

            DebugMessage("            Secondary theme " + IntToString(nSecondaryTheme) + " is " + sTheme + " which is number " + IntToString(nTheme));

            // is this tileset in the theme
            if (GetLocalInt(GetModule(), "bTileset" + IntToString(nAreaTileset) + "Theme" + IntToString(nTheme)) == TRUE)
            {
                // get distance
                nDistance = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "Distance" + IntToString(nAreaTileset));

                DebugMessage("              Tileset is distance " + IntToString(nDistance) + ", but is secondary.");

                return nDistance + 1;
            } else
            {
                DebugMessage("              Tileset is not in theme. Variable bTileset" + IntToString(nAreaTileset) + "Theme" + IntToString(nTheme));
            }

            // examine the next theme
            nSecondaryTheme++;
        }

        // if the the area tileset was not in a theme, return an invalid distance
        return 4;
    }
}


// For testing purposes only.

// Show the number of each type of area, based on door
// configuration, in the specified level.
// - iLevel: The level to see the statistics of.
// * No return value.
void DisplayLevelStats(int iLevel)
{
    int iTemp;
    int iTemp2;
    string sTemp = "";

    // display all types used
    for (iTemp = 1; iTemp <= 15; iTemp++)
    {
        sTemp = "nLevel" + IntToString(iLevel) + "StatsType" + IntToString(iTemp);

        iTemp2 = GetLocalInt(GetModule(), sTemp);
    }
}

// Return the door of the specified type in the specified area.
// - oArea: The area being searched for the specific door.
// - iDoorType: The type of door that is being searched for
//              (ID1_DOOR_NORTH, ID1_DOOR_EAST, ID1_DOOR_SOUTH, ID1_DOOR_WEST).
// * Returns the door object with the required facing. If no such
//   door exists, it returns OBJECT_INVALID.
object GetDirectionDoor(object oArea, int iDoorType)
{
    // search through different doors
    int iNum = 0;
    object oDoor = GetFirstObjectInArea(oArea);

    // while there is a valid object
    while (GetIsObjectValid(oDoor))
    {
        // if it is a door
        if (GetTag(oDoor) == "Door")
        {
            // get the facing of the door
            float fFacing = GetFacing(oDoor);

            // if it's facing north, and a north door is being sought (north is 90.0)
            if ((iDoorType == ID1_DOOR_NORTH) && ((fFacing >= 45.0) && (fFacing < 135.0)))
            {
                return oDoor;
            }

            // if it's facing east, and an east door is being sought (east is 0.0)
            if ((iDoorType == ID1_DOOR_EAST) && ((fFacing >= 315.0) || (fFacing < 45.0)))
            {
                return oDoor;
            }

            // if it's facing south, and a south door is being sought (south is 270.0)
            if ((iDoorType == ID1_DOOR_SOUTH) && ((fFacing >= 225.0) && (fFacing < 315.0)))
            {
                return oDoor;
            }

            // if it's facing west, and a west door is being sought (west is 180.0)
            if ((iDoorType == ID1_DOOR_WEST) && ((fFacing >= 135.0) && (fFacing < 225.0)))
            {
                return oDoor;
            }
        }

        // cycle to next door
        iNum++;
        oDoor = GetNextObjectInArea(oArea);
    }

    return OBJECT_INVALID;
}

// Searches through the areas used in the dungeon, and returns the
// number this area occupies in that list.
// - nAreaIdentifier: The unique identifying number of the area
// - oDungeon: The dungeon object with all the dungeon information
//             on it.
// * Returns the number place of this area in the area list.
int GetAreaListNumber(int nAreaIdentifier, object oDungeon)
{
    int nAreaNum = GetLocalInt(oDungeon, "nAreaNum");
    int nCurrentArea = 1;
    int nFoundArea = 0;
    int nCurrentAreaIdentifier;
    string sIndentifierVariable;

    while ((nCurrentArea <= nAreaNum) && (nFoundArea == 0))
    {
        sIndentifierVariable = "nArea" + IntToString(nAreaNum) + "Identifier";
        nCurrentAreaIdentifier = GetLocalInt(GetModule(), sIndentifierVariable);

        if (nCurrentAreaIdentifier == nAreaIdentifier)
        {
            nFoundArea = nCurrentArea;
        }

        nCurrentArea++;
    }

    return nFoundArea;
}

//void main(){}

