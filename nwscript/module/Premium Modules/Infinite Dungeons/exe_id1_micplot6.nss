#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_score"

void main()
{
    DebugMessage("");
    object oDungeon = GetCurrentDungeon();
    int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
    int nLevel = GetLocalInt(OBJECT_SELF, "nLevel");
    DebugMessage("Revealing plot areas for plot " + IntToString(nPlot) + " on level is " + IntToString(nLevel));

    string sPlot = "Plot" + IntToString(nPlot);
    int nPlotLevel = GetLocalInt(oDungeon, "n" + sPlot + "Level_" + IntToString(nLevel));
    string sPlotLevel = sPlot + "Level" + IntToString(nPlotLevel);
    int nPlotAreaNum = GetLocalInt(oDungeon, "n" + sPlotLevel + "AreaNum");
    DebugMessage("  n" + sPlotLevel + "AreaNum is " + IntToString(nPlotAreaNum));

    int nPlotArea = 1;
    object oMicroCPU;
    int nArea;
    while (nPlotArea <= nPlotAreaNum)
    {
        nArea = GetLocalInt(oDungeon, "n" + sPlotLevel + "Area" + IntToString(nPlotArea));
        DebugMessage("  Plot area " + IntToString(nPlotArea) + " is actual area " + IntToString(nArea));

        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU98");
        SetLocalString(oMicroCPU, "sPlot", sPlot);
        SetLocalInt(oMicroCPU, "nArea", nArea);
        SetLocalInt(oMicroCPU, "nLevel", nLevel);
        DelayCommand(0.01, ExecuteScript("exe_id1_micplot7", oMicroCPU));

        nPlotArea++;
    }

    DelayCommand(0.02, DestroyObject(OBJECT_SELF));
}
