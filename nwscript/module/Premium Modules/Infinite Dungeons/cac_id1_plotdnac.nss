#include "inc_id1_score"
#include "inc_id1_utility"

void main()
{
    object oDungeon = GetCurrentDungeon();
    int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
    DebugMessage("nPlot is " + IntToString(nPlot));

    string sPlot = "Plot" + IntToString(nPlot);

    // find start level
    int nLevel = GetLocalInt(oDungeon, "n" + sPlot + "StartLevel");

    // find start area
    int nArea = GetLocalInt(oDungeon, "n" + sPlot + "StartArea");

    // find start waypoint
    int nWaypoint = GetLocalInt(oDungeon, "n" + sPlot + "StartWaypoint");

    string sLevel = "Area" + IntToString(nArea) + "WaypointPlot" + IntToString(nWaypoint) + "Level" + IntToString(nLevel);
    DebugMessage("sLevel is " + sLevel);

    // find proper quest
    int nPlotNum = GetLocalInt(oDungeon, "n" + sLevel + "Plot_" + IntToString(nPlot));
    string sPlotNum = sLevel + "Plot" + IntToString(nPlotNum);
    DebugMessage("sPlotNum is " + sPlotNum);

    // get name
    string sName = GetLocalString(oDungeon, "s" + sPlotNum + "ObjectName");

    // get creature type
    int nCreature = GetLocalInt(oDungeon, "n" + sPlotNum + "Object");
    string sCreatureName = GetLocalString(GetModule(), "sCreature" + IntToString(nCreature) + "NameSingular");

    string sToken = "Someone is looking for me on level " + IntToString(nLevel) + ".";

    SetCustomToken(5001, sToken);
}
