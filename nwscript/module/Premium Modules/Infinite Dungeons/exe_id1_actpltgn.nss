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

    string sWaypoint = "Area" + IntToString(nAreaNum) + "WaypointPlot";
    string sLevel;

    int nPartyLevel = GetPartyLevel(oPC, FALSE);

    int nGiverType;
    string sPlot;
    int nPlotNum;
    int nPlot;
    int nSpawnType;
    object oMicroCPU;
    int nMicroNum;
    string sName;

    int nPlotID;
    int nCreature;

    int nDialog;

    // go through each plot waypoint
    int nWaypointNum = GetLocalInt(oDungeon, "n" + sWaypoint);
    DebugMessage("Number of waypoints to examine: " + IntToString(nWaypointNum));
    int nWaypoint = 1;
    while (nWaypoint <= nWaypointNum)
    {
        DebugMessage("Generating plot waypoint " + IntToString(nWaypoint));

        // get number of plots
        sLevel = sWaypoint + IntToString(nWaypoint) + "Level" + IntToString(nCurrentLevel);
        nPlotNum = GetLocalInt(oDungeon, "n" + sLevel + "PlotNum");
        DebugMessage("  There are " + IntToString(nPlotNum) + " plots at " + sLevel);
        nPlot = 1;
        while (nPlot <= nPlotNum)
        {
            DebugMessage("  Generating plot " + IntToString(nPlot));

            sPlot = sLevel + "Plot" + IntToString(nPlot);

            DebugMessage("    sPlot is " + sPlot);

            // get spawn type
            nSpawnType = GetLocalInt(oDungeon, "n" + sPlot + "SpawnType");

            DebugMessage("    Spawn type " + IntToString(nSpawnType));

            // spawn plot givers and destinations
            if (nSpawnType == 1) // plot giver
            {
                DebugMessage("    Generating plot giver.");

                // set plot givers name
                // EDIT: create real random name generator
                sName = RandomName();
                SetLocalString(oDungeon, "s" + sPlot + "ObjectName", sName);
                DebugMessage("    Plot giver name set to " + sName);

                // microprocess creature object
                oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU43");
                SetLocalString(oMicroCPU, "sCreature", sPlot + "Object");
                SetLocalInt(oMicroCPU, "nCR", nPartyLevel);
                SetLocalInt(oMicroCPU, "bIntelligentOnly", TRUE);
                SetLocalInt(oMicroCPU, "bUnIntelligentOnly", FALSE);
                SetLocalInt(oMicroCPU, "bMediumSizeOnly", TRUE);
                SetLocalInt(oMicroCPU, "bMiniBoss", FALSE);
                SetLocalInt(oMicroCPU, "nTileset", -1);
                SetLocalInt(oMicroCPU, "nTheme", 1);
                SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                SetLocalInt(oMicroCPU, "bHold", TRUE);
                SetLocalInt(oMicroCPU, "bNoTreasure", TRUE);

                // increment number of active microprocessors
                nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                nMicroNum++;
                SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

                DelayCommand(0.01, ExecuteScript("exe_id1_micmon", oMicroCPU));
            } else if (nSpawnType == 2) // destination creature
            {
                DebugMessage("    Generating destination creature.");

                nPlotID = GetLocalInt(oDungeon, "n" + sPlot);
                nCreature = GetLocalInt(oDungeon, "nPlot" + IntToString(nPlotID) + "Creature");
                SetLocalInt(oDungeon, "n" + sPlot + "Object", nCreature);

                // set plot destination name
                sName = RandomName();
                SetLocalString(oDungeon, "s" + sPlot + "ObjectName", sName);
                DebugMessage("    Plot destination name set to " + sName);

                // set plot destination CR
                SetLocalInt(oDungeon, "n" + sPlot + "ObjectCR", nPartyLevel);
                DebugMessage("    Plot destination CR set to " + IntToString(nPartyLevel));
            } else if (nSpawnType == 3) // destination placeable
            {
                DebugMessage("    Generating destination placeable. Nothing to do");
            } else
            {
                DebugMessage("    Illegal spawn generation type.");
            }

            nPlot++;
        }

        nWaypoint++;
    }

    // enter holding pattern
    DebugMessage("Entering holding pattern.");
    DelayCommand(0.01, ExecuteScript("exe_id1_acthold", GetNextCPU()));
}

