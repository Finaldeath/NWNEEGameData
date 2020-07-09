//:://////////////////////////////////////////////////////////////
//:: exe_id1_dispgen                                            //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    This script generates a line of a map to the log file. It is
    given a specific Y coordinate and writes out the area
    configurations of each X coordinate on that line of the map.
    Once a line is done, it increments the line and executes the
    script on the next processor.
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
    object oDungeon = GetCurrentDungeon();
    int iX = 1;
    int iY = GetLocalInt(GetModule(), "nCurrentY");
    int iMaxX = GetLocalInt(oDungeon, "nMaxX");
    int iLevel = GetLocalInt(GetModule(), "nCurrentLevel");
    int nAreaIdentifier;
    int nAreaNum;
    string sDoor;
    string sTemp1 = "";
    string sTemp2 = "";
    string sTemp3 = "";
    object oArea;
    object oDoor;

    // generate a Y line of the map
    for (iX = 1; iX <= iMaxX; iX++)
    {
        // get the area
        oArea = GetAreaByCoordinates(iX, iY, iLevel);

        nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
        nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

        sDoor = "nArea" + IntToString(nAreaNum) + "Level" + IntToString(iLevel);

        DebugMessage("Checking area " + sDoor);

        // if the area exists
        if (oArea != OBJECT_INVALID)
        {
            oDoor = GetLocalObject(oArea, "oDoorNorth");

            // check for up stairs
            if (GetLocalInt(oArea, "nStairsUp") > 0)
            {
                sTemp1 += "<";
            } else // no stairs
            {
                sTemp1 += ".";
            }

            // if the north door exists
            if (oDoor != OBJECT_INVALID)
            {
                // if the door actually leads somewhere
                if (GetLocalInt(oDungeon, sDoor + "North") > 0)
                {
                    sTemp1 += "|";
                } else // false door
                {
                    sTemp1 += "x";
                }
            } else // no north door
            {
                sTemp1 += ".";
            }

            // check for up stairs
            if (GetLocalInt(oArea, "nStairsDown") > 0)
            {
                sTemp1 += ">";
            } else // no stairs
            {
                sTemp1 += ".";
            }

            oDoor = GetLocalObject(oArea, "oDoorWest");

            // if the west door exists
            if (oDoor != OBJECT_INVALID)
            {
                // if the door actually leads somewhere
                if (GetLocalInt(oDungeon, sDoor + "West") > 0)
                {
                    sTemp2 += "-o";
                } else // false door
                {
                    sTemp2 += "xo";
                }
            } else // no west door
            {
                sTemp2 += ".o";
            }

            oDoor = GetLocalObject(oArea, "oDoorEast");

            // if the east door exists
            if (oDoor != OBJECT_INVALID)
            {
                // if the door actually leads somewhere
                if (GetLocalInt(oDungeon, sDoor + "East") > 0)
                {
                    sTemp2 += "-";
                } else // false door
                {
                    sTemp2 += "x";
                }
            } else // no east door
            {
                sTemp2 += ".";
            }

            oDoor = GetLocalObject(oArea, "oDoorSouth");

            // if the south door exists
            if (oDoor != OBJECT_INVALID)
            {
                sTemp3 += ".";

                // if the door actually leads somewhere
                if (GetLocalInt(oDungeon, sDoor + "South") > 0)
                {
                    sTemp3 += "|.";
                } else // false door
                {
                    sTemp3 += "x.";
                }
            } else // no south door
            {
                sTemp3 += "...";
            }
        } else // if the area does not exist
        {
            sTemp1 += "...";
            sTemp2 += "...";
            sTemp3 += "...";
        }
    }

    // display the line
    DebugMessage(sTemp1);
    DebugMessage(sTemp2);
    DebugMessage(sTemp3);

    // increment to next line
    iY--;

    if (iY >= 1)
    {
        // set new Y value
        SetLocalInt(GetModule(), "nCurrentY", iY);

        // execute next script
        DelayCommand(0.01, ExecuteScript("exe_id1_dispgen", GetNextCPU()));
    }
}

