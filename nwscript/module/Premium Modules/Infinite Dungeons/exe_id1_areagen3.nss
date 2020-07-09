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
    DebugMessage("Area generation process 3.");

    // get stairs up area
    object oDungeon = GetCurrentDungeon();
    int nLevel = GetCurrentLevel();
    int nStairsUp = GetLocalInt(oDungeon, "nLevel" + IntToString(nLevel) + "StairsUp1");
    DebugMessage("  Stairs on level + " + IntToString(nLevel) + " is area number " + IntToString(nStairsUp));

    // pick a random location
    int nMaxX = GetLocalInt(oDungeon, "nMaxX");
    int nMaxY = GetLocalInt(oDungeon, "nMaxY");
    int nX = Random(nMaxX) + 1;
    int nY = Random(nMaxY) + 1;
    int nStartX = -1;
    int nStartY = -1;
    int nAreaNum = GetLocalInt(oDungeon, "nLevel" + IntToString(nLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY));
    DebugMessage("  nLevel" + IntToString(nLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY) + " is " + IntToString(nAreaNum));

    // while not an area, or is the stairs up, advance
    while (((nAreaNum == 0) || (nAreaNum == nStairsUp)) && !((nX == nStartX) && (nY == nStartY)))
    {
        if (nStartX == -1)
        {
            nStartX = nX;
            nStartY = nY;
        }
        nX++;
        if (nX > nMaxX)
        {
            nX = 1;
            nY++;
        }
        if (nY > nMaxY)
        {
            nY = 1;
        }
        nAreaNum = GetLocalInt(oDungeon, "nLevel" + IntToString(nLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY));
        DebugMessage("  nLevel" + IntToString(nLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY) + " is " + IntToString(nAreaNum));
    }

    // set stairs down or boss area
    if (nAreaNum != 0)
    {
        int nAreaIdentifier = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "Identifier");
        int nTileset = GetTilesetNumber(nAreaIdentifier);
        int nDungeonDepth = GetLocalInt(oDungeon, "nDungeonDepth");
        int nArea;

        // remove previous area
        RemoveArea(nLevel, nAreaIdentifier, oDungeon);

        if (nLevel == nDungeonDepth)
        {
            // if a boss area is already defined
            string sBossArea = GetLocalString(oDungeon, "sBossAreaResRef");
            DebugMessage("  Boss area tag is " + sBossArea);

            if (sBossArea == "")
            {
                int bDungeonPresent = GetLocalInt(oDungeon, "bTileset6Present");
                int bRuinsPresent = GetLocalInt(oDungeon, "bTileset11Present");
                int bMinesPresent = GetLocalInt(oDungeon, "bTileset10Present");

                // determine closest boss area
                int nBoss = Random(6) + 1;
                if (nBoss == 1) // 123
                {
                    if (bDungeonPresent == TRUE)
                    {
                        sBossArea = "BossArea001";
                    } else if (bRuinsPresent == TRUE)
                    {
                        sBossArea = "BossArea002";
                    } else
                    {
                        sBossArea = "BossArea003";
                    }
                } else if (nBoss == 2) // 132
                {
                    if (bDungeonPresent == TRUE)
                    {
                        sBossArea = "BossArea001";
                    } else if (bMinesPresent == TRUE)
                    {
                        sBossArea = "BossArea003";
                    } else
                    {
                        sBossArea = "BossArea002";
                    }
                } else if (nBoss == 3) // 213
                {
                    if (bRuinsPresent == TRUE)
                    {
                        sBossArea = "BossArea002";
                    } else if (bDungeonPresent == TRUE)
                    {
                        sBossArea = "BossArea001";
                    } else
                    {
                        sBossArea = "BossArea003";
                    }
                } else if (nBoss == 4) // 231
                {
                    if (bRuinsPresent == TRUE)
                    {
                        sBossArea = "BossArea002";
                    } else if (bMinesPresent == TRUE)
                    {
                        sBossArea = "BossArea003";
                    } else
                    {
                        sBossArea = "BossArea001";
                    }
                } else if (nBoss == 5) // 312
                {
                    if (bMinesPresent == TRUE)
                    {
                        sBossArea = "BossArea003";
                    } else if (bDungeonPresent == TRUE)
                    {
                        sBossArea = "BossArea001";
                    } else
                    {
                        sBossArea = "BossArea002";
                    }
                } else // 321
                {
                    if (bMinesPresent == TRUE)
                    {
                        sBossArea = "BossArea003";
                    } else if (bRuinsPresent == TRUE)
                    {
                        sBossArea = "BossArea002";
                    } else
                    {
                        sBossArea = "BossArea001";
                    }
                }
            }
            DebugMessage("  Final boss area is " + sBossArea);

            object oArea = GetObjectByTag(sBossArea);
            nArea = GetLocalInt(oArea, "nAreaIdentifier");
            SetLocalInt(oDungeon, "bLevel" + IntToString(nLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY) + "Boss", TRUE);

            // add new area
            SetArea(nX, nY, nArea, nLevel, oDungeon);
        } else
        {
            string sStairsDown = "EmergencyDown";

            // get the tileset number
            if ((nTileset == BEHOLDER_CAVES) || (nTileset == FOREST))
            {
                nTileset = UNDERDARK;
            }

            if (nTileset == CASTLE_INTERIOR)
            {
                sStairsDown = "Area286";
            } else if (nTileset == CRYPT)
            {
                sStairsDown = "Area287";
            } else if (nTileset == DESERT)
            {
                sStairsDown = "Area288";
            } else if (nTileset == DROW_INTERIOR)
            {
                sStairsDown = "Area289";
            } else if (nTileset == DUNGEON)
            {
                sStairsDown = "Area290";
            } else if (nTileset == FROZEN_WASTES)
            {
                sStairsDown = "Area291";
            } else if (nTileset == ILLITHID_INTERIOR)
            {
                sStairsDown = "Area292";
            } else if (nTileset == MINES_AND_CAVERNS)
            {
                sStairsDown = "Area293";
            } else if (nTileset == RUINS)
            {
                sStairsDown = "Area294";
            } else if (nTileset == SEWERS)
            {
                sStairsDown = "Area295";
            } else if (nTileset == UNDERDARK)
            {
                sStairsDown = "Area298";
            } else if (nTileset == STEAMWORKS)
            {
                sStairsDown = "Area296";
            } else if (nTileset == KEEP_INTERIOR_STONE)
            {
                sStairsDown = "Area297";
            }
            DebugMessage("  Final stairs down is " + sStairsDown);

            object oArea = GetObjectByTag(sStairsDown);
            nArea = GetLocalInt(oArea, "nAreaIdentifier");
            SetLocalInt(oDungeon, "bLevel" + IntToString(nLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY) + "StairsDown", TRUE);

            // add new area
            SetArea(nX, nY, nArea, nLevel, oDungeon);

            int nDownAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nArea) + "Area");
            DebugMessage("Stairs down is area number " + IntToString(nDownAreaNum));
            SetLocalInt(oDungeon, "nLevel" + IntToString(nLevel) + "StairsDown", 1);
            SetLocalInt(oDungeon, "nLevel" + IntToString(nLevel) + "StairsDown1", nDownAreaNum);
        }
    } else
    {
        DebugMessage("  No staircase could be generated.");
    }

    SetLocalInt(GetModule(), "nLevelProcess", 5);
    DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
}

