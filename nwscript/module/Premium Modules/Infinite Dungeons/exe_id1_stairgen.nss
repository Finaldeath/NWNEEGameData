//:://////////////////////////////////////////////////////////////
//:: exe_id1_stairgen                                           //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    This script generates staircases up and down for a given
    level. It first tries to generate Up staircases, then Down
    staircases. The number of Up staircases generated is based on
    the number of Down staircases on the previous level. It resets
    the queue back to the very first area that was created. This
    is the default area for the first Up staircase. It checks to
    see if there is an available area to place there. If it is, it
    moves on to the next Up staircase. If not, it adds all the
    exits from that area to the queue and checks to add an Up
    staircase to each of those in turn until it finds one. Once it
    finds an acceptable area, it randomizes and starts places
    other Up staircases. If an area is being checked that doesn't
    have an actual area assigned to it, it increments X and Y
    until it finds an area, then begins to check again. Once the
    Up staircases are done, the same method is used to determine
    the location of the Down staircases. Once all staircases are
    placed, the next CPU is assigned the script to start the door
    generation algorithm.
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
    int nMax = GetLocalInt(GetModule(), "nQueueMax");
    int nCurrent = GetLocalInt(GetModule(), "nQueueMin");
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");

    object oDungeon = GetCurrentDungeon();
    int nStairsUpCurrent = GetLocalInt(oDungeon, "nLevel" + IntToString(nCurrentLevel) + "StairsUp");
    int nStairsUpNeeded;
    int nStairsDownCurrent = GetLocalInt(oDungeon, "nLevel" + IntToString(nCurrentLevel) + "StairsDown");
    int nStairsDownMax = GetLocalInt(GetModule(), "nStairsTemp");
    int nMaxX = GetLocalInt(oDungeon, "nMaxX");
    int nMaxY = GetLocalInt(oDungeon, "nMaxY");
    int nMaxLevel = GetLocalInt(oDungeon, "nMaxLevel");

    int nStairType = GetLocalInt(GetModule(), "nStairType");
    int nCurrentStair = GetLocalInt(GetModule(), "nCurrentStair");
    int nTemp = FALSE;
    int bReturn = FALSE;
    object oStairs;
    object oStairs2;
    object oStairs3;
    object oStairs4;

    if (nCurrentLevel == 1)
    {
        nStairsUpNeeded = 1;
    } else
    {
        nStairsUpNeeded = GetLocalInt(oDungeon, "nLevel" + IntToString(nCurrentLevel - 1) + "StairsDown");
    }

    DebugMessage("");
    DebugMessage("Stairs Up current: " + IntToString(nStairsUpCurrent));
    DebugMessage("Stairs Up needed: " + IntToString(nStairsUpNeeded));
    DebugMessage("Stairs Down current: " + IntToString(nStairsDownCurrent));
    DebugMessage("Stairs Down needed: " + IntToString(nStairsDownMax));

    // get current coordinates and level
    int nX = GetLocalInt(GetModule(), "nCurrentX");
    int nY = GetLocalInt(GetModule(), "nCurrentY");

    // if the coordinates are out of bounds, default to the queue
    if ((nX == 0) || (nY == 0))
    {
        nX = GetLocalInt(GetModule(), "nQueue" + IntToString(nCurrent) + "X");
        nY = GetLocalInt(GetModule(), "nQueue" + IntToString(nCurrent) + "Y");
    }

    SetLocalInt(GetModule(), "nCurrentX", 0);
    SetLocalInt(GetModule(), "nCurrentY", 0);

    DebugMessage("Getting area at " + IntToString(nX) + "," + IntToString(nY) + ".");

    object oArea = GetAreaByCoordinates(nX, nY, nCurrentLevel);

    // check to see if there is an area here
    if (oArea != OBJECT_INVALID)
    {
        int nType = GetAreaType(oArea);
        string sTileset = GetTilesetResRef(oArea);

        DebugMessage("  Area is valid of type " + IntToString(nType) + ".");

        // check to see if this room already has stairs
        if ((GetLocalInt(oArea, "nStairsUp") == 0) && (GetLocalInt(oArea, "nStairsDown") == 0))
        {
            DebugMessage("    This area does not have a staircase.");

            // check to see if there is a room of this type available in the stairs list at distance 0
            oStairs = GetUnusedArea(sTileset, 0, nType, nCurrentLevel, nStairType, oDungeon);

            // if there is no distance 0 stair of that type, check distance 0 type 15 stair
            if (oStairs == OBJECT_INVALID)
            {
                // check to see if there is a room of type 15 available in the stairs list at distance 0
                oStairs = GetUnusedArea(sTileset, 0, 15, nCurrentLevel, nStairType, oDungeon);
            }

            // if there is no distance 0 stair, check distance 1 stair of that type
            if (oStairs == OBJECT_INVALID)
            {
                // check to see if there is a room of this type available in the stairs list at distance 1
                oStairs = GetUnusedArea(sTileset, 1, nType, nCurrentLevel, nStairType, oDungeon);
            }

            // if there is no distance 0 stair, check distance 1
            if (oStairs == OBJECT_INVALID)
            {
                // check to see if there is a room of type 15 available in the stairs list at distance 1
                oStairs = GetUnusedArea(sTileset, 1, 15, nCurrentLevel, nStairType, oDungeon);
            }

            // if so, reassign it
            if (oStairs != OBJECT_INVALID)
            {
                DebugMessage("      There is an unused staircase of this type.");

                // increment that a stair is being added
                nCurrentStair++;
                SetLocalInt(GetModule(), "nCurrentStair", nCurrentStair);

                int nAreaIdentifierOld;
                int nAreaNumOld;
                int nAreaIdentifierNew;
                int nAreaNumNew;
                string sTemp;

                // get old area info
                nAreaIdentifierOld = GetLocalInt(oArea, "nAreaIdentifier");
                sTemp = "nIdentifier" + IntToString(nAreaIdentifierOld) + "Area";
                nAreaNumOld = GetLocalInt(oDungeon, sTemp);
                DebugMessage("        Old area is identifier " + IntToString(nAreaIdentifierOld) + " and area number " + IntToString(nAreaNumOld));

                // get new area info
                nAreaIdentifierNew = GetLocalInt(oStairs, "nAreaIdentifier");
                nAreaNumNew = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifierNew) + "Area");
                DebugMessage("        New area is identifier " + IntToString(nAreaIdentifierNew) + " and area number " + IntToString(nAreaNumNew));

                // add new area to the list if not already there
                if (nAreaNumNew == 0)
                {
                    DebugMessage("          Adding area to list.");

                    nAreaNumNew = GetLocalInt(oDungeon, "nAreaNum") + 1;
                    SetLocalInt(oDungeon, "nAreaNum", nAreaNumNew);
                    DebugMessage("          New Area Number: " + IntToString(nAreaNumNew));

                    SetLocalInt(oDungeon, "nArea" + IntToString(nAreaNumNew) + "Identifier", nAreaIdentifierNew);
                    SetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifierNew) + "Area", nAreaNumNew);

                    AddAreaToDungeon("Area" + IntToString(nAreaNumNew), oStairs, oDungeon);
                }

                // copy locations to the new area
                sTemp = "bArea" + IntToString(nAreaNumNew) + "Level" + IntToString(nCurrentLevel) + "Used";
                SetLocalInt(oDungeon, sTemp, TRUE);
                DebugMessage("        Setting " + sTemp);

                sTemp = "nArea" + IntToString(nAreaNumNew) + "Level" + IntToString(nCurrentLevel) + "X";
                SetLocalInt(oDungeon, sTemp, nX);

                sTemp = "nArea" + IntToString(nAreaNumNew) + "Level" + IntToString(nCurrentLevel) + "Y";
                SetLocalInt(oDungeon, sTemp, nY);

                // remove the locations from the old area
                sTemp = "bArea" + IntToString(nAreaNumOld) + "Level" + IntToString(nCurrentLevel) + "Used";
                DeleteLocalInt(oDungeon, sTemp);
                DebugMessage("        Deleting " + sTemp);

                sTemp = "nArea" + IntToString(nAreaNumOld) + "Level" + IntToString(nCurrentLevel) + "X";
                DeleteLocalInt(oDungeon, sTemp);

                sTemp = "nArea" + IntToString(nAreaNumOld) + "Level" + IntToString(nCurrentLevel) + "Y";
                DeleteLocalInt(oDungeon, sTemp);


                // set the area as being at those coordinates on the level
                sTemp = "nLevel" + IntToString(nCurrentLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY);
                SetLocalInt(oDungeon, sTemp, nAreaNumNew);

                DebugMessage("        Stairs added at " + sTemp + " with value " + IntToString(nAreaNumNew));


                // add stair information to the dungeon
                sTemp = "nLevel" + IntToString(nCurrentLevel);

                if (nStairType == ID1_UP_STAIRS)
                {
                    sTemp += "StairsUp";
                    nStairsUpCurrent++;
                    SetLocalInt(oDungeon, "bLevel" + IntToString(nCurrentLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY) + "StairsUp", TRUE);
                } else
                {
                    sTemp += "StairsDown";
                    nStairsDownCurrent++;
                    SetLocalInt(oDungeon, "bLevel" + IntToString(nCurrentLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY) + "StairsDown", TRUE);
                }

                int nTemp = GetLocalInt(oDungeon, sTemp);
                nTemp++;
                SetLocalInt(oDungeon, sTemp, nTemp);
                DebugMessage("        Setting " + sTemp + " to " + IntToString(nTemp));

                SetLocalInt(oDungeon, sTemp + IntToString(nTemp), nAreaNumNew);
                DebugMessage("        Setting " + sTemp + IntToString(nTemp) + " to " + IntToString(nAreaNumNew));

                // if its an up staircase, link it to the previous one
                if (nStairType == ID1_UP_STAIRS)
                {
                    DebugMessage("        This is an up staircase.");

                    if (nCurrentLevel == 1)
                    {
                        DebugMessage("          Stairs up on the first dungeon level.");

                        // set level 0 stairs down
                        SetLocalInt(oDungeon, "nLevel0StairsDown1Destination", nAreaNumNew);
                        DebugMessage("          Setting nLevel0StairsDown1Destination to " + IntToString(nAreaNumNew));

                        // set level 1 stairs up
                        SetLocalInt(oDungeon, "nLevel1StairsUp1Destination", nAreaNumNew);
                        DebugMessage("          Setting nLevel1StairsUp1Destination to " + IntToString(nAreaNumNew));
                    } else
                    {
                        DebugMessage("          Getting old stairs: nLevel" + IntToString(nCurrentLevel - 1) + "StairsDown" + IntToString(nCurrentStair));

                        // get identifier of previous stairs
                        string sDown = "nLevel" + IntToString(nCurrentLevel - 1) + "StairsDown" + IntToString(nCurrentStair);
                        int nAreaNumDown = GetLocalInt(oDungeon, sDown);

                        DebugMessage("          Area Number of sDown: " + IntToString(nAreaNumDown));

                        string sUp = "nLevel" + IntToString(nCurrentLevel) + "StairsUp" + IntToString(nCurrentStair);
                        DebugMessage("          Area Number of sUp: " + IntToString(nAreaNumNew));

                        SetLocalInt(oDungeon, sDown + "Destination", nAreaNumNew);
                        SetLocalInt(oDungeon, sUp + "Destination", nAreaNumDown);
                    }
                }

                // add areas to the queue to continue searching if necessary
                AddAdjacentAreas(nX, nY, nCurrentLevel);
            } else
            {
                DebugMessage("No stair of this type. Adding exits.");

                // if not, add the exits to the queue and examine each in turn
                AddAdjacentAreas(nX, nY, nCurrentLevel);
            }
        } else // this area already has a staircase
        {
            DebugMessage("    Area already has a staircase.");
/*
            // if this is the last area, find a new random area
            if (nMax == nCurrent)
            {
                DebugMessage("End of queue.");

                int nAreaNumber = GetLocalInt(GetModule(), "nAreaNumber");

                // if all areas aren't in the queue
                if (nMax < nAreaNumber)
                {
                    nX = Random(nMaxX) + 1;
                    nY = Random(nMaxY) + 1;

                    while (PresentInQueue(nX, nY))
                    {
                        DebugMessage("    " + IntToString(nX) + "," + IntToString(nY) + " already present in queue.");
                        nX = Random(nMaxX) + 1;
                        nY = Random(nMaxY) + 1;
                    }

                    DebugMessage("    Finding new random area at " + IntToString(nX) + "," + IntToString(nY) + ".");

                    AddToQueue(nX, nY);
                }
            }*/

            DebugMessage("Adding exits.");

            AddAdjacentAreas(nX, nY, nCurrentLevel);
        }

        nCurrent++;
    } else
    {
        DebugMessage("Area is not valid.");

        // if not, cycle through line until either you find an area or reach the end of the line
        int nQX = GetLocalInt(GetModule(), "nQueue" + IntToString(nCurrent) + "X");
        int nQY = GetLocalInt(GetModule(), "nQueue" + IntToString(nCurrent) + "Y");

        while ((nX <= nMaxX) && (nTemp == FALSE))
        {
            DebugMessage("Checking area " + IntToString(nX) + "," + IntToString(nY));

            nX++;

            // if these coordinates have an area
            if (GetAreaByCoordinates(nX, nY, nCurrentLevel) != OBJECT_INVALID)
            {
                DebugMessage("  Area exists.");

                nTemp = TRUE;

                // add the area
                AddToQueue(nX, nY, "");
            }

            // if this is the original point
            if ((nX == nQX) && (nY == nQY))
            {
                DebugMessage("  This is the original point.");
                nTemp = TRUE;
                bReturn = TRUE;
            }
        }

        if (nTemp == FALSE)
        {
            if (nX > nMaxX)
            {
                DebugMessage("Going to next line.");

                nX = 1;
                nY++;
            }

            if (nY > nMaxY)
            {
                DebugMessage("Going to first line.");

                nY = 1;
            }

            SetLocalInt(GetModule(), "nCurrentX", nX);
            SetLocalInt(GetModule(), "nCurrentY", nY);
        } else
        {
            DebugMessage("Advancing queue.");

            nCurrent++;
        }
    }

    nMax = GetLocalInt(GetModule(), "nQueueMax");
    SetLocalInt(GetModule(), "nQueueMin", nCurrent);

    // if the queue is used up
    // if it has returned to the start point
    // if it has assigned a staircase
    if ((nCurrent > nMax) || (bReturn == TRUE) || (oStairs != OBJECT_INVALID))
    {
        // if the queue has been finished, or a staircase cannot be placed
        if ((nCurrent > nMax) || (bReturn == TRUE))
        {
            DebugMessage("Queue finished or stair not placed.");

            // if this is the Up staircases being completed
            if (nStairType == ID1_UP_STAIRS)
            {
                DebugMessage("Currently up staircase.");

                // if this was the first staircase that failed, force it to be the special condition
                nStairsUpCurrent = GetLocalInt(oDungeon, "nLevel" + IntToString(nCurrentLevel) + "StairsUp");
                if (nStairsUpCurrent == 0)
                {
                    DebugMessage("  No Up staircases could be assigned. Forcing assignation.");

                    // get the first area that was placed in the queue
                    nX = GetLocalInt(GetModule(), "nQueue1X");
                    nY = GetLocalInt(GetModule(), "nQueue1Y");
                    oArea = GetAreaByCoordinates(nX, nY, nCurrentLevel);

                    DebugMessage("  First area was " + IntToString(nX) + "," + IntToString(nY));

                    DebugMessage("  Replacing with emergency Up staircase.");

                    // replace it with the 4-way Up staircase
                    oStairs = GetObjectByTag("EmergencyUp");


                    // copied from the normal stair assignment

                    // increment that a stair is being added
                    nCurrentStair++;
                    SetLocalInt(GetModule(), "nCurrentStair", nCurrentStair);

                    int nAreaIdentifierOld;
                    int nAreaNumOld;
                    int nAreaIdentifierNew;
                    int nAreaNumNew;
                    string sTemp;

                    // get old area info
                    nAreaIdentifierOld = GetLocalInt(oArea, "nAreaIdentifier");
                    sTemp = "nIdentifier" + IntToString(nAreaIdentifierOld) + "Area";
                    nAreaNumOld = GetLocalInt(oDungeon, sTemp);
                    DebugMessage("    Old area is identifier " + IntToString(nAreaIdentifierOld) + " and area number " + IntToString(nAreaNumOld));

                    // get new area info
                    nAreaIdentifierNew = GetLocalInt(oStairs, "nAreaIdentifier");
                    nAreaNumNew = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifierNew) + "Area");
                    DebugMessage("    New area is identifier " + IntToString(nAreaIdentifierNew) + " and area number " + IntToString(nAreaNumNew));

                    // add new area to the list if not already there
                    if (nAreaNumNew == 0)
                    {
                        DebugMessage("      Adding area to list.");

                        nAreaNumNew = GetLocalInt(oDungeon, "nAreaNum") + 1;
                        SetLocalInt(oDungeon, "nAreaNum", nAreaNumNew);
                        DebugMessage("      New Area Number: " + IntToString(nAreaNumNew));

                        SetLocalInt(oDungeon, "nArea" + IntToString(nAreaNumNew) + "Identifier", nAreaIdentifierNew);
                        SetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifierNew) + "Area", nAreaNumNew);

                        AddAreaToDungeon("Area" + IntToString(nAreaNumNew), oStairs, oDungeon);
                    }

                    // copy locations to the new area
                    sTemp = "bArea" + IntToString(nAreaNumNew) + "Level" + IntToString(nCurrentLevel) + "Used";
                    SetLocalInt(oDungeon, sTemp, TRUE);
                    DebugMessage("    Setting " + sTemp);

                    sTemp = "nArea" + IntToString(nAreaNumNew) + "Level" + IntToString(nCurrentLevel) + "X";
                    SetLocalInt(oDungeon, sTemp, nX);

                    sTemp = "nArea" + IntToString(nAreaNumNew) + "Level" + IntToString(nCurrentLevel) + "Y";
                    SetLocalInt(oDungeon, sTemp, nY);

                    // remove the locations from the old area
                    sTemp = "bArea" + IntToString(nAreaNumOld) + "Level" + IntToString(nCurrentLevel) + "Used";
                    DeleteLocalInt(oDungeon, sTemp);
                    DebugMessage("    Deleting " + sTemp);

                    sTemp = "nArea" + IntToString(nAreaNumOld) + "Level" + IntToString(nCurrentLevel) + "X";
                    DeleteLocalInt(oDungeon, sTemp);

                    sTemp = "nArea" + IntToString(nAreaNumOld) + "Level" + IntToString(nCurrentLevel) + "Y";
                    DeleteLocalInt(oDungeon, sTemp);


                    // set the area as being at those coordinates on the level
                    sTemp = "nLevel" + IntToString(nCurrentLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY);
                    SetLocalInt(oDungeon, sTemp, nAreaNumNew);
                    SetLocalInt(oDungeon, "bLevel" + IntToString(nCurrentLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY) + "StairsUp", TRUE);

                    DebugMessage("    Stairs added at " + sTemp + " with value " + IntToString(nAreaNumNew));


                    // add stair information to the dungeon
                    sTemp = "nLevel" + IntToString(nCurrentLevel);

                    if (nStairType == ID1_UP_STAIRS)
                    {
                        sTemp += "StairsUp";
                    } else
                    {
                        sTemp += "StairsDown";
                    }

                    int nTemp = GetLocalInt(oDungeon, sTemp);
                    nTemp++;
                    SetLocalInt(oDungeon, sTemp, nTemp);
                    DebugMessage("    Setting " + sTemp + " to " + IntToString(nTemp));

                    SetLocalInt(oDungeon, sTemp + IntToString(nTemp), nAreaNumNew);
                    DebugMessage("    Setting " + sTemp + IntToString(nTemp) + " to " + IntToString(nAreaNumNew));

                    // if its an up staircase, link it to the previous one
                    if (nStairType == ID1_UP_STAIRS)
                    {
                        DebugMessage("    This is an up staircase.");

                        if (nCurrentLevel == 1)
                        {
                            DebugMessage("      Stairs up on the first dungeon level.");

                            // set level 0 stairs down
                            SetLocalInt(oDungeon, "nLevel0StairsDown1Destination", nAreaNumNew);
                            DebugMessage("      Setting nLevel0StairsDown1Destination to " + IntToString(nAreaNumNew));

                            // set level 1 stairs up
                            SetLocalInt(oDungeon, "nLevel1StairsUp1Destination", nAreaNumNew);
                            DebugMessage("      Setting nLevel1StairsUp1Destination to " + IntToString(nAreaNumNew));
                        } else
                        {
                            DebugMessage("      Getting old stairs: nLevel" + IntToString(nCurrentLevel - 1) + "StairsDown" + IntToString(nCurrentStair));

                            // get identifier of previous stairs
                            string sDown = "nLevel" + IntToString(nCurrentLevel - 1) + "StairsDown" + IntToString(nCurrentStair);
                            int nAreaNumDown = GetLocalInt(oDungeon, sDown);

                            DebugMessage("      Area Number of sDown: " + IntToString(nAreaNumDown));

                            string sUp = "nLevel" + IntToString(nCurrentLevel) + "StairsUp" + IntToString(nCurrentStair);
                            DebugMessage("      Area Number of sUp: " + IntToString(nAreaNumNew));

                            SetLocalInt(oDungeon, sDown + "Destination", nAreaNumNew);
                            SetLocalInt(oDungeon, sUp + "Destination", nAreaNumDown);
                        }
                    }
                }

                // if this level has down staircases (i.e. not the bottom level)
                if (nCurrentLevel < GetLocalInt(oDungeon, "nDungeonDepth"))
                {
                    DebugMessage("Switching to down staircases.");

                    // switch to down staircase
                    SetLocalInt(GetModule(), "nStairType", ID1_DOWN_STAIRS);

                    // reset the queue to the beginning
                    SetLocalInt(GetModule(), "nQueueMax", 1);
                    SetLocalInt(GetModule(), "nQueueMin", 1);

                    // set the temporary variables
                    SetLocalInt(GetModule(), "nCurrentX", 0);
                    SetLocalInt(GetModule(), "nCurrentY", 0);
                    SetLocalInt(GetModule(), "nCurrentStair", 0);

                    // select random start point
                    SetLocalInt(GetModule(), "nQueue1X", Random(nMaxX) + 1);
                    SetLocalInt(GetModule(), "nQueue1Y", Random(nMaxY) + 1);

                    // generate next area
                    DelayCommand(0.01, ExecuteScript("exe_id1_stairgen", GetNextCPU()));
                } else
                {
                    // door generation
                    DebugMessage("Starting door generation.");
                    DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
                }
            } else // down staircase completed
            {
                DebugMessage("Currently down staircase.");

                // if this was the first staircase that failed, force it to be the special condition
                nStairsDownCurrent = GetLocalInt(oDungeon, "nLevel" + IntToString(nCurrentLevel) + "StairsDown");
                if (nStairsDownCurrent == 0)
                {
                    DebugMessage("  No Down staircases could be assigned. Forcing assignation.");

                    // find a free spot for the stairs

                    // walk backwards through the queue until you find a free area, then use it
                    nMax = GetLocalInt(GetModule(), "nQueueMax");
                    nCurrent = GetLocalInt(GetModule(), "nQueueMax");
                    nX = GetLocalInt(GetModule(), "nQueue" + IntToString(nCurrent) + "X");
                    nY = GetLocalInt(GetModule(), "nQueue" + IntToString(nCurrent) + "Y");

                    // get the most recent area
                    oArea = GetAreaByCoordinates(nX, nY, nCurrentLevel);

                    // if the area doesn't exist or already has a staircase, and the queue is not exhausted, cycle backwards
                    while (((oArea == OBJECT_INVALID) || ((GetLocalInt(oArea, "nStairsUp") > 0) || (GetLocalInt(oArea, "nStairsDown") > 0))) && (nCurrent > 0))
                    {
                        if (oArea == OBJECT_INVALID)
                        {
                            DebugMessage("Area " + IntToString(nX) + "," + IntToString(nY) + "does not exist.");
                        } else
                        {
                            DebugMessage("Area " + IntToString(nX) + "," + IntToString(nY) + " exists.");

                            if (GetLocalInt(oArea, "nStairsUp") > 0)
                            {
                                DebugMessage("Has a stairs up.");
                            } else if (GetLocalInt(oArea, "nStairsDown") > 0)
                            {
                                DebugMessage("Has a stairs down.");
                            } else
                            {
                                DebugMessage("No stairs.");
                            }
                        }

                        DebugMessage("Queue is " + IntToString(nCurrent));

                        // count down by one
                        nCurrent--;

                        // grab the new coordinates
                        nX = GetLocalInt(GetModule(), "nQueue" + IntToString(nCurrent) + "X");
                        nY = GetLocalInt(GetModule(), "nQueue" + IntToString(nCurrent) + "Y");

                        // get the new area
                        oArea = GetAreaByCoordinates(nX, nY, nCurrentLevel);
                    }

                    // if a useable area was returned
                    if (oArea != OBJECT_INVALID)
                    {
                        DebugMessage("    Area was " + IntToString(nX) + "," + IntToString(nY));

                        if ((GetLocalInt(oArea, "nStairsUp") == 0) && (GetLocalInt(oArea, "nStairsDown") == 0))
                        {
                            DebugMessage("    Replacing with emergency Down staircase.");

                            // replace it with the 4-way Up staircase
                            oStairs = GetObjectByTag("EmergencyDown");


                            // copied from the normal stair assignment

                            // increment that a stair is being added
                            nCurrentStair++;
                            SetLocalInt(GetModule(), "nCurrentStair", nCurrentStair);

                            int nAreaIdentifierOld;
                            int nAreaNumOld;
                            int nAreaIdentifierNew;
                            int nAreaNumNew;
                            string sTemp;

                            // get old area info
                            nAreaIdentifierOld = GetLocalInt(oArea, "nAreaIdentifier");
                            sTemp = "nIdentifier" + IntToString(nAreaIdentifierOld) + "Area";
                            nAreaNumOld = GetLocalInt(oDungeon, sTemp);
                            DebugMessage("    Old area is identifier " + IntToString(nAreaIdentifierOld) + " and area number " + IntToString(nAreaNumOld));

                            // get new area info
                            nAreaIdentifierNew = GetLocalInt(oStairs, "nAreaIdentifier");
                            nAreaNumNew = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifierNew) + "Area");
                            DebugMessage("    New area is identifier " + IntToString(nAreaIdentifierNew) + " and area number " + IntToString(nAreaNumNew));

                            // add new area to the list if not already there
                            if (nAreaNumNew == 0)
                            {
                                DebugMessage("          Adding area to list.");

                                nAreaNumNew = GetLocalInt(oDungeon, "nAreaNum") + 1;
                                SetLocalInt(oDungeon, "nAreaNum", nAreaNumNew);
                                DebugMessage("          New Area Number: " + IntToString(nAreaNumNew));

                                SetLocalInt(oDungeon, "nArea" + IntToString(nAreaNumNew) + "Identifier", nAreaIdentifierNew);
                                SetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifierNew) + "Area", nAreaNumNew);

                                AddAreaToDungeon("Area" + IntToString(nAreaNumNew), oStairs, oDungeon);
                            }

                            // copy locations to the new area
                            sTemp = "bArea" + IntToString(nAreaNumNew) + "Level" + IntToString(nCurrentLevel) + "Used";
                            SetLocalInt(oDungeon, sTemp, TRUE);
                            DebugMessage("    Setting " + sTemp);

                            sTemp = "nArea" + IntToString(nAreaNumNew) + "Level" + IntToString(nCurrentLevel) + "X";
                            SetLocalInt(oDungeon, sTemp, nX);

                            sTemp = "nArea" + IntToString(nAreaNumNew) + "Level" + IntToString(nCurrentLevel) + "Y";
                            SetLocalInt(oDungeon, sTemp, nY);

                            // remove the locations from the old area
                            sTemp = "bArea" + IntToString(nAreaNumOld) + "Level" + IntToString(nCurrentLevel) + "Used";
                            DeleteLocalInt(oDungeon, sTemp);
                            DebugMessage("    Deleting " + sTemp);

                            sTemp = "nArea" + IntToString(nAreaNumOld) + "Level" + IntToString(nCurrentLevel) + "X";
                            DeleteLocalInt(oDungeon, sTemp);

                            sTemp = "nArea" + IntToString(nAreaNumOld) + "Level" + IntToString(nCurrentLevel) + "Y";
                            DeleteLocalInt(oDungeon, sTemp);


                            // set the area as being at those coordinates on the level
                            sTemp = "nLevel" + IntToString(nCurrentLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY);
                            SetLocalInt(oDungeon, sTemp, nAreaNumNew);
                            SetLocalInt(oDungeon, "bLevel" + IntToString(nCurrentLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY) + "StairsDown", TRUE);

                            DebugMessage("    Stairs added at " + sTemp + " with value " + IntToString(nAreaNumNew));


                            // add stair information to the dungeon
                            sTemp = "nLevel" + IntToString(nCurrentLevel);

                            if (nStairType == ID1_UP_STAIRS)
                            {
                                sTemp += "StairsUp";
                            } else
                            {
                                sTemp += "StairsDown";
                            }

                            int nTemp = GetLocalInt(oDungeon, sTemp);
                            nTemp++;
                            SetLocalInt(oDungeon, sTemp, nTemp);
                            DebugMessage("    Setting " + sTemp + " to " + IntToString(nTemp));

                            SetLocalInt(oDungeon, sTemp + IntToString(nTemp), nAreaNumNew);
                            DebugMessage("    Setting " + sTemp + IntToString(nTemp) + " to " + IntToString(nAreaNumNew));
                        }
                    } else
                    {
                        DebugMessage("Internal error. Could not assign any staircase.");
                    }
                }

                // door generation
                DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
            }
        } else if (oStairs != OBJECT_INVALID) // if a staircase has been assigned
        {
            DebugMessage("Stair placed.");

            // added an up staircase
            if (nStairType == ID1_UP_STAIRS)
            {
                // get number of staircases
                nStairsUpCurrent = GetLocalInt(oDungeon, "nLevel" + IntToString(nCurrentLevel) + "StairsUp");
                DebugMessage("Currently " + IntToString(nStairsUpCurrent) + " Up staircase.");

                // if this is the last one
                if (nStairsUpCurrent >= nStairsUpNeeded)
                {
                    DebugMessage("Last staircase assigned.");

                    // if this level has down staircases (i.e. not the bottom level)
                    if (nCurrentLevel < GetLocalInt(oDungeon, "nDungeonDepth"))
                    {
                        DebugMessage("  Switching to Down staircases.");

                        // switch to down staircase
                        SetLocalInt(GetModule(), "nStairType", ID1_DOWN_STAIRS);

                        // reset the queue to the beginning
                        SetLocalInt(GetModule(), "nQueueMax", 1);
                        SetLocalInt(GetModule(), "nQueueMin", 1);

                        // set the temporary variables
                        SetLocalInt(GetModule(), "nCurrentX", 0);
                        SetLocalInt(GetModule(), "nCurrentY", 0);
                        SetLocalInt(GetModule(), "nCurrentStair", 0);

                        // select random start point
                        SetLocalInt(GetModule(), "nQueue1X", Random(nMaxX) + 1);
                        SetLocalInt(GetModule(), "nQueue1Y", Random(nMaxY) + 1);

                        // generate next area
                        DelayCommand(0.01, ExecuteScript("exe_id1_stairgen", GetNextCPU()));
                    } else
                    {
                        // door generation
                        DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
                    }
                } else
                {
                    // generate next area
                    DelayCommand(0.01, ExecuteScript("exe_id1_stairgen", GetNextCPU()));
                }
            } else // added a down staircase
            {
                // get number of staircases
                nStairsDownCurrent = GetLocalInt(oDungeon, "nLevel" + IntToString(nCurrentLevel) + "StairsDown");
                DebugMessage("Currently " + IntToString(nStairsDownCurrent) + " Down staircase.");

                // if this is the last one
                if (nStairsDownCurrent >= nStairsDownMax)
                {
                    DebugMessage("Last staircase assigned.");

                    // door generation
                    DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
                } else
                {
                    // generate next area
                    DelayCommand(0.01, ExecuteScript("exe_id1_stairgen", GetNextCPU()));
                }
            }
        }
    } else
    {
        // generate next area
        DelayCommand(0.01, ExecuteScript("exe_id1_stairgen", GetNextCPU()));
    }
}

