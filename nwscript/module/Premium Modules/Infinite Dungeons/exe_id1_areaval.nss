//:://////////////////////////////////////////////////////////////
//:: exe_id1_areagen                                            //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    This script examines the next area in the queue and tries to
    fit the best available area into that location. If one is not
    available that includes all the necessary exits, it finds an
    area with first less, then more exits than necessary in order
    to best fit that location. Once completed, it passes the queue
    to the next processor or terminates if the queue is exhausted.
    Once the queue is completed and the area generated, it starts
    the generation of the staircases required for the level.
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
#include "inc_id1_gen"

// object GetNextCPU()
#include "inc_id1_utility"


//////////////////////////////////////////////////////////////////
// Function Prototypes                                          //
//////////////////////////////////////////////////////////////////

// Get the mandatory and possible exits for the area at this
// location and determine if an area like exists. If it does,
// return it, otherwise return the next most suitable area. If
// none exists, return OBJECT_INVALID.
// - iX: The X location of the area.
// - iY: The Y location of the area.
// - iLevel: The level of the dungeon on which this area is
//           located.
// * Returns a valid area or OBJECT_INVALID is there is none.
object GetValidArea(int iX, int iY, int iLevel, string sTileset, int nDistance, object oDungeon);

// Take a number from 1 to 4, and return the door type that
// corresponds (1 = north, 2 = east, 3 = south, 4 = west).
// - iDoorNumber: The random number determining which door is
//                returned.
// * Returns ID1_DOOR_NORTH, ID1_DOOR_EAST, ID1_DOOR_SOUTH or ID1_DOOR_WEST based
//   on the number passed into the function.
int ReturnDoorType(int iDoorNumber);


//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    DebugMessage("");

    object oTempHolder = GetLocalObject(GetModule(), "oTempHolder");

    int nValidProcess = GetLocalInt(oTempHolder, "nValidProcess");

    int nDistance = GetLocalInt(GetModule(), "nValidProcessDistance");
    int nX = GetLocalInt(oTempHolder, "nX");
    int nY = GetLocalInt(oTempHolder, "nY");
    int nLevel = GetLocalInt(oTempHolder, "nLevel");
    string sTileset = GetLocalString(oTempHolder, "sTileset");
    object oDungeon = GetLocalObject(oTempHolder, "oDungeon");
    DebugMessage("  Valid X = " + IntToString(nX) + ", Y = " + IntToString(nY) + ", level = " + IntToString(nLevel) + ", tileset = " + sTileset);

    if (nValidProcess == 0) // prearea selection work
    {
        //////////////////////////////////////////////////////
        // Finding mandatory and impossible exit directions //
        //////////////////////////////////////////////////////

        int nNorth = TRUE; // if a door is possible in this direction
        int nEast = TRUE;
        int nSouth = TRUE;
        int nWest = TRUE;

        int nDoorType = 0;
        int nDoorMax = 0;
        int nDoorMin = 0;

        object oArea;

        // is the north exit leading off the map?
        if (IsAreaOutOfBounds(nX, nY + 1))
        {
            nNorth = FALSE;
        } else // if the area is on the map
        {
            // get the area to the north
            oArea = GetAreaByCoordinates(nX, nY + 1, nLevel, oDungeon);

            // if the area already exists
            if (oArea != OBJECT_INVALID)
            {
                // if the room doesnt have a south door
                if (HasDoorType(GetAreaType(oArea), ID1_DOOR_SOUTH) == FALSE)
                {
                    // a north door here cannot be made
                    nNorth = FALSE;
                } else
                {
                    // add the north door to this area
                    nDoorMax++;
                    nDoorMin++;
                    nDoorType += ID1_DOOR_NORTH;
                }
            } else
            {
                DebugMessage("No area to north.");

                // possible exit
                nDoorMax++;
            }
        }

        // is the east exit leading off the map?
        if (IsAreaOutOfBounds(nX + 1, nY))
        {
            nEast = FALSE;
        } else // if the area is on the map
        {
            // get the area to the east
            oArea = GetAreaByCoordinates(nX + 1, nY, nLevel, oDungeon);

            // if the area already exists
            if (oArea != OBJECT_INVALID)
            {
                // if the room doesnt have a west door
                if (HasDoorType(GetAreaType(oArea), ID1_DOOR_WEST) == FALSE)
                {
                    // an east door here cannot be made
                    nEast = FALSE;
                } else
                {
                    // add the east door to this area
                    nDoorMax++;
                    nDoorMin++;
                    nDoorType += ID1_DOOR_EAST;
                }
            } else
            {
                DebugMessage("No area to east.");

                // possible exit
                nDoorMax++;
            }
        }

        // is the south exit leading off the map?
        if (IsAreaOutOfBounds(nX, nY - 1))
        {
            nSouth = FALSE;
        } else // if the area is on the map
        {
            // get the area to the south
            oArea = GetAreaByCoordinates(nX, nY - 1, nLevel, oDungeon);

            // if the area already exists
            if (oArea != OBJECT_INVALID)
            {
                // if the room doesnt have a north door
                if (HasDoorType(GetAreaType(oArea), ID1_DOOR_NORTH) == FALSE)
                {
                    // a south door here cannot be made
                    nSouth = FALSE;
                } else
                {
                    // add the south door to this area
                    nDoorMax++;
                    nDoorMin++;
                    nDoorType += ID1_DOOR_SOUTH;
                }
            } else
            {
                DebugMessage("No area to south.");

                // possible exit
                nDoorMax++;
            }
        }

        // is the west exit leading off the map?
        if (IsAreaOutOfBounds(nX - 1, nY))
        {
            nWest = FALSE;
        } else // if the area is on the map
        {
            // get the area to the west
            oArea = GetAreaByCoordinates(nX - 1, nY, nLevel, oDungeon);

            // if the area already exists
            if (oArea != OBJECT_INVALID)
            {
                // if the room doesnt have an east door
                if (HasDoorType(GetAreaType(oArea), ID1_DOOR_EAST) == FALSE)
                {
                    // a west door here cannot be made
                    nWest = FALSE;
                } else
                {
                    // add the north door to this area
                    nDoorMax++;
                    nDoorMin++;
                    nDoorType += ID1_DOOR_WEST;
                }
            } else
            {
                DebugMessage("No area to west.");

                // possible exit
                nDoorMax++;
            }
        }

        ///////////////////////////////////
        // Generate the random area type //
        ///////////////////////////////////

        // get a random area type
        int nType = FALSE;
        int nDoor = 0;
        int nDoorTemp = nDoorType;
        int nOneExitChance = GetModuleFlagValue(ID1_FLAG_DUNGEON_ONE_EXIT);
        int nTwoExitChance = GetModuleFlagValue(ID1_FLAG_DUNGEON_TWO_EXIT);
        int nThreeExitChance = GetModuleFlagValue(ID1_FLAG_DUNGEON_THREE_EXIT);
        int nFourExitChance = GetModuleFlagValue(ID1_FLAG_DUNGEON_FOUR_EXIT);

        // make sure that there is at least some chance of each of the areas
        if (nOneExitChance < 1)
        {
            nOneExitChance = 1;
        }

        if (nTwoExitChance < 1)
        {
            nTwoExitChance = 1;
        }

        if (nThreeExitChance < 1)
        {
            nThreeExitChance = 1;
        }

        if (nFourExitChance < 1)
        {
            nFourExitChance = 1;
        }

        // get the random area configuration
        int nRandom = Random(nOneExitChance + nTwoExitChance + nThreeExitChance + nFourExitChance) + 1;

        // determine the number of doors that were randomly determined
        int nNum;
        if (nRandom < nOneExitChance)
        {
            nNum = 1;
        } else if (nRandom < (nOneExitChance + nTwoExitChance))
        {
            nNum = 2;
        } else if (nRandom < (nOneExitChance + nTwoExitChance + nThreeExitChance))
        {
            nNum = 3;
        } else
        {
            nNum = 4;
        }

        // make sure it doesn't assign too many doors
        if (nNum > nDoorMax)
        {
            nNum = nDoorMax;
        }

        // get the number of doors that still need to be created
        nNum -= nDoorMin;

        // determine each of the new doors, if any
        while (nNum > 0)
        {
            // pick a door
            nRandom = Random(4) + 1;

            // cycle through doors until you find one that works
            nType = FALSE;
            while (nType == FALSE)
            {
                nDoor = ReturnDoorType(nRandom);

                if (HasDoorType(nDoorTemp, nDoor) == FALSE)
                {
                    if ((nRandom == 1) && (nNorth == TRUE))
                    {
                        // add the door
                        nDoorTemp += ID1_DOOR_NORTH;

                        // one less door to look for
                        nNum--;

                        // break out of loop
                        nType = TRUE;
                    } else if ((nRandom == 2) && (nEast == TRUE))
                    {
                        // add the door
                        nDoorTemp += ID1_DOOR_EAST;

                        // one less door to look for
                        nNum--;

                        // break out of loop
                        nType = TRUE;
                    } else if ((nRandom == 3) && (nSouth == TRUE))
                    {
                        // add the door
                        nDoorTemp += ID1_DOOR_SOUTH;

                        // one less door to look for
                        nNum--;

                        // break out of loop
                        nType = TRUE;
                    } else if ((nRandom == 4) && (nWest == TRUE))
                    {
                        // add the door
                        nDoorTemp += ID1_DOOR_WEST;

                        // one less door to look for
                        nNum--;

                        // break out of loop
                        nType = TRUE;
                    } else
                    {
                        nRandom++;

                        // loop the door you're searching at
                        if (nRandom > 4)
                        {
                            nRandom = 1;
                        }
                    }
                } else
                {
                    nRandom++;

                    // loop the door you're searching at
                    if (nRandom > 4)
                    {
                        nRandom = 1;
                    }
                }
            }
        }

        DebugMessage("Initial unused area of type " + IntToString(nDoorTemp));
        SetLocalInt(oTempHolder, "nDoorMandatory", nDoorType);
        SetLocalInt(oTempHolder, "nDoorType", nDoorTemp);

        SetLocalInt(oTempHolder, "nValidProcess", 1);
        DelayCommand(0.01, ExecuteScript("exe_id1_areaval", GetNextCPU()));
    } else if (nValidProcess == 1) // check if exact area is found
    {
        int nDoorType = GetLocalInt(oTempHolder, "nDoorType");

        DebugMessage("Checking for unused area of type " + IntToString(nDoorType));

        // check to see if there is an unused area like this
        object oArea = GetUnusedArea(sTileset, nDistance, nDoorType, nLevel, ID1_NO_STAIRS, oDungeon);

        if (oArea != OBJECT_INVALID)
        {
            DebugMessage("Acceptable area found.");

            DestroyObject(oTempHolder);

            // return the acceptable area
            SetLocalObject(GetModule(), "oAreaProcessArea", oArea);
            DelayCommand(0.01, ExecuteScript("exe_id1_areagen", GetNextCPU()));
        } else
        {
            DebugMessage("No acceptable area found.");

            // find mandatory doors that have to be in this area
            int bNorthMandatory = FALSE;
            int bEastMandatory = FALSE;
            int bSouthMandatory = FALSE;
            int bWestMandatory = FALSE;

            int nDoorMandatory = GetLocalInt(oTempHolder, "nDoorMandatory");

            // must this area have a north door?
            if (HasDoorType(nDoorMandatory, ID1_DOOR_NORTH))
            {
                bNorthMandatory = TRUE;
            }

            // must this area have an east door?
            if (HasDoorType(nDoorMandatory, ID1_DOOR_EAST))
            {
                bEastMandatory = TRUE;
            }

            // must this area have a south door?
            if (HasDoorType(nDoorMandatory, ID1_DOOR_SOUTH))
            {
                bSouthMandatory = TRUE;
            }

            // must this area have a west door?
            if (HasDoorType(nDoorMandatory, ID1_DOOR_WEST))
            {
                bWestMandatory = TRUE;
            }
            SetLocalInt(oTempHolder, "bNorthMandatory", bNorthMandatory);
            SetLocalInt(oTempHolder, "bEastMandatory", bEastMandatory);
            SetLocalInt(oTempHolder, "bSouthMandatory", bSouthMandatory);
            SetLocalInt(oTempHolder, "bWestMandatory", bWestMandatory);

            // find how many doors it currently has
            int nDoorNum = 0;

            // does it have a north door?
            if (HasDoorType(nDoorType, ID1_DOOR_NORTH))
            {
                nDoorNum++;
            }

            // does it have an east door?
            if (HasDoorType(nDoorType, ID1_DOOR_EAST))
            {
                nDoorNum++;
            }

            // does it have a south door?
            if (HasDoorType(nDoorType, ID1_DOOR_SOUTH))
            {
                nDoorNum++;
            }

            // does it have a west door?
            if (HasDoorType(nDoorType, ID1_DOOR_WEST))
            {
                nDoorNum++;
            }
            SetLocalInt(oTempHolder, "nDoorNum", nDoorNum);

            // set the initial number of areas in this type
            int nAreaNum = 0;
            if (nDoorNum == 1)
            {
                nAreaNum = 4;
            } else if (nDoorNum == 2)
            {
                nAreaNum = 6;
            } else if (nDoorNum == 3)
            {
                nAreaNum = 4;
            } else if (nDoorNum == 4)
            {
                nAreaNum = 1;
            }
            SetLocalInt(oTempHolder, "nAreaNum", nAreaNum);
            int nStartArea = Random(nAreaNum) + 1;
            SetLocalInt(oTempHolder, "nCurrentArea", nStartArea);
            SetLocalInt(oTempHolder, "nStartArea", nStartArea);
            SetLocalInt(oTempHolder, "bMandatory", FALSE);

            // set up and down variables
            SetLocalInt(oTempHolder, "bUp", FALSE);
            SetLocalInt(oTempHolder, "bDown", FALSE);

            // check near door types
            SetLocalInt(oTempHolder, "nValidProcess", 2);
            DelayCommand(0.01, ExecuteScript("exe_id1_areaval", GetNextCPU()));
        }
    } else if (nValidProcess == 2) // read in a specific area number and record it
    {
        // get the number of doors for this room
        int nDoorNum = GetLocalInt(oTempHolder, "nDoorNum");
        DebugMessage("  Door number " + IntToString(nDoorNum));

        int nAreaNum = GetLocalInt(oTempHolder, "nAreaNum");
        int nCurrentArea = GetLocalInt(oTempHolder, "nCurrentArea");
        int nStartArea = GetLocalInt(oTempHolder, "nStartArea");
        DebugMessage("  On area " + IntToString(nCurrentArea) + " of " + IntToString(nAreaNum));

        int bNorthMandatory = GetLocalInt(oTempHolder, "bNorthMandatory");
        int bEastMandatory = GetLocalInt(oTempHolder, "bEastMandatory");
        int bSouthMandatory = GetLocalInt(oTempHolder, "bSouthMandatory");
        int bWestMandatory = GetLocalInt(oTempHolder, "bWestMandatory");

        int bMandatory = GetLocalInt(oTempHolder, "bMandatory");

        int bUp = GetLocalInt(oTempHolder, "bUp");
        int bDown = GetLocalInt(oTempHolder, "bDown");

        // check to see if the mandatory list has not been dealt with
        object oArea = OBJECT_INVALID;
        if (bMandatory == FALSE)
        {
            // create mandatory list (areas that have ALL the mandatory doors)
            if (nDoorNum == 1) // area has only 1 door
            {
                if ((bNorthMandatory == TRUE) && (nCurrentArea == 1))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 1, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if ((bEastMandatory == TRUE) && (nCurrentArea == 2))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 2, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if ((bSouthMandatory == TRUE) && (nCurrentArea == 3))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 4, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if ((bWestMandatory == TRUE) && (nCurrentArea == 4))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 8, nLevel, ID1_NO_STAIRS, oDungeon);
                }
            } else if (nDoorNum == 2) // area has only 2 doors
            {
                if (((bNorthMandatory == TRUE) && (bEastMandatory == TRUE)) && (nCurrentArea == 1))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 3, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if (((bNorthMandatory == TRUE) && (bSouthMandatory == TRUE)) && (nCurrentArea == 2))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 5, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if (((bEastMandatory == TRUE) && (bSouthMandatory == TRUE)) && (nCurrentArea == 3))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 6, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if (((bNorthMandatory == TRUE) && (bWestMandatory == TRUE)) && (nCurrentArea == 4))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 9, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if (((bEastMandatory == TRUE) && (bWestMandatory == TRUE)) && (nCurrentArea == 5))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 10, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if (((bSouthMandatory == TRUE) && (bWestMandatory == TRUE)) && (nCurrentArea == 6))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 12, nLevel, ID1_NO_STAIRS, oDungeon);
                }
            } else if (nDoorNum == 3) // area has only 3 doors
            {
                if (((bNorthMandatory == TRUE) && (bEastMandatory == TRUE) && (bSouthMandatory == TRUE)) && (nCurrentArea == 1))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 7, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if (((bNorthMandatory == TRUE) && (bEastMandatory == TRUE) && (bWestMandatory == TRUE)) && (nCurrentArea == 2))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 11, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if (((bNorthMandatory == TRUE) && (bSouthMandatory == TRUE) && (bWestMandatory == TRUE)) && (nCurrentArea == 3))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 13, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if (((bEastMandatory == TRUE) && (bSouthMandatory == TRUE) && (bWestMandatory == TRUE)) && (nCurrentArea == 4))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 14, nLevel, ID1_NO_STAIRS, oDungeon);
                }
            } else // area has 4 doors
            {
                oArea = GetUnusedArea(sTileset, nDistance, 15, nLevel, ID1_NO_STAIRS, oDungeon);
            }
        } else // if mandatory is true
        {
            // create non-mandatory list (area with only some of the mandatory doors)
            if (nDoorNum == 2) // area has 2 doors
            {
                if (((bNorthMandatory == TRUE) || (bEastMandatory == TRUE)) && (nCurrentArea == 1))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 3, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if (((bNorthMandatory == TRUE) || (bSouthMandatory == TRUE)) && (nCurrentArea == 2))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 5, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if (((bEastMandatory == TRUE) || (bSouthMandatory == TRUE)) && (nCurrentArea == 3))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 6, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if (((bNorthMandatory == TRUE) || (bWestMandatory == TRUE)) && (nCurrentArea == 4))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 9, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if (((bEastMandatory == TRUE) || (bWestMandatory == TRUE)) && (nCurrentArea == 5))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 10, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if (((bSouthMandatory == TRUE) || (bWestMandatory == TRUE)) && (nCurrentArea == 6))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 12, nLevel, ID1_NO_STAIRS, oDungeon);
                }
            } else if (nDoorNum == 3) // area has 3 doors
            {
                if (((bNorthMandatory == TRUE) || (bEastMandatory == TRUE) || (bSouthMandatory == TRUE)) && (nCurrentArea == 1))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 7, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if (((bNorthMandatory == TRUE) || (bEastMandatory == TRUE) || (bWestMandatory == TRUE)) && (nCurrentArea == 2))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 11, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if (((bNorthMandatory == TRUE) || (bSouthMandatory == TRUE) || (bWestMandatory == TRUE)) && (nCurrentArea == 3))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 13, nLevel, ID1_NO_STAIRS, oDungeon);
                }

                if (((bEastMandatory == TRUE) || (bSouthMandatory == TRUE) || (bWestMandatory == TRUE)) && (nCurrentArea == 4))
                {
                    oArea = GetUnusedArea(sTileset, nDistance, 14, nLevel, ID1_NO_STAIRS, oDungeon);
                }
            }
        }

        // if a useable area was found
        if (oArea != OBJECT_INVALID)
        {
            DebugMessage("  Useable area found.");

            DestroyObject(oTempHolder);

            // set the area, destroy the temporary object and return
            SetLocalObject(GetModule(), "oAreaProcessArea", oArea);
            DelayCommand(0.01, ExecuteScript("exe_id1_areagen", GetNextCPU()));
        } else // no useable area was found
        {
            DebugMessage("  No area found.");

            // increment and loop at end of list
            nCurrentArea++;
            if (nCurrentArea > nAreaNum)
            {
                nCurrentArea = 1;
            }

            // if the entire list has been read through
            if (nCurrentArea == nStartArea)
            {
                // if size was 1, you can't get any smaller
                if (nDoorNum == 1)
                {
                    bDown = TRUE;

                    // if larger hasn't been done, go larger
                    if (bUp == FALSE)
                    {
                        nDoorNum++;
                    }
                } else if ((nDoorNum == 2) || (nDoorNum == 3)) // size 2 or 3
                {
                    // mark mandatory as done if it hasn't been
                    if (bMandatory == FALSE)
                    {
                        bMandatory = TRUE;
                    } else // if mandatory was already done
                    {
                        bMandatory = FALSE;

                        // adjust size based on whether you're going larger or smaller
                        if (bDown == FALSE)
                        {
                            nDoorNum--;
                        } else
                        {
                            nDoorNum++;
                        }
                    }
                } else // if size is 4, you can't get any larger
                {
                    bUp = TRUE;

                    // if you can get smaller, go for it
                    if (bDown == FALSE)
                    {
                        nDoorNum--;
                    }
                }

                // if both up and down are done
                if ((bDown == TRUE) && (bUp == TRUE))
                {
                    DebugMessage("  All areas examined.");

                    DestroyObject(oTempHolder);

                    // destroy the temporary object and return
                    SetLocalObject(GetModule(), "oAreaProcessArea", OBJECT_INVALID);
                    DelayCommand(0.01, ExecuteScript("exe_id1_areagen", GetNextCPU()));
                } else
                {
                    // set new variables and rerun self
                    SetLocalInt(oTempHolder, "nCurrentArea", nCurrentArea);
                    SetLocalInt(oTempHolder, "bUp", bUp);
                    SetLocalInt(oTempHolder, "bDown", bDown);
                    SetLocalInt(oTempHolder, "bMandatory", bMandatory);
                    SetLocalInt(oTempHolder, "nDoorNum", nDoorNum);
                    DelayCommand(0.01, ExecuteScript("exe_id1_areaval", GetNextCPU()));
                }
            } else
            {
                // set new area and rerun self
                SetLocalInt(oTempHolder, "nCurrentArea", nCurrentArea);
                DelayCommand(0.01, ExecuteScript("exe_id1_areaval", GetNextCPU()));
            }
        }
    }
}

// Take a number from 1 to 4, and return the door type that
// corresponds (1 = north, 2 = east, 3 = south, 4 = west).
// - iDoorNumber: The random number determining which door is
//                returned.
// * Returns ID1_DOOR_NORTH, ID1_DOOR_EAST, ID1_DOOR_SOUTH or ID1_DOOR_WEST based
//   on the number passed into the function.
int ReturnDoorType(int nDoorNumber)
{
    switch (nDoorNumber)
    {
        case 1:
            return ID1_DOOR_NORTH;

            break;

        case 2:
            return ID1_DOOR_EAST;

            break;

        case 3:
            return ID1_DOOR_SOUTH;

            break;

        case 4:
            return ID1_DOOR_WEST;

            break;
    }

    return 0;
}

