//:://////////////////////////////////////////////////////////////
//:: ptr_id1_door                                               //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    This is the script that governs all door transitions. When
    run, it depetermines the level its on, and transports the PC
    to the specified destination.
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: July 2005                                      //
//:://////////////////////////////////////////////////////////////

#include "inc_id1_debug"
#include "inc_id1_clean"
#include "inc_id1_flags"
#include "inc_id1_gen"
//#include "inc_id1_trans"
#include "inc_id1_utility"

//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    int bGenerating = GetLocalInt(GetModule(), "bGenerating");
    DebugMessage("Getting bGenerating in door to be " + IntToString(bGenerating));

    if (bGenerating == FALSE)
    {
        // make transitions inaccessible
        SetLocalInt(GetModule(), "bGenerating", TRUE);
        DebugMessage("Setting bGenerating in door to TRUE");

        object oPC = GetClickingObject();

        int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");

        // check to see if the door is linked
        object oArea = GetArea(OBJECT_SELF);
        int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
        object oDungeon = GetCurrentDungeon();
        int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");
        int nDestination;
        string sTemp = "nArea" + IntToString(nAreaNum) + "Level" + IntToString(nCurrentLevel);

        DebugMessage("Current area is " + IntToString(nAreaNum));

        int nX = GetLocalInt(oDungeon, sTemp + "X");
        int nY = GetLocalInt(oDungeon, sTemp + "Y");
        DebugMessage("Location of current area on level " + IntToString(nCurrentLevel) + " is " + IntToString(nX) + "," + IntToString(nY));

        if ((nX == 0) || (nY == 0) || (nCurrentLevel == 0))
        {
            AssignCommand(oPC, SpeakString("This area does not exist on the currently active level. Returning to the dungeon entrance."));

            SetLocalInt(GetModule(), "bGenerating", FALSE);
            DebugMessage("Setting bGenerating in door to FALSE");

            DebugMessage("Clearing actions. Point 34.");
            AssignCommand(oPC, ClearAllActions());
            AssignCommand(oPC, JumpToLocation(GetStartingLocation()));

            // setting plot to false to be safe
            if (GetPlotFlag(oPC) == TRUE)
            {
                DebugMessage("Plot flag was set on player.");
            }
            SetPlotFlag(oPC, FALSE);

            DelayCommand(0.1, ActionCloseDoor(OBJECT_SELF));
        } else
        {
            int nDoorType;
            if (GetLocalObject(oArea, "oDoorNorth") == OBJECT_SELF)
            {
                DebugMessage("This is the north door.");

                nDestination = GetLocalInt(oDungeon, sTemp + "North");
                nDoorType = ID1_DOOR_NORTH;
            } else if (GetLocalObject(oArea, "oDoorEast") == OBJECT_SELF)
            {
                DebugMessage("This is the east door.");

                nDestination = GetLocalInt(oDungeon, sTemp + "East");
                nDoorType = ID1_DOOR_EAST;
            } else if (GetLocalObject(oArea, "oDoorSouth") == OBJECT_SELF)
            {
                DebugMessage("This is the south door.");

                nDestination = GetLocalInt(oDungeon, sTemp + "South");
                nDoorType = ID1_DOOR_SOUTH;
            } else if (GetLocalObject(oArea, "oDoorWest") == OBJECT_SELF)
            {
                DebugMessage("This is the west door.");

                nDestination = GetLocalInt(oDungeon, sTemp + "West");
                nDoorType = ID1_DOOR_WEST;
            }

            if (nDestination > 0)
            {
                DebugMessage("Door has a destination.");

                // put player in cutscene mode
                if (GetCutsceneMode(oPC) == FALSE)
                {
                    DebugMessage("Cutscene mode set on PC.");
                    SetCutsceneMode(oPC, TRUE);
                } else
                {
                    DebugMessage("Cutscene mode already set on PC.");
                }

                // get destination area
                nAreaIdentifier = GetLocalInt(oDungeon, "nArea" + IntToString(nDestination) + "Identifier");
                oArea = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nAreaIdentifier));

                DebugMessage("Area " + IntToString(nAreaIdentifier) + " is " + GetTag(oArea));

                object oDoor;

                if (nDoorType == ID1_DOOR_NORTH)
                {
                    DebugMessage("Linking south door.");

                    oDoor = GetLocalObject(oArea, "oDoorSouth");
                } else if (nDoorType == ID1_DOOR_EAST)
                {
                    DebugMessage("Linking west door.");

                    oDoor = GetLocalObject(oArea, "oDoorWest");
                } else if (nDoorType == ID1_DOOR_SOUTH)
                {
                    DebugMessage("Linking north door.");

                    oDoor = GetLocalObject(oArea, "oDoorNorth");
                } else if (nDoorType == ID1_DOOR_WEST)
                {
                    DebugMessage("Linking east door.");

                    oDoor = GetLocalObject(oArea, "oDoorEast");
                }

                SetLocalObject(oPC, "ptr_id1_door", oDoor);

                // move the player
                SetLocalObject(GetModule(), "oTempPC", oPC);
                SetLocalObject(GetModule(), "oTempDestinationDoor", oDoor);
                SetLocalObject(GetModule(), "oTempDungeon", oDungeon);
                SetLocalInt(GetModule(), "bTempLevelGen", FALSE);
                SetLocalInt(GetModule(), "nActivationProcess", 0);
                SetLocalObject(GetModule(), "oSpeaker", OBJECT_SELF);

                // clean up the area behind the player if necessary
                object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU118");
                SetLocalObject(oMicroCPU, "oArea", GetArea(OBJECT_SELF));
                SetLocalInt(oMicroCPU, "nLevel", nCurrentLevel);
                SetLocalInt(oMicroCPU, "nArea", nAreaNum);
                DelayCommand(0.01, ExecuteScript("exe_id1_cleanare", oMicroCPU));
            } else // no destination
            {
                AssignCommand(oPC, SpeakString("Door does not have a valid destination."));

                SetLocalInt(GetModule(), "bGenerating", FALSE);
                DebugMessage("Setting bGenerating in door to FALSE");

                DelayCommand(0.1, ActionCloseDoor(OBJECT_SELF));
            }
        }
    } else
    {
        SpeakString("Another door already in use. Please wait a moment.");
    }
}

