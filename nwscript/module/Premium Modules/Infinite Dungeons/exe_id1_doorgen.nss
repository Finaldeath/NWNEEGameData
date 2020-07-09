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
#include "inc_id1_debug"

#include "inc_id1_gen"

// object GetNextCPU()
#include "inc_id1_utility"


//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    // check the current line of the map
    int nX = 0;
    int nY = GetLocalInt(GetModule(), "nCurrentY");
    object oDungeon = GetCurrentDungeon();
    int nMaxX = GetLocalInt(oDungeon, "nMaxX");
    int nMaxY = GetLocalInt(oDungeon, "nMaxY");
    int nLevel = GetLocalInt(GetModule(), "nCurrentLevel");
    int nAreaIdentifier;
    int nAreaNum;
    int nAreaNum2;

    string sTemp;

    object oArea;
    object oArea2;
    object oDoor;
    object oDoor2;

    object oDoorTarget;
    object oDoor2Target;

    DebugMessage("");
    DebugMessage("Max is " + IntToString(nMaxX) + "," + IntToString(nMaxY) + " on level " + IntToString(nLevel));

    // go through each area in this line
    for (nX = 1; nX <= nMaxX; nX++)
    {
        DebugMessage("Examining door coordinates " + IntToString(nX) + "," + IntToString(nY));

        // check to see if theres an area at this place on the map
        oArea = GetAreaByCoordinates(nX, nY, nLevel);

        // if the area exists
        if (oArea != OBJECT_INVALID)
        {
            int nType = GetLocalInt(oArea, "nDoor");
            DebugMessage("Area exists is configuration " + IntToString(nType));

            // check north door
            oDoor = GetLocalObject(oArea, "oDoorNorth");

            if ((oDoor != OBJECT_INVALID) && (nY < nMaxY))
            {
                DebugMessage("  Has north door.");

                // check to see if there is an area to the north
                oArea2 = GetAreaByCoordinates(nX, nY + 1, nLevel);
                if (oArea2 != OBJECT_INVALID)
                {
                    DebugMessage("    Target area exists.");

                    // check to see if it has a south door
                    oDoor2 = GetLocalObject(oArea2, "oDoorSouth");
                    if (oDoor2 != OBJECT_INVALID)
                    {
                        DebugMessage("    Target area has south door.");

                        // get area number
                        nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
                        nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

                        // get area 2 number
                        nAreaIdentifier = GetLocalInt(oArea2, "nAreaIdentifier");
                        nAreaNum2 = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

                        // set area north destination
                        sTemp = "nArea" + IntToString(nAreaNum) + "Level" + IntToString(nLevel) + "North";
                        SetLocalInt(oDungeon, sTemp, nAreaNum2);

                        DebugMessage("    Setting " + sTemp);
                    }
                }
            }

            // check east door
            oDoor = GetLocalObject(oArea, "oDoorEast");

            if ((oDoor != OBJECT_INVALID) && (nX < nMaxX))
            {
                DebugMessage("  Has east door.");

                // check to see if there is an area to the east
                oArea2 = GetAreaByCoordinates(nX + 1, nY, nLevel);
                if (oArea2 != OBJECT_INVALID)
                {
                    DebugMessage("    Target area exists.");

                    // check to see if it has a south door
                    oDoor2 = GetLocalObject(oArea2, "oDoorWest");
                    if (oDoor2 != OBJECT_INVALID)
                    {
                        DebugMessage("    Target area has west door.");

                        // get area number
                        nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
                        nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

                        // get area 2 number
                        nAreaIdentifier = GetLocalInt(oArea2, "nAreaIdentifier");
                        nAreaNum2 = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

                        // set area east destination
                        sTemp = "nArea" + IntToString(nAreaNum) + "Level" + IntToString(nLevel) + "East";
                        SetLocalInt(oDungeon, sTemp, nAreaNum2);

                        DebugMessage("    Setting " + sTemp);
                    }
                }
            }

            // check south door
            oDoor = GetLocalObject(oArea, "oDoorSouth");

            if ((oDoor != OBJECT_INVALID) && (nY > 1))
            {
                DebugMessage("  Has south door.");

                // check to see if there is an area to the south
                oArea2 = GetAreaByCoordinates(nX, nY - 1, nLevel);
                if (oArea2 != OBJECT_INVALID)
                {
                    DebugMessage("    Target area exists.");

                    // check to see if it has a north door
                    oDoor2 = GetLocalObject(oArea2, "oDoorNorth");
                    if (oDoor2 != OBJECT_INVALID)
                    {
                        DebugMessage("    Target area has north door.");

                        // get area number
                        nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
                        nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

                        // get area 2 number
                        nAreaIdentifier = GetLocalInt(oArea2, "nAreaIdentifier");
                        nAreaNum2 = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

                        // set area south destination
                        sTemp = "nArea" + IntToString(nAreaNum) + "Level" + IntToString(nLevel) + "South";
                        SetLocalInt(oDungeon, sTemp, nAreaNum2);

                        DebugMessage("    Setting " + sTemp);
                    }
                }
            }

            // check west door
            oDoor = GetLocalObject(oArea, "oDoorWest");

            if ((oDoor != OBJECT_INVALID) && (nX > 1))
            {
                DebugMessage("  Has west door.");

                // check to see if there is an area to the north
                oArea2 = GetAreaByCoordinates(nX - 1, nY, nLevel);
                if (oArea2 != OBJECT_INVALID)
                {
                    DebugMessage("    Target area exists.");

                    // check to see if it has a east door
                    oDoor2 = GetLocalObject(oArea2, "oDoorEast");
                    if (oDoor2 != OBJECT_INVALID)
                    {
                        DebugMessage("    Target area has east door.");

                        // get area number
                        nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
                        nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

                        // get area 2 number
                        nAreaIdentifier = GetLocalInt(oArea2, "nAreaIdentifier");
                        nAreaNum2 = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

                        // set area west destination
                        sTemp = "nArea" + IntToString(nAreaNum) + "Level" + IntToString(nLevel) + "West";
                        SetLocalInt(oDungeon, sTemp, nAreaNum2);

                        DebugMessage("    Setting " + sTemp);
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
        DelayCommand(0.01, ExecuteScript("exe_id1_doorgen", GetNextCPU()));
    } else
    {
        // execute next script
        DelayCommand(0.01, ExecuteScript("exe_id1_levelgen", GetNextCPU()));
    }
}

