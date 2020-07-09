//:://////////////////////////////////////////////////////////////
//:: exe_id1_cateup                                             //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    This script gathers information on the emergency up area and
    catalogues it. This script ignores all objects in the area
    except the staircase up and the doors.
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
    DebugMessage("Checking for the emergency up area.");

    // grab the emergency up area
    object oArea = GetObjectByTag("EmergencyUp");

    // examine the emergency up area
    if (GetIsObjectValid(oArea))
    {
        DebugMessage("  Emergency Staircase Up found.");

        // record the unique area identifier on this area
        SetLocalInt(oArea, "nAreaIdentifier", -1);
        SetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(-1), oArea);
        DebugMessage("  Area Identifier is " + IntToString(GetLocalInt(oArea, "nAreaIdentifier")));

        // set base value for door configuration
        SetLocalInt(oArea, "nDoor", 0);

        // set base number of up staircases in the area
        SetLocalInt(oArea, "nStairsUp", 0);

        // get the first object in area
        object oObject = GetFirstObjectInArea(oArea);

        // object tag
        string sTag;

        // door configuration variable
        int nDoor;

        // new door configuration
        int nDoorType;

        // number of up staircases currently
        int nStairsUp;

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
            // Up Staircase                                                 //
            //////////////////////////////////////////////////////////////////

            if (sTag == "ID1_STATIC_STAIRSUP")
            {
                DebugMessage("    Adding Up Staircase.");
                nStairsUp = GetLocalInt(oArea, "nStairsUp");
                SetLocalInt(oArea, "nStairsUp", nStairsUp + 1);
                SetLocalObject(oArea, "oStairsUp", oObject);
            }


            // get next object in area
            oObject = GetNextObjectInArea(oArea);
        }

        DebugMessage("  " + IntToString(GetLocalInt(oArea, "nDoor")) + " doors, " + IntToString(GetLocalInt(oArea, "nStairsUp")) + " stairs up.");
    } else
    {
        DebugMessage("  No emergency up staircase area found.");
    }

    // return to catalog generation
    DelayCommand(0.01, ExecuteScript("exe_id1_catalog", GetNextCPU()));
}

