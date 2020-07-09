//:://////////////////////////////////////////////////////////////
//:: exe_id1_catedown                                           //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    This script gathers information on the emergency down area and
    catalogues it. This script ignores all objects in the area
    except the staircase down and the doors.
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: September 2005                                 //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Include Files                                                //
//////////////////////////////////////////////////////////////////
#include "inc_id1_debug"

// int GetDoorType(object oDoor)
#include "inc_id1_gen"

// object GetNextCPU()
#include "inc_id1_utility"


//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    DebugMessage("Checking for the emergency down area.");

    // grab the emergency down area
    object oArea = GetObjectByTag("EmergencyDown");

    // examine the emergency down area
    if (GetIsObjectValid(oArea))
    {
        DebugMessage("  Emergency Staircase Down found.");

        // record the unique area identifier on this area
        SetLocalInt(oArea, "nAreaIdentifier", -2);
        SetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(-2), oArea);
        DebugMessage("  Area Identifier is " + IntToString(GetLocalInt(oArea, "nAreaIdentifier")));

        // set base value for door configuration
        SetLocalInt(oArea, "nDoor", 0);

        // set base number of down staircases in the area
        SetLocalInt(oArea, "nStairsDown", 0);

        // get the first object in area
        object oObject = GetFirstObjectInArea(oArea);

        // object tag
        string sTag;

        // door configuration variable
        int nDoor;

        // new door configuration
        int nDoorType;

        // number of down staircases currently
        int nStairsDown;

        // cycle through objects in the area
        while (oObject != OBJECT_INVALID)
        {
            // get the tag of the current object
            sTag = GetTag(oObject);


            //////////////////////////////////////////////////////////////////
            // Doors                                                        //
            //////////////////////////////////////////////////////////////////

            if (sTag == "ID1_STATIC_DOOR")
            {
                // get the current number of doors
                nDoor = GetLocalInt(oArea, "nDoor");

                // add the new door to the door configuration
                nDoorType = GetDoorType(oObject);
                nDoor += nDoorType;

                // set the new door configuration
                SetLocalInt(oArea, "nDoor", nDoor);

                // add a link to the door object
                if (nDoorType == ID1_DOOR_NORTH)
                {
                    DebugMessage("    Setting North door.");
                    SetLocalObject(oArea, "oDoorNorth", oObject);
                } else if (nDoorType == ID1_DOOR_EAST)
                {
                    DebugMessage("    Setting East door.");
                    SetLocalObject(oArea, "oDoorEast", oObject);
                } else if (nDoorType == ID1_DOOR_SOUTH)
                {
                    DebugMessage("    Setting South door.");
                    SetLocalObject(oArea, "oDoorSouth", oObject);
                } else if (nDoorType == ID1_DOOR_WEST)
                {
                    DebugMessage("    Setting West door.");
                    SetLocalObject(oArea, "oDoorWest", oObject);
                }
            }


            //////////////////////////////////////////////////////////////////
            // Down Staircase                                               //
            //////////////////////////////////////////////////////////////////

            if (sTag == "ID1_STATIC_STAIRSDOWN")
            {
                DebugMessage("    Adding Down Staircase.");
                nStairsDown = GetLocalInt(oArea, "nStairsDown");
                SetLocalInt(oArea, "nStairsDown", nStairsDown + 1);
                SetLocalObject(oArea, "oStairsDown", oObject);
            }


            // get next object in area
            oObject = GetNextObjectInArea(oArea);
        }

        DebugMessage("  " + IntToString(GetLocalInt(oArea, "nDoor")) + " doors, " + IntToString(GetLocalInt(oArea, "nStairsDown")) + " stairs down.");
    } else
    {
        DebugMessage("  No emergency down staircase area found.");
    }

    // return to catalog generation
    DelayCommand(0.01, ExecuteScript("exe_id1_catalog", GetNextCPU()));
}

