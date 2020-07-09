//:://////////////////////////////////////////////////////////////
//:: exe_id1_                                            //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: September 2005                                 //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Include Files                                                //
//////////////////////////////////////////////////////////////////

#include "inc_id1_gen"

// object GetNextCPU()
#include "inc_id1_utility"


//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

#include "inc_id1_debug"
void main()
{
    // check the current line of the map
    int nX = 0;
    int nY = GetLocalInt(GetModule(), "nCurrentY");
    object oDungeon = GetCurrentDungeon();

    int nMaxX = GetLocalInt(oDungeon, "nMaxX");
    int nMaxY = GetLocalInt(oDungeon, "nMaxY");
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");

    int nAreaNum;

    int nOpenDecor;
    int nOpenDecorMax;
    int nWallDecor;
    int nWallDecorMax;
    int nDecorPointMax;
    int nDecorPoint;
    int nPoint;
    int bUsed;
    string sPoint;
    int nDecor;
    int nRandom;

    string sTileset;
    int nTileset;

    int nDecorPercentage = GetModuleFlagValue(ID1_FLAG_DECOR_FREQUENCY);
    if (nDecorPercentage > 0)
    {
        // go through each area in this line
        for (nX = 1; nX <= nMaxX; nX++)
        {
            DebugMessage("  Examining area at coordinates " + IntToString(nX) + "," + IntToString(nY));

            nAreaNum = GetLocalInt(oDungeon, "nLevel" + IntToString(nCurrentLevel) + "Area" + IntToString(nX) + "_" + IntToString(nY));
            sTileset = GetLocalString(oDungeon, "sArea" + IntToString(nAreaNum) + "Tileset");
            nTileset = GetLocalInt(GetModule(), "nTileset_" + sTileset);

            DebugMessage("    Tileset is " + sTileset + " which is number " + IntToString(nTileset));

            if (nAreaNum > 0)
            {
                DebugMessage("    Returned area number " + IntToString(nAreaNum));

                if (nTileset > 0)
                {
                    DebugMessage("    Returned tileset number " + IntToString(nTileset));

                    nOpenDecorMax = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "WaypointDecorOpen");

                    DebugMessage("    There are " + IntToString(nOpenDecorMax) + " open decor waypoints.");

                    // if there are points to select from
                    if (nOpenDecorMax > 0)
                    {
                        nOpenDecor = 1;
                        while (nOpenDecor <= nOpenDecorMax)
                        {
                            nRandom = d100();
                            DebugMessage("Random Number was " + IntToString(nRandom) + " vs " + IntToString(nDecorPercentage));
                            if (nRandom <= nDecorPercentage)
                            {
                                // assign random decor point
                                sPoint = "Area" + IntToString(nAreaNum) + "WaypointDecorOpen" + IntToString(nOpenDecor) + "Level" + IntToString(nCurrentLevel);
                                SetLocalInt(oDungeon, "b" + sPoint + "Used", TRUE);
                                nRandom = Random(GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "OpenDecor")) + 1;
                                nDecor = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "OpenDecor" + IntToString(nRandom));
                                SetLocalInt(oDungeon, "n" + sPoint + "Object", nDecor);
                                DebugMessage("        Set decor point " + IntToString(nOpenDecor) + " to " + IntToString(nDecor));
                            }

                            nOpenDecor++;
                        }
                    }


                    nWallDecorMax = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "WaypointDecorWall");

                    DebugMessage("    There are " + IntToString(nWallDecorMax) + " wall decor waypoints.");

                    // if there are points to select from
                    if (nWallDecorMax > 0)
                    {
                        nWallDecor = 1;
                        while (nWallDecor <= nWallDecorMax)
                        {
                            nRandom = d100();
                            DebugMessage("Random Number was " + IntToString(nRandom) + " vs " + IntToString(nDecorPercentage));
                            if (nRandom <= nDecorPercentage)
                            {
                                // assign random decor point
                                sPoint = "Area" + IntToString(nAreaNum) + "WaypointDecorWall" + IntToString(nWallDecor) + "Level" + IntToString(nCurrentLevel);
                                SetLocalInt(oDungeon, "b" + sPoint + "Used", TRUE);
                                nRandom = Random(GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "WallDecor")) + 1;
                                nDecor = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "WallDecor" + IntToString(nRandom));
                                SetLocalInt(oDungeon, "n" + sPoint + "Object", nDecor);
                                DebugMessage("        Set decor point " + IntToString(nWallDecor) + " to " + IntToString(nDecor));
                            }

                            nWallDecor++;
                        }
                    }
                }
            }
        }

        // increment Y coordinate
        nY++;

        // if the entire map has not been gone through yet
        if (nY <= nMaxY)
        {
            DebugMessage ("Advancing Y to " + IntToString(nY));

            // set new Y value
            SetLocalInt(GetModule(), "nCurrentY", nY);

            // execute next script
            DelayCommand(0.01, ExecuteScript("exe_id1_decorgen", GetNextCPU()));
        } else
        {
            // execute next script
            DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
        }
    } else
    {
        // execute next script
        DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
    }
}

