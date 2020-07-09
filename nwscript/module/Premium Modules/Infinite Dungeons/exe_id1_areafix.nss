//:://////////////////////////////////////////////////////////////
//:: exe_id1_areafix                                            //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    This script runs as an emergency procedure when there aren't
    enough areas in a level to assign all staircases. It starts at
    the first area and sees if any exits could be added. If they
    can, it sees if there an available area of that type. If there
    is no possible area with more exits to assign, or no exits can
    be added, the script adds the exits from the current area to
    the queue, then runs itself to see if any of them can have
    exits added.
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: July 2005                                      //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Include Files                                                //
//////////////////////////////////////////////////////////////////

#include "inc_id1_debug"
#include "inc_id1_gen"
#include "inc_id1_utility"


//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    int iMax = GetLocalInt(GetModule(), "nQueueMax");
    int iCurrent = GetLocalInt(GetModule(), "nQueueMin");
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
    int iX;
    int iY;

    object oArea;
    object oArea2;

    // get current coordinates
    iX = GetLocalInt(GetModule(), "nQueue" + IntToString(iCurrent) + "X");
    iY = GetLocalInt(GetModule(), "nQueue" + IntToString(iCurrent) + "Y");

    DebugMessage("");
    DebugMessage("Checking area " + IntToString(iX) + "," + IntToString(iY));

    oArea = GetAreaByCoordinates(iX, iY, nCurrentLevel);

    if (oArea == OBJECT_INVALID)
    {
        DebugMessage(" Area does not exist.");
    }

    int nAreaType = GetLocalInt(oArea, "nDoor");
    DebugMessage("  Area is of door configuration " + IntToString(nAreaType));

    string sTileset = GetTilesetResRef(oArea);


    object oDungeon = GetCurrentDungeon();
    int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");
    DebugMessage("  Area is number " + IntToString(nAreaNum) + " and has identifier " + IntToString(nAreaIdentifier));

    int nNorthAdd = 0;
    int nEastAdd = 0;
    int nSouthAdd = 0;
    int nWestAdd = 0;


    // see if the north exit can be used
    if (IsAreaUseable(iX, iY + 1, nCurrentLevel))
    {
        DebugMessage("  An area north is possible.");

        // if this door doesn't already exist
        if (GetLocalObject(oArea, "oDoorNorth") == OBJECT_INVALID)
        {
            DebugMessage("  Area does not have north door.");

            // mark north exit as available
            nNorthAdd = ID1_DOOR_NORTH;
        } else
        {
            DebugMessage("  Area has a north door.");
        }
    } else
    {
        DebugMessage("  An area north is not possible.");
    }

    // see if the east exit can be used
    if (IsAreaUseable(iX + 1, iY, nCurrentLevel))
    {
        DebugMessage("  An area east is possible.");

        // if this door doesn't already exist
        if (GetLocalObject(oArea, "oDoorEast") == OBJECT_INVALID)
        {
            DebugMessage("  Area does not have east door.");

            // mark east exit as available
            nEastAdd = ID1_DOOR_EAST;
        } else
        {
            DebugMessage("  Area has an east door.");
        }
    } else
    {
        DebugMessage("  An area east is not possible.");
    }

    // see if the south exit can be used
    if (IsAreaUseable(iX, iY - 1, nCurrentLevel))
    {
        DebugMessage("  An area south is possible.");

        // if this door doesn't already exist
        if (GetLocalObject(oArea, "oDoorSouth") == OBJECT_INVALID)
        {
            DebugMessage("  Area does not have south door.");

            // mark south exit as available
            nSouthAdd = ID1_DOOR_SOUTH;
        } else
        {
            DebugMessage("  Area has a south door.");
        }
    } else
    {
        DebugMessage("  An area south is not possible.");
    }

    // see if the west exit can be used
    if (IsAreaUseable(iX - 1, iY, nCurrentLevel))
    {
        DebugMessage("  An area west is possible.");

        // if this door doesn't already exist
        if (GetLocalObject(oArea, "oDoorWest") == OBJECT_INVALID)
        {
            DebugMessage("  Area does not have west door.");

            // mark west exit as available
            nWestAdd = ID1_DOOR_WEST;
        } else
        {
            DebugMessage("  Area has a west door.");
        }
    } else
    {
        DebugMessage("  An area west is not possible.");
    }

    int nAreaTypeTemp;
    object oAreaTemp1;
    object oAreaTemp2;
    object oAreaTemp3;
    object oAreaTemp4;
    object oAreaTemp5;
    object oAreaTemp6;

    // 4 exit check
    if ((nNorthAdd > 0) || (nEastAdd > 0) || (nSouthAdd > 0) || (nWestAdd > 0))
    {
        nAreaTypeTemp = nAreaType + nNorthAdd + nEastAdd + nSouthAdd + nWestAdd;
        DebugMessage("4-way check results in door configuration " + IntToString(nAreaTypeTemp));

        // check for area
        oAreaTemp1 = GetUnusedArea(sTileset, 4, nAreaTypeTemp, nCurrentLevel, ID1_NO_STAIRS, oDungeon);
    } else
    {
        oAreaTemp1 = OBJECT_INVALID;
    }

    // if 4 exit area exists
    if (oAreaTemp1 != OBJECT_INVALID)
    {
        DebugMessage("4-way exit valid.");

        // EDIT: replace area
//        RemoveArea(nCurrentLevel, oArea, oDungeon);
//        SetArea(iX, iY, nCurrentLevel, oAreaTemp1, oDungeon);
        sTileset = GetTilesetResRef(oAreaTemp1);
    } else // 3 exit check
    {
        // minus north
        if ((nEastAdd > 0) || (nSouthAdd > 0) || (nWestAdd > 0))
        {
            nAreaTypeTemp = nAreaType + nEastAdd + nSouthAdd + nWestAdd;
            DebugMessage("3-way check minus North results in door configuration " + IntToString(nAreaTypeTemp));

            // check for area
            oAreaTemp1 = GetUnusedArea(sTileset, 4, nAreaTypeTemp, nCurrentLevel, ID1_NO_STAIRS, oDungeon);

            if (oAreaTemp1 == OBJECT_INVALID)
            {
                DebugMessage("Area minus North is invalid.");
            } else
            {
                DebugMessage("Area minus North is valid.");
            }
        } else
        {
            DebugMessage("No configuration minus North.");

            oAreaTemp1 = OBJECT_INVALID;
        }

        // minus east
        if ((nNorthAdd > 0) || (nSouthAdd > 0) || (nWestAdd > 0))
        {
            nAreaTypeTemp = nAreaType + nNorthAdd + nSouthAdd + nWestAdd;
            DebugMessage("3-way check minus East results in door configuration " + IntToString(nAreaTypeTemp));

            // check for area
            oAreaTemp2 = GetUnusedArea(sTileset, 4, nAreaTypeTemp, nCurrentLevel, ID1_NO_STAIRS, oDungeon);

            if (oAreaTemp2 == OBJECT_INVALID)
            {
                DebugMessage("Area minus East is invalid.");
            } else
            {
                DebugMessage("Area minus East is valid.");
            }
        } else
        {
            DebugMessage("No configuration minus East.");

            oAreaTemp2 = OBJECT_INVALID;
        }

        // minus south
        if ((nNorthAdd > 0) || (nEastAdd > 0) || (nWestAdd > 0))
        {
            nAreaTypeTemp = nAreaType + nNorthAdd + nEastAdd + nWestAdd;
            DebugMessage("3-way check minus South results in door configuration " + IntToString(nAreaTypeTemp));

            // check for area
            oAreaTemp3 = GetUnusedArea(sTileset, 4, nAreaTypeTemp, nCurrentLevel, ID1_NO_STAIRS, oDungeon);

            if (oAreaTemp3 == OBJECT_INVALID)
            {
                DebugMessage("Area minus South is invalid.");
            } else
            {
                DebugMessage("Area minus South is valid.");
            }
        } else
        {
            DebugMessage("No configuration minus South.");

            oAreaTemp3 = OBJECT_INVALID;
        }

        // minus west
        if ((nNorthAdd > 0) || (nEastAdd > 0) || (nSouthAdd > 0))
        {
            nAreaTypeTemp = nAreaType + nNorthAdd + nEastAdd + nSouthAdd;
            DebugMessage("3-way check minus West results in door configuration " + IntToString(nAreaTypeTemp));

            // check for area
            oAreaTemp4 = GetUnusedArea(sTileset, 4, nAreaTypeTemp, nCurrentLevel, ID1_NO_STAIRS, oDungeon);

            if (oAreaTemp4 == OBJECT_INVALID)
            {
                DebugMessage("Area minus West is invalid.");
            } else
            {
                DebugMessage("Area minus West is valid.");
            }
        } else
        {
            DebugMessage("No configuration minus West.");

            oAreaTemp4 = OBJECT_INVALID;
        }

        // if there is a valid area
        if ((oAreaTemp1 != OBJECT_INVALID) || (oAreaTemp2 != OBJECT_INVALID) || (oAreaTemp3 != OBJECT_INVALID) || (oAreaTemp4 != OBJECT_INVALID))
        {
            DebugMessage("3-way exit valid.");

            // pick random start
            int nCurrent = Random(4) + 1;

            // cycle through list until one found
            int bFound = FALSE;
            object oFound;
            while (bFound == FALSE)
            {
                DebugMessage("Checking area " + IntToString(nCurrent));

                // check area 1
                if ((nCurrent == 1) && (oAreaTemp1 == OBJECT_INVALID))
                {
                    bFound = TRUE;
                    oFound = oAreaTemp1;
                }

                // check area 2
                if ((nCurrent == 2) && (oAreaTemp2 == OBJECT_INVALID))
                {
                    bFound = TRUE;
                    oFound = oAreaTemp2;
                }

                // check area 3
                if ((nCurrent == 3) && (oAreaTemp3 == OBJECT_INVALID))
                {
                    bFound = TRUE;
                    oFound = oAreaTemp3;
                }

                // check area 4
                if ((nCurrent == 4) && (oAreaTemp4 == OBJECT_INVALID))
                {
                    bFound = TRUE;
                    oFound = oAreaTemp4;
                }

                nCurrent++;

                if (nCurrent > 4)
                {
                    nCurrent = 1;
                }
            }

            DebugMessage("Using area " + IntToString(nCurrent));

            // EDIT: replace area
//            RemoveArea(nCurrentLevel, oArea, oDungeon);
//            SetArea(iX, iY, nCurrentLevel, oFound, oDungeon);
            sTileset = GetTilesetResRef(oFound);
        } else // 2 exit check
        {
            // minus north and east
            if ((nSouthAdd > 0) || (nWestAdd > 0))
            {
                nAreaTypeTemp = nAreaType + nSouthAdd + nWestAdd;
                DebugMessage("2-way check minus North and East results in door configuration " + IntToString(nAreaTypeTemp));

                // check for area
                oAreaTemp1 = GetUnusedArea(sTileset, 4, nAreaTypeTemp, nCurrentLevel, ID1_NO_STAIRS, oDungeon);

                if (oAreaTemp1 == OBJECT_INVALID)
                {
                    DebugMessage("Area minus North and East is invalid.");
                } else
                {
                    DebugMessage("Area minus North and East is valid.");
                }
            } else
            {
                DebugMessage("No configuration minus North and East.");

                oAreaTemp1 = OBJECT_INVALID;
            }

            // minus north and south
            if ((nEastAdd > 0) || (nWestAdd > 0))
            {
                nAreaTypeTemp = nAreaType + nEastAdd + nWestAdd;
                DebugMessage("2-way check minus North and South results in door configuration " + IntToString(nAreaTypeTemp));

                // check for area
                oAreaTemp2 = GetUnusedArea(sTileset, 4, nAreaTypeTemp, nCurrentLevel, ID1_NO_STAIRS, oDungeon);

                if (oAreaTemp2 == OBJECT_INVALID)
                {
                    DebugMessage("Area minus North and South is invalid.");
                } else
                {
                    DebugMessage("Area minus North and South is valid.");
                }
            } else
            {
                DebugMessage("No configuration minus North and South.");

                oAreaTemp2 = OBJECT_INVALID;
            }

            // minus north and west
            if ((nEastAdd > 0) || (nSouthAdd > 0))
            {
                nAreaTypeTemp = nAreaType + nEastAdd + nSouthAdd;
                DebugMessage("2-way check minus North and West results in door configuration " + IntToString(nAreaTypeTemp));

                // check for area
                oAreaTemp3 = GetUnusedArea(sTileset, 4, nAreaTypeTemp, nCurrentLevel, ID1_NO_STAIRS, oDungeon);

                if (oAreaTemp3 == OBJECT_INVALID)
                {
                    DebugMessage("Area minus North and West is invalid.");
                } else
                {
                    DebugMessage("Area minus North and West is valid.");
                }
            } else
            {
                DebugMessage("No configuration minus North and West.");

                oAreaTemp3 = OBJECT_INVALID;
            }

            // minus east and south
            if ((nNorthAdd > 0) || (nWestAdd > 0))
            {
                nAreaTypeTemp = nAreaType + nNorthAdd + nWestAdd;
                DebugMessage("2-way check minus East and South results in door configuration " + IntToString(nAreaTypeTemp));

                // check for area
                oAreaTemp4 = GetUnusedArea(sTileset, 4, nAreaTypeTemp, nCurrentLevel, ID1_NO_STAIRS, oDungeon);

                if (oAreaTemp4 == OBJECT_INVALID)
                {
                    DebugMessage("Area minus East and South is invalid.");
                } else
                {
                    DebugMessage("Area minus East and South is valid.");
                }
            } else
            {
                DebugMessage("No configuration minus East and South.");

                oAreaTemp4 = OBJECT_INVALID;
            }

            // minus east and west
            if ((nNorthAdd > 0) || (nSouthAdd > 0))
            {
                nAreaTypeTemp = nAreaType + nNorthAdd + nSouthAdd;
                DebugMessage("2-way check minus East and West results in door configuration " + IntToString(nAreaTypeTemp));

                // check for area
                oAreaTemp5 = GetUnusedArea(sTileset, 4, nAreaTypeTemp, nCurrentLevel, ID1_NO_STAIRS, oDungeon);

                if (oAreaTemp5 == OBJECT_INVALID)
                {
                    DebugMessage("Area minus East and West is invalid.");
                } else
                {
                    DebugMessage("Area minus East and West is valid.");
                }
            } else
            {
                DebugMessage("No configuration minus East and West.");

                oAreaTemp5 = OBJECT_INVALID;
            }

            // minus south and west
            if ((nNorthAdd > 0) || (nEastAdd > 0))
            {
                nAreaTypeTemp = nAreaType + nNorthAdd + nEastAdd;
                DebugMessage("2-way check minus South and West results in door configuration " + IntToString(nAreaTypeTemp));

                // check for area
                oAreaTemp6 = GetUnusedArea(sTileset, 4, nAreaTypeTemp, nCurrentLevel, ID1_NO_STAIRS, oDungeon);

                if (oAreaTemp6 == OBJECT_INVALID)
                {
                    DebugMessage("Area minus South and West is invalid.");
                } else
                {
                    DebugMessage("Area minus South and West is valid.");
                }
            } else
            {
                DebugMessage("No configuration minus South and West.");

                oAreaTemp6 = OBJECT_INVALID;
            }

            if ((oAreaTemp1 != OBJECT_INVALID) || (oAreaTemp2 != OBJECT_INVALID) || (oAreaTemp3 != OBJECT_INVALID) || (oAreaTemp4 != OBJECT_INVALID) || (oAreaTemp5 != OBJECT_INVALID) || (oAreaTemp6 != OBJECT_INVALID))
            {
                DebugMessage("2-way exit valid.");

                // pick random start
                int nCurrent = Random(6) + 1;

                // cycle through list until one found
                int bFound = FALSE;
                object oFound;
                while (bFound == FALSE)
                {
                    DebugMessage("Checking area " + IntToString(nCurrent));

                    // check area 1
                    if ((nCurrent == 1) && (oAreaTemp1 == OBJECT_INVALID))
                    {
                        bFound = TRUE;
                        oFound = oAreaTemp1;
                    }

                    // check area 2
                    if ((nCurrent == 2) && (oAreaTemp2 == OBJECT_INVALID))
                    {
                        bFound = TRUE;
                        oFound = oAreaTemp2;
                    }

                    // check area 3
                    if ((nCurrent == 3) && (oAreaTemp3 == OBJECT_INVALID))
                    {
                        bFound = TRUE;
                        oFound = oAreaTemp3;
                    }

                    // check area 4
                    if ((nCurrent == 4) && (oAreaTemp4 == OBJECT_INVALID))
                    {
                        bFound = TRUE;
                        oFound = oAreaTemp4;
                    }

                    // check area 5
                    if ((nCurrent == 5) && (oAreaTemp5 == OBJECT_INVALID))
                    {
                        bFound = TRUE;
                        oFound = oAreaTemp5;
                    }

                    // check area 6
                    if ((nCurrent == 6) && (oAreaTemp6 == OBJECT_INVALID))
                    {
                        bFound = TRUE;
                        oFound = oAreaTemp6;
                    }

                    nCurrent++;

                    if (nCurrent > 6)
                    {
                        nCurrent = 1;
                    }
                }

                DebugMessage("Using area " + IntToString(nCurrent));

                // EDIT: replace area
//                RemoveArea(nCurrentLevel, oArea, oDungeon);
//                SetArea(iX, iY, nCurrentLevel, oFound, oDungeon);
                sTileset = GetTilesetResRef(oFound);
            } else // there are no areas that can fit here
            {
                // add surrounding areas to the queue
                AddAdjacentAreas(iX, iY, nCurrentLevel, oDungeon);
            }
        }
    }

    // if something was found
    if ((oAreaTemp1 != OBJECT_INVALID) || (oAreaTemp2 != OBJECT_INVALID) || (oAreaTemp3 != OBJECT_INVALID) || (oAreaTemp4 != OBJECT_INVALID) || (oAreaTemp5 != OBJECT_INVALID) || (oAreaTemp6 != OBJECT_INVALID))
    {
        DebugMessage("Area found.");

        GenerateArea(iX, iY, nCurrentLevel, sTileset);

        // run area generation script
        DelayCommand(0.01, ExecuteScript("exe_id1_areagen", GetNextCPU()));
    } else
    {
        DebugMessage("No area found.");

        iMax = GetLocalInt(GetModule(), "nQueueMax");

        // not at the end of the queue
        if (iMax > iCurrent)
        {
            DebugMessage("Advancing queue.");

            // advance queue
            iCurrent++;
            SetLocalInt(GetModule(), "nQueueMin", iCurrent);

            // run this script again
            DelayCommand(0.01, ExecuteScript("exe_id1_areafix", GetNextCPU()));
        } else // at the end of the queue
        {
            DebugMessage("Queue finished.");

            // advance level process
            SetLocalInt(GetModule(), "nLevelProcess", 2);

            // reset the queue to the beginning
            SetLocalInt(GetModule(), "nQueueMax", 1);
            SetLocalInt(GetModule(), "nQueueMin", 1);

            // run stair generation
            DelayCommand(0.01, ExecuteScript("exe_id1_stairgen", GetNextCPU()));
        }
    }
}

