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

int HasNorthExit(int nConfiguration);
int HasEastExit(int nConfiguration);
int HasSouthExit(int nConfiguration);
int HasWestExit(int nConfiguration);

//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    DebugMessage("");
    DebugMessage("Area generation process 2.");

    // get temporary object
    object oTempHolder = GetLocalObject(GetModule(), "oTempHolder");

    // get position in the queue
    int nQueuePosition = GetLocalInt(oTempHolder, "nQueuePosition");
    int nQueueMax = GetLocalInt(oTempHolder, "nQueueMax");
    DebugMessage("  Queue position is " + IntToString(nQueuePosition) + " out of " + IntToString(nQueueMax));

    // get coordinates
    int nPosition = GetLocalInt(oTempHolder, "nQueue" + IntToString(nQueuePosition) + "Pos");
    DebugMessage("  Area position is " + IntToString(nPosition));
    object oDungeon = GetCurrentDungeon();
    int nMaxX = GetLocalInt(oDungeon, "nMaxX");
    int nMaxY = GetLocalInt(oDungeon, "nMaxY");
    DebugMessage("  Dungeon size is " + IntToString(nMaxX) + "," + IntToString(nMaxY));
    int nY = 1;
    int nX;
    while (nPosition > nMaxX)
    {
        nY++;
        nPosition -= nMaxX;
    }
    nX = nPosition;
    DebugMessage("  Actual area position is " + IntToString(nX) + "," + IntToString(nY));

    // get tileset
    int nTileset = GetLocalInt(oTempHolder, "nQueue" + IntToString(nQueuePosition) + "Tileset");
    DebugMessage("  Previous area tileset is " + IntToString(nTileset));

    // determine ideal size
    int nOneExitChance = GetModuleFlagValue(ID1_FLAG_DUNGEON_ONE_EXIT);
    int nTwoExitChance = nOneExitChance + GetModuleFlagValue(ID1_FLAG_DUNGEON_TWO_EXIT);
    int nThreeExitChance = nTwoExitChance + GetModuleFlagValue(ID1_FLAG_DUNGEON_THREE_EXIT);
    int nFourExitChance = nThreeExitChance + GetModuleFlagValue(ID1_FLAG_DUNGEON_FOUR_EXIT);
    DebugMessage("  Exit chances: 1 = " + IntToString(nOneExitChance) + ", 2 = " + IntToString(nTwoExitChance) + ", 3 = " + IntToString(nThreeExitChance) + ", 4 = " + IntToString(nFourExitChance));
    int nRandom = Random(nFourExitChance) + 1;
    int nIdealSize;
    if (nRandom <= nOneExitChance)
    {
        nIdealSize = 1;
    } else if (nRandom <= nTwoExitChance)
    {
        nIdealSize = 2;
    } else if (nRandom <= nThreeExitChance)
    {
        nIdealSize = 3;
    } else
    {
        nIdealSize = 4;
    }
    DebugMessage("  Random is " + IntToString(nRandom) + " and ideal size is " + IntToString(nIdealSize));

    // determine mandatory size
    int nLevel = GetCurrentLevel();
    int nMandatorySize;
    int nMandatoryConfiguration;
    int nConfiguration;
    int bNorthPossible;
    int bEastPossible;
    int bSouthPossible;
    int bWestPossible;

    int nNorth = GetLocalInt(oDungeon, "nLevel" + IntToString(nLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY + 1));
    DebugMessage("  Area to north is number " + IntToString(nNorth));
    if (nNorth > 0)
    {
        nConfiguration = GetLocalInt(oDungeon, "nArea" + IntToString(nNorth) + "Door");
        DebugMessage("  North configuration is " + IntToString(nConfiguration));
        if (HasSouthExit(nConfiguration) == TRUE)
        {
            nMandatorySize++;
            nMandatoryConfiguration += 1;
        }
    } else
    {
        // if not out of bounds
        if (nY < nMaxY)
        {
            bNorthPossible = TRUE;
        }
    }

    int nEast = GetLocalInt(oDungeon, "nLevel" + IntToString(nLevel) + "Area" + IntToString(nX + 1) + "_" + IntToString(nY));
    DebugMessage("  Area to east is number " + IntToString(nEast));
    if (nEast > 0)
    {
        nConfiguration = GetLocalInt(oDungeon, "nArea" + IntToString(nEast) + "Door");
        DebugMessage("  East configuration is " + IntToString(nConfiguration));
        if (HasWestExit(nConfiguration) == TRUE)
        {
            nMandatorySize++;
            nMandatoryConfiguration += 2;
        }
    } else
    {
        // if not out of bounds
        if (nX < nMaxX)
        {
            bEastPossible = TRUE;
        }
    }

    int nSouth = GetLocalInt(oDungeon, "nLevel" + IntToString(nLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY - 1));
    DebugMessage("  Area to south is number " + IntToString(nSouth));
    if (nSouth > 0)
    {
        nConfiguration = GetLocalInt(oDungeon, "nArea" + IntToString(nSouth) + "Door");
        DebugMessage("  South configuration is " + IntToString(nConfiguration));
        if (HasNorthExit(nConfiguration) == TRUE)
        {
            nMandatorySize++;
            nMandatoryConfiguration += 4;
        }
    } else
    {
        // if not out of bounds
        if (nY > 1)
        {
            bSouthPossible = TRUE;
        }
    }

    int nWest = GetLocalInt(oDungeon, "nLevel" + IntToString(nLevel) + "Area" + IntToString(nX - 1) + "_" + IntToString(nY));
    DebugMessage("  Area to west is number " + IntToString(nWest));
    if (nWest > 0)
    {
        nConfiguration = GetLocalInt(oDungeon, "nArea" + IntToString(nWest) + "Door");
        DebugMessage("  West configuration is " + IntToString(nConfiguration));
        if (HasEastExit(nConfiguration) == TRUE)
        {
            nMandatorySize++;
            nMandatoryConfiguration += 8;
        }
    } else
    {
        // if not out of bounds
        if (nX > 1)
        {
            bWestPossible = TRUE;
        }
    }

    DebugMessage("  Mandatory size is " + IntToString(nMandatorySize));
    DebugMessage("  Mandatory configuration is " + IntToString(nMandatoryConfiguration));

    // get ideal configuration
    int nIdealConfiguration = nMandatoryConfiguration;
    if (nMandatorySize >= nIdealSize)
    {
        nIdealSize = nMandatorySize;
    } else
    {
        int bFailed = FALSE;
        while ((nMandatorySize < nIdealSize) && (bFailed == FALSE))
        {
            if (bNorthPossible == TRUE)
            {
                bNorthPossible = FALSE;
                nMandatorySize++;
                nIdealConfiguration += 1;
            } else if (bEastPossible == TRUE)
            {
                bEastPossible = FALSE;
                nMandatorySize++;
                nIdealConfiguration += 2;
            } else if (bSouthPossible == TRUE)
            {
                bSouthPossible = FALSE;
                nMandatorySize++;
                nIdealConfiguration += 4;
            } else if (bWestPossible == TRUE)
            {
                bWestPossible = FALSE;
                nMandatorySize++;
                nIdealConfiguration += 8;
            } else
            {
                bFailed = TRUE;
            }
        }

    }

    DebugMessage("  Ideal size is " + IntToString(nIdealSize));
    DebugMessage("  Ideal configuration is " + IntToString(nIdealConfiguration));
/*
    // get distance 0 area
    int nArea = GetDistanceArea(nTileset, 0, nIdealConfiguration, nMandatoryConfiguration, nLevel, oDungeon);
    DebugMessage("  Distance 0 area is " + IntToString(nArea));

    if (nArea == 0)
    {
        // get distance 1 area
        nArea = GetDistanceArea(nTileset, 1, nIdealConfiguration, nMandatoryConfiguration, nLevel, oDungeon);
        DebugMessage("  Distance 1 area is " + IntToString(nArea));
    }

    if (nArea == 0)
    {
        // get distance 2 area
        nArea = GetDistanceArea(nTileset, 2, nIdealConfiguration, nMandatoryConfiguration, nLevel, oDungeon);
        DebugMessage("  Distance 2 area is " + IntToString(nArea));
    }

    if (nArea == 0)
    {
        // get distance 3 area
        nArea = GetDistanceArea(nTileset, 3, nIdealConfiguration, nMandatoryConfiguration, nLevel, oDungeon);
        DebugMessage("  Distance 3 area is " + IntToString(nArea));
    }*/

    // find the number of areas that are needed to be checked
    int nAreaListNum = GetAreaCategorySize(nMandatoryConfiguration);
    DebugMessage("  There are " + IntToString(nAreaListNum) + " possible areas");
    int nAreaList = 1;
    int nArea;
    int nDistance;
    while ((nAreaList <= (nAreaListNum + 3)) && (nArea == 0))
    {
        DebugMessage("    Checking area " + IntToString(nAreaList));

        // check distance 0 area
        if (nAreaList <= nAreaListNum)
        {
            nDistance = 0;
            nArea = GetDistanceArea(nTileset, nAreaList, nDistance, nIdealConfiguration, nMandatoryConfiguration, nLevel, oDungeon);
        }
        DebugMessage("    Distance " + IntToString(nDistance) + " area is " + IntToString(nArea));

        // check distance 1 area
        if (nArea == 0)
        {
            nDistance = 1;
            if ((nAreaList > nDistance) && (nAreaList <= (nAreaListNum + nDistance)))
            {
                nArea = GetDistanceArea(nTileset, nAreaList, nDistance, nIdealConfiguration, nMandatoryConfiguration, nLevel, oDungeon);
            }
        }
        DebugMessage("    Distance " + IntToString(nDistance) + " area is " + IntToString(nArea));

        // check distance 2 area
        if (nArea == 0)
        {
            nDistance = 2;
            if ((nAreaList > nDistance) && (nAreaList <= (nAreaListNum + nDistance)))
            {
                nArea = GetDistanceArea(nTileset, nAreaList, nDistance, nIdealConfiguration, nMandatoryConfiguration, nLevel, oDungeon);
            }
        }
        DebugMessage("    Distance " + IntToString(nDistance) + " area is " + IntToString(nArea));

        // check distance 3 area
        if (nArea == 0)
        {
            nDistance = 3;
            if ((nAreaList > nDistance) && (nAreaList <= (nAreaListNum + nDistance)))
            {
                nArea = GetDistanceArea(nTileset, nAreaList, nDistance, nIdealConfiguration, nMandatoryConfiguration, nLevel, oDungeon);
            }
        }
        DebugMessage("    Distance " + IntToString(nDistance) + " area is " + IntToString(nArea));

        // advance to next type of area
        nAreaList++;
    }

    // if an area exists
    if (nArea != 0)
    {
        // set the area at this location
        SetArea(nX, nY, nArea, nLevel, oDungeon);

        // get configuration information
        int nAreaNum = GetLocalInt(oDungeon, "nLevel" + IntToString(nLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY));
        int nConfiguration = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "Door");
        DebugMessage("  Set as area number " + IntToString(nAreaNum) + " with configuration " + IntToString(nConfiguration));

        int nAreaTileset = GetTilesetNumber(nArea);
        DebugMessage("  Tileset of area is " + IntToString(nAreaTileset));

        // add exits to queue
        if (nConfiguration >= 8)
        {
            DebugMessage("  Has west exit.");

            nConfiguration -= 8;

            // check to see if that area exists
            if (nWest == 0)
            {
                DebugMessage("    Area does not exist.");

                if (nX > 1)
                {
                    DebugMessage("    Area is within bounds.");

                    int nPlace = 1;
                    int nTempPos = ((nY - 1) * nMaxX) + nX - 1;
                    DebugMessage("    Checking for position " + IntToString(nTempPos));
                    int nOldPos = 0;
                    while ((nPlace <= nQueueMax) && (nTempPos != nOldPos))
                    {
                        nOldPos = GetLocalInt(oTempHolder, "nQueue" + IntToString(nPlace) + "Pos");
                        DebugMessage("    Checking against position " + IntToString(nOldPos));
                        if (nTempPos != nOldPos)
                        {
                            nPlace++;
                        }
                    }
                    if (nTempPos != nOldPos)
                    {
                        nQueueMax++;
                        SetLocalInt(oTempHolder, "nQueue" + IntToString(nQueueMax) + "Pos", nTempPos);
                        SetLocalInt(oTempHolder, "nQueue" + IntToString(nQueueMax) + "Tileset", nAreaTileset);
                        DebugMessage("    Added position " + IntToString(nTempPos) + " with tileset " + IntToString(nAreaTileset) + " at queue position " + IntToString(nQueueMax));
                    }
                }
            }
        }
        if (nConfiguration >= 4)
        {
            DebugMessage("  Has south exit.");

            nConfiguration -= 4;

            // check to see if that area exists
            if (nSouth == 0)
            {
                DebugMessage("    Area does not exist.");

                if (nY > 1)
                {
                    DebugMessage("    Area is within bounds.");

                    int nPlace = 1;
                    int nTempPos = ((nY - 2) * nMaxX) + nX;
                    DebugMessage("    Checking for position " + IntToString(nTempPos));
                    int nOldPos = 0;
                    while ((nPlace <= nQueueMax) && (nTempPos != nOldPos))
                    {
                        nOldPos = GetLocalInt(oTempHolder, "nQueue" + IntToString(nPlace) + "Pos");
                        DebugMessage("    Checking against position " + IntToString(nOldPos));
                        if (nTempPos != nOldPos)
                        {
                            nPlace++;
                        }
                    }
                    if (nTempPos != nOldPos)
                    {
                        nQueueMax++;
                        SetLocalInt(oTempHolder, "nQueue" + IntToString(nQueueMax) + "Pos", nTempPos);
                        SetLocalInt(oTempHolder, "nQueue" + IntToString(nQueueMax) + "Tileset", nAreaTileset);
                        DebugMessage("    Added position " + IntToString(nTempPos) + " with tileset " + IntToString(nAreaTileset) + " at queue position " + IntToString(nQueueMax));
                    }
                }
            }
        }
        if (nConfiguration >= 2)
        {
            DebugMessage("  Has east exit.");

            nConfiguration -= 2;

            // check to see if that area exists
            if (nEast == 0)
            {
                DebugMessage("    Area does not exist.");

                if (nX < nMaxX)
                {
                    DebugMessage("    Area is within bounds.");

                    int nPlace = 1;
                    int nTempPos = ((nY - 1) * nMaxX) + nX + 1;
                    DebugMessage("    Checking for position " + IntToString(nTempPos));
                    int nOldPos = 0;
                    while ((nPlace <= nQueueMax) && (nTempPos != nOldPos))
                    {
                        nOldPos = GetLocalInt(oTempHolder, "nQueue" + IntToString(nPlace) + "Pos");
                        DebugMessage("    Checking against position " + IntToString(nOldPos));
                        if (nTempPos != nOldPos)
                        {
                            nPlace++;
                        }
                    }
                    if (nTempPos != nOldPos)
                    {
                        nQueueMax++;
                        SetLocalInt(oTempHolder, "nQueue" + IntToString(nQueueMax) + "Pos", nTempPos);
                        SetLocalInt(oTempHolder, "nQueue" + IntToString(nQueueMax) + "Tileset", nAreaTileset);
                        DebugMessage("    Added position " + IntToString(nTempPos) + " with tileset " + IntToString(nAreaTileset) + " at queue position " + IntToString(nQueueMax));
                    }
                }
            }
        }
        if (nConfiguration > 0)
        {
            DebugMessage("  Has north exit.");

            // check to see if that area exists
            if (nNorth == 0)
            {
                DebugMessage("    Area does not exist.");

                if (nY < nMaxY)
                {
                    DebugMessage("    Area is within bounds.");

                    int nPlace = 1;
                    int nTempPos = (nY * nMaxX) + nX;
                    DebugMessage("    Checking for position " + IntToString(nTempPos));
                    int nOldPos = 0;
                    while ((nPlace <= nQueueMax) && (nTempPos != nOldPos))
                    {
                        nOldPos = GetLocalInt(oTempHolder, "nQueue" + IntToString(nPlace) + "Pos");
                        DebugMessage("    Checking against position " + IntToString(nOldPos));
                        if (nTempPos != nOldPos)
                        {
                            nPlace++;
                        }
                    }
                    if (nTempPos != nOldPos)
                    {
                        nQueueMax++;
                        SetLocalInt(oTempHolder, "nQueue" + IntToString(nQueueMax) + "Pos", nTempPos);
                        SetLocalInt(oTempHolder, "nQueue" + IntToString(nQueueMax) + "Tileset", nAreaTileset);
                        DebugMessage("    Added position " + IntToString(nTempPos) + " with tileset " + IntToString(nAreaTileset) + " at queue position " + IntToString(nQueueMax));
                    }
                }
            }
        }
    }
    SetLocalInt(oTempHolder, "nQueueMax", nQueueMax);

    // increment queue
    nQueuePosition++;
    SetLocalInt(oTempHolder, "nQueuePosition", nQueuePosition);

    if (nQueuePosition <= nQueueMax)
    {
        // advance to next area in queue
        DelayCommand(0.01, ExecuteScript("exe_id1_areagen2", GetNextCPU()));
    } else
    {
        // advance to next area in queue
        DelayCommand(0.01, ExecuteScript("exe_id1_areagen3", GetNextCPU()));
    }
}

int HasNorthExit(int nConfiguration)
{
    if (nConfiguration >= 8)
    {
        nConfiguration -= 8;
    }
    if (nConfiguration >= 4)
    {
        nConfiguration -= 4;
    }
    if (nConfiguration >= 2)
    {
        nConfiguration -= 2;
    }
    if (nConfiguration > 0)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}

int HasEastExit(int nConfiguration)
{
    if (nConfiguration >= 8)
    {
        nConfiguration -= 8;
    }
    if (nConfiguration >= 4)
    {
        nConfiguration -= 4;
    }
    if (nConfiguration >= 2)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}

int HasSouthExit(int nConfiguration)
{
    if (nConfiguration >= 8)
    {
        nConfiguration -= 8;
    }
    if (nConfiguration >= 4)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}

int HasWestExit(int nConfiguration)
{
    if (nConfiguration >= 8)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}

