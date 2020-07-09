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

    // cycle through all decor point
    int nOpenDecorMax = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "WaypointDecorOpen");
    int nWallDecorMax = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "WaypointDecorWall");
    int nCount;
    string sLevel;
    object oWaypoint;
    int nDecor;
    object oDecor;
    float fFacing;

    int bUsed;
    string sResRef;

    // spawn open decor
    nCount = 1;
    while (nCount <= nOpenDecorMax)
    {
        DebugMessage("    On open decor point " + IntToString(nCount) + " of " + IntToString(nOpenDecorMax));
        sLevel = "Area" + IntToString(nAreaNum) + "WaypointDecorOpen" + IntToString(nCount) + "Level" + IntToString(nCurrentLevel);

        // if used
        bUsed = GetLocalInt(oDungeon, "b" + sLevel + "Used");
        if (bUsed == TRUE)
        {
            DebugMessage("      Decor detected.");

            // get waypoint location
            oWaypoint = GetLocalObject(oArea, "oWaypointDecorOpen" + IntToString(nCount));

            // get decor resref
            nDecor = GetLocalInt(oDungeon, "n" + sLevel + "Object");
            sResRef = GetLocalString(oDungeon, "sListDecorOpen" + IntToString(nDecor) + "ResRef");
            DebugMessage("      Spawning decor object " + IntToString(nDecor) + " with resref " + sResRef);

            // spawn decor
            oDecor = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, GetLocation(oWaypoint));

            // get facing
            fFacing = GetFacing(oWaypoint);
            fFacing += 180.0;

            // rotate properly
            AssignCommand(oDecor, SetFacing(fFacing));
            SetPlotFlag(oDecor, TRUE);
        }

        nCount++;
    }

    // spawn wall decor
    nCount = 1;
    while (nCount <= nWallDecorMax)
    {
        DebugMessage("    On wall decor point " + IntToString(nCount) + " of " + IntToString(nWallDecorMax));
        sLevel = "Area" + IntToString(nAreaNum) + "WaypointDecorWall" + IntToString(nCount) + "Level" + IntToString(nCurrentLevel);

        // if used
        bUsed = GetLocalInt(oDungeon, "b" + sLevel + "Used");
        if (bUsed == TRUE)
        {
            DebugMessage("      Decor detected.");

            // get waypoint location
            oWaypoint = GetLocalObject(oArea, "oWaypointDecorWall" + IntToString(nCount));

            // get decor resref
            nDecor = GetLocalInt(oDungeon, "n" + sLevel + "Object");
            sResRef = GetLocalString(oDungeon, "sListDecorWall" + IntToString(nDecor) + "ResRef");
            DebugMessage("      Spawning decor object " + IntToString(nDecor) + " with resref " + sResRef);

            // spawn decor
            oDecor = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, GetLocation(oWaypoint));

            // get facing
            fFacing = GetFacing(oWaypoint);
            fFacing += 180.0;

            // rotate properly
            AssignCommand(oDecor, SetFacing(fFacing));
            SetPlotFlag(oDecor, TRUE);
        }

        nCount++;
    }

    DebugMessage("Returning to exe_id1_activate.");
    DelayCommand(0.01, ExecuteScript("exe_id1_activate", GetNextCPU()));
}

