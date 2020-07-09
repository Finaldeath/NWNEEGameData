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
#include "inc_id1_areagen"

// object GetNextCPU()
#include "inc_id1_utility"


//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    DebugMessage("");
    DebugMessage("Area generation process.");

    // pick stairs up location
    int nLevel = GetCurrentLevel();
    object oDungeon = GetCurrentDungeon();
    int nMaxX = GetLocalInt(oDungeon, "nMaxX");
    int nMaxY = GetLocalInt(oDungeon, "nMaxY");
    DebugMessage("  Dungeon is " + IntToString(nMaxX) + "x" + IntToString(nMaxY));

    int nX = Random(nMaxX) + 1;
    int nY = Random(nMaxY) + 1;
    DebugMessage("  Stairs up located at " + IntToString(nX) + "," + IntToString(nY));

    // pick stairs up area
    int nArea = GetStairsUpArea(nLevel, oDungeon);
    DebugMessage("  Stairs up area selected was " + IntToString(nArea));
    int nTileset = GetTilesetNumber(nArea);
    DebugMessage("  Tileset of stairs up area is " + IntToString(nTileset));

    SetArea(nX, nY, nArea, nLevel, oDungeon);
    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nArea) + "Area");
    DebugMessage("Stairs up is area number " + IntToString(nAreaNum));
    SetLocalInt(oDungeon, "nLevel" + IntToString(nLevel) + "StairsUp", 1);
    SetLocalInt(oDungeon, "nLevel" + IntToString(nLevel) + "StairsUp1", nAreaNum);
    SetLocalInt(oDungeon, "bLevel" + IntToString(nLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY) + "StairsUp", TRUE);

    // create temporary holder object
    object oTempHolder = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "AreaGenHolder");
    SetLocalObject(GetModule(), "oTempHolder", oTempHolder);

    // add exits to queue
    SetLocalInt(oTempHolder, "nQueuePosition", 1);
    int nQueueMax = 0;
    int nPos = ((nY - 1) * nMaxX) + nX;
    if (nX < nMaxX)
    {
        nQueueMax++;
        SetLocalInt(oTempHolder, "nQueue" + IntToString(nQueueMax) + "Pos", nPos + 1);
        DebugMessage("  Setting nQueue" + IntToString(nQueueMax) + "Pos to " + IntToString(nPos + 1));
        SetLocalInt(oTempHolder, "nQueue" + IntToString(nQueueMax) + "Tileset", nTileset);
        DebugMessage("  Setting nQueue" + IntToString(nQueueMax) + "Tileset to " + IntToString(nTileset));
    }
    if (nX > 1)
    {
        nQueueMax++;
        SetLocalInt(oTempHolder, "nQueue" + IntToString(nQueueMax) + "Pos", nPos - 1);
        DebugMessage("  Setting nQueue" + IntToString(nQueueMax) + "Pos to " + IntToString(nPos - 1));
        SetLocalInt(oTempHolder, "nQueue" + IntToString(nQueueMax) + "Tileset", nTileset);
        DebugMessage("  Setting nQueue" + IntToString(nQueueMax) + "Tileset to " + IntToString(nTileset));
    }
    if (nY < nMaxY)
    {
        nQueueMax++;
        SetLocalInt(oTempHolder, "nQueue" + IntToString(nQueueMax) + "Pos", nPos + nMaxX);
        DebugMessage("  Setting nQueue" + IntToString(nQueueMax) + "Pos to " + IntToString(nPos + nMaxX));
        SetLocalInt(oTempHolder, "nQueue" + IntToString(nQueueMax) + "Tileset", nTileset);
        DebugMessage("  Setting nQueue" + IntToString(nQueueMax) + "Tileset to " + IntToString(nTileset));
    }
    if (nY > 1)
    {
        nQueueMax++;
        SetLocalInt(oTempHolder, "nQueue" + IntToString(nQueueMax) + "Pos", nPos - nMaxX);
        DebugMessage("  Setting nQueue" + IntToString(nQueueMax) + "Pos to " + IntToString(nPos - nMaxX));
        SetLocalInt(oTempHolder, "nQueue" + IntToString(nQueueMax) + "Tileset", nTileset);
        DebugMessage("  Setting nQueue" + IntToString(nQueueMax) + "Tileset to " + IntToString(nTileset));
    }
    SetLocalInt(oTempHolder, "nQueueMax", nQueueMax);
    DebugMessage("  nQueueMax is " + IntToString(nQueueMax));

    // start repeatable area algorithm
    DelayCommand(0.01, ExecuteScript("exe_id1_areagen2", GetNextCPU()));
}












/*
    int nAreaProcess = GetLocalInt(GetModule(), "nAreaProcess");
    DebugMessage("Area process is " + IntToString(nAreaProcess));

    object oDungeon = GetCurrentDungeon();
    int nLevel = GetCurrentLevel();
    object oArea;

    int nMax = GetLocalInt(GetModule(), "nQueueMax");
    int nCurrent = GetLocalInt(GetModule(), "nQueueMin");
    string sTileset = GetLocalString(GetModule(), "sQueue" + IntToString(nCurrent) + "Tileset");

    // get current coordinates
    int nX = GetLocalInt(GetModule(), "nQueue" + IntToString(nCurrent) + "X");
    int nY = GetLocalInt(GetModule(), "nQueue" + IntToString(nCurrent) + "Y");

    // get if area is useable
    if (nAreaProcess == 0)
    {
        int bUseable = IsAreaUseable(nX, nY, nLevel);

        DebugMessage("");
        DebugMessage("Checking to see if "  + IntToString(nX) + "," + IntToString(nY) + " is useable");

        // if an area can be placed here
        if (bUseable == TRUE)
        {
            DebugMessage("  Area is useable. Checking for valid area.");

            // set temporary area variable
            SetLocalObject(GetModule(), "oAreaProcessArea", OBJECT_INVALID);

            SetLocalInt(GetModule(), "nValidProcessDistance", -1);

            SetLocalInt(GetModule(), "nAreaProcess", 1);
            DelayCommand(0.01, ExecuteScript("exe_id1_areagen", GetNextCPU()));
        } else
        {
            DebugMessage("  Area is not useable. Advancing to next queue item.");

            // advance to queue increment
            SetLocalInt(GetModule(), "nAreaProcess", 2);
            DelayCommand(0.01, ExecuteScript("exe_id1_areagen", GetNextCPU()));
        }
    } else if (nAreaProcess == 1) // distance 0 check
    {
        // read in the area
        object oArea = GetLocalObject(GetModule(), "oAreaProcessArea");

        // if a valid area
        if (oArea != OBJECT_INVALID)
        {
            // assign area and return
            int nDoor = GetLocalInt(oArea, "nDoor");

            DebugMessage("  There is a valid area of type " + IntToString(nDoor));

            // set the current area
            SetArea(nX, nY, nLevel, oArea);
            int nAreaNumber = GetLocalInt(GetModule(), "nAreaNumber");
            nAreaNumber++;
            SetLocalInt(GetModule(), "nAreaNumber", nAreaNumber);

            // get the tileset of the current area
            sTileset = GetTilesetResRef(oArea);

            // EDIT: testing
            string sTilesetName = GetLocalString(GetModule(), "sTileset" + IntToString(GetLocalInt(GetModule(), "nTileset_" + sTileset)) + "Name");
            DebugMessage("  Returned tileset of the current area is " + sTileset + " - " + sTilesetName);
            //

            // add surrounding areas to the queue
            GenerateArea(nX, nY, nLevel, sTileset);

            // advance to queue increment
            SetLocalInt(GetModule(), "nAreaProcess", 2);
            DelayCommand(0.01, ExecuteScript("exe_id1_areagen", GetNextCPU()));
        } else // if not a valid area
        {
            // go to next queue, or advance to next distance
            int nDistance = GetLocalInt(GetModule(), "nValidProcessDistance");
            DebugMessage("nDistance is " + IntToString(nDistance));
            nDistance++;

            // if all distances have been checked
            if (nDistance > 3)
            {
                DebugMessage("Distance exceeds limit. Advancing to queue.");

                // advance to queue increment
                SetLocalInt(GetModule(), "nAreaProcess", 2);
                DelayCommand(0.01, ExecuteScript("exe_id1_areagen", GetNextCPU()));
            } else // if the are more distances to check
            {
                SetLocalInt(GetModule(), "nValidProcessDistance", nDistance);
                DebugMessage("Setting new distance to " + IntToString(nDistance));

                // advance to distance 0 check
                object oTempHolder = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "oTempHolder1");
                SetLocalObject(GetModule(), "oTempHolder", oTempHolder);

                SetLocalInt(oTempHolder, "nValidProcess", 0);
                SetLocalInt(oTempHolder, "nX", nX);
                SetLocalInt(oTempHolder, "nY", nY);
                SetLocalInt(oTempHolder, "nLevel", nLevel);
                SetLocalString(oTempHolder, "sTileset", sTileset);
                SetLocalObject(oTempHolder, "oDungeon", oDungeon);
                DebugMessage("  X = " + IntToString(nX) + ", Y = " + IntToString(nY) + ", level = " + IntToString(nLevel) + ", tileset = " + sTileset);

                DelayCommand(0.01, ExecuteScript("exe_id1_areaval", GetNextCPU()));
            }
        }
    } else if (nAreaProcess == 2) // advance to next part of queue
    {
        // advance to the next queue item
        nCurrent++;
        SetLocalInt(GetModule(), "nQueueMin", nCurrent);

        DebugMessage("On queue " + IntToString(nCurrent) + " of " + IntToString(nMax));

        // if the queue has not been exhausted
        if (nCurrent <= nMax)
        {
            // generate next area
            SetLocalInt(GetModule(), "nAreaProcess", 0);
            DelayCommand(0.01, ExecuteScript("exe_id1_areagen", GetNextCPU()));
        } else
        {
            // start stairs generation
            DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
        }
    }*/

