#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_utility"

void main()
{
    object oPC = GetLocalObject(GetModule(), "oTempPC");
    object oDestinationDoor = GetLocalObject(GetModule(), "oTempDestinationDoor");
    object oDungeon = GetLocalObject(GetModule(), "oTempDungeon");
    object oArea = GetArea(oDestinationDoor);
    int nAreaIdentifier = GetLocalInt(oArea, "nAreaIdentifier");
    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");

    // get current level
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");


    // get number of waypoints
    int nWaypointNum = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "WaypointSecretDoor");

    string sWaypoint;
    object oWaypoint;
    location lWaypoint;
    int bDetected;
    string sTileset = GetTilesetResRef(oArea);
    int nTileset = GetLocalInt(GetModule(), "nTileset_" + sTileset);
    string sDoor;
    float fFacing;
    object oDoor;
    int nDoor;

    // get the tileset
    DebugMessage("Tileset " + sTileset + " with number " + IntToString(nTileset));

    // go through each waypoint
    int nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        sWaypoint = "Area" + IntToString(nAreaNum) + "WaypointSecretDoor" + IntToString(nWaypoint) + "Level" + IntToString(nCurrentLevel);
        oWaypoint = GetLocalObject(oArea, "oWaypointSecretDoor" + IntToString(nWaypoint));

        // if detected
        bDetected = GetLocalInt(oDungeon, "b" + sWaypoint + "Detected");
        if (bDetected == TRUE)
        {
            // spawn object
            nDoor = GetLocalInt(oDungeon, "n" + sWaypoint + "Door");
            sDoor = GetLocalString(oDungeon, "sListSecretDoor" + IntToString(nDoor) + "ResRef");
            DebugMessage("sListSecretDoor" + IntToString(nWaypoint) + "ResRef is " + sDoor);

            // create door at that waypoint
            lWaypoint = GetLocation(oWaypoint);
            fFacing = GetFacing(oWaypoint);
            fFacing += 180.0;
            oDoor = CreateObject(OBJECT_TYPE_PLACEABLE, sDoor, lWaypoint, FALSE, "SecretDoor");
            AssignCommand(oDoor, SetFacing(fFacing));

            // make sure it cant be destroyed
            SetPlotFlag(oDoor, TRUE);

            // find nearest exit
            oWaypoint = GetNearestObjectByTag("ID1_STATIC_WP_SECRET_DOOR_EXIT", oDoor);

            // check to see if valid and not active
            lWaypoint = GetLocation(oWaypoint);
            fFacing = GetFacing(oWaypoint);
            fFacing += 180.0;
            oDoor = CreateObject(OBJECT_TYPE_PLACEABLE, sDoor, lWaypoint, FALSE, "SecretDoorExit");
            AssignCommand(oDoor, SetFacing(fFacing));

            // make sure it cant be destroyed
            SetPlotFlag(oDoor, TRUE);
        }

        nWaypoint++;
    }

    DebugMessage("Returning to exe_id1_activate.");
    DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));
}

