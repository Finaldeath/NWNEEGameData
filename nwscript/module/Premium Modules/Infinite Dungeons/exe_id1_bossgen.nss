#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_gen"

void main()
{
    // dungeon object
    object oDungeon = GetCurrentDungeon();

    // maximums
    int nMaxX = GetLocalInt(oDungeon, "nMaxX");
    int nMaxY = GetLocalInt(oDungeon, "nMaxY");

    // if coordinates are not 0, use them
    int nCurrentX = GetLocalInt(GetModule(), "nCurrentX");
    int nCurrentY = GetLocalInt(GetModule(), "nCurrentY");

    int nX;
    int nY;
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");

    // if it's a valid location
    if ((nCurrentX > 0) && (nCurrentX <= nMaxX) && (nCurrentY > 0) && (nCurrentY <= nMaxY))
    {
        // use these coordinates
        nX = nCurrentX;
        nY = nCurrentY;

        // reset the variables
        SetLocalInt(GetModule(), "nCurrentX", 0);
        SetLocalInt(GetModule(), "nCurrentY", 0);
    } else // not valid, use the queue
    {
        // get the current queue number
        int nCurrentQueue = GetLocalInt(GetModule(), "nQueueMin");

        // get current location
        nX = GetLocalInt(GetModule(), "nQueue" + IntToString(nCurrentQueue) + "X");
        nY = GetLocalInt(GetModule(), "nQueue" + IntToString(nCurrentQueue) + "Y");
    }

    DebugMessage("Examining " + IntToString(nX) + "," + IntToString(nY));

    // get coordinates
    object oArea = GetAreaByCoordinates(nX, nY, nCurrentLevel, oDungeon);
    object oArea2;

    // if the area exists
    if (oArea != OBJECT_INVALID)
    {
        // area identifier
        int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");

        // area number
        int nAreaNum = GetLocalInt(oArea, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

        string sLocation = "Level" + IntToString(nCurrentLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY);

        // if it's a staircase
        if ((GetLocalInt(oDungeon, "b" + sLocation + "StairsUp") == TRUE) || (GetLocalInt(oDungeon, "b" + sLocation + "StairsDown") == TRUE))
        {
            // add adjacent areas, then restart
            AddAdjacentAreas(nX, nY, nCurrentLevel, oDungeon);

//            DelayCommand(0.01, ExecuteScript("exe_id1_bossgen", GetNextCPU()));
        } else /// there are no stairs here
        {
//            RemoveArea(nCurrentLevel, oArea, oDungeon);

            // if there is not an area specified
            string sBossArea = GetLocalString(oDungeon, "sBossAreaResRef");

            DebugMessage("Boss area resref is " + sBossArea);

            if (sBossArea != "")
            {
                DebugMessage("Setting specific boss area.");

                oArea2 = GetObjectByTag(sBossArea);
            } else // there is no boss area specified
            {
                DebugMessage("Picking a generic boss area based on theme.");

                string sResRef = GetTilesetResRef(oArea);

                oArea2 = GetUnusedArea(sResRef, 4, 15, nCurrentLevel, ID1_BOSS_AREA, oDungeon);
            }

//            SetArea(nX, nY, nCurrentLevel, oArea2, oDungeon);
            SetLocalInt(oDungeon, "b" + sLocation + "Boss", TRUE);

//            DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
        }
    } else // area does not exist
    {
        // examine the rest of the line
        string sArea = "nLevel" + IntToString(nCurrentLevel) + "Area";
        int nAreaNum = GetLocalInt(oDungeon, sArea + IntToString(nX) + "_" + IntToString(nY));
        while ((nX <= nMaxX) && (nAreaNum == 0))
        {
            nX++;
            nAreaNum = GetLocalInt(oDungeon, sArea + IntToString(nX) + "_" + IntToString(nY));
        }

        // if the line was exhausted
        if (nAreaNum == 0)
        {
            if (nX > nMaxX)
            {
                nX = 1;
                nY++;
            }

            if (nY > nMaxY)
            {
                nY = 1;
            }

//            SetLocalInt(GetModule(), "nCurrentX", nX);
//            SetLocalInt(GetModule(), "nCurrentY", nY);

            AddToQueue(nX, nY, "");

//            DelayCommand(0.01, ExecuteScript("exe_id1_bossgen", GetNextCPU()));
        } else // if an area was found
        {
            AddToQueue(nX, nY, "");
        }
    }

    // if a boss area was placed
    if (oArea2 != OBJECT_INVALID)
    {
        DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
    } else
    {
        int nCurrentQueue = GetLocalInt(GetModule(), "nQueueMin");
        nCurrentQueue++;
        SetLocalInt(GetModule(), "nQueueMin", nCurrentQueue);

        int nQueueMax = GetLocalInt(GetModule(), "nQueueMax");
        DebugMessage("On " + IntToString(nCurrentQueue) + " of " + IntToString(nQueueMax));

        if (nCurrentQueue <= nQueueMax)
        {
            DelayCommand(0.01, ExecuteScript("exe_id1_bossgen", GetNextCPU()));
        } else
        {
            DebugMessage("Cannot assign.");

            DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
        }
    }
    // if the queue has been exhausted

//    SetLocalInt(GetModule(), "bForcingBoss", TRUE);
}
