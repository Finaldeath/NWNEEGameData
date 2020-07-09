#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_score"

void main()
{
    object oDungeon = GetCurrentDungeon();
    int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
    int nArea = GetLocalInt(OBJECT_SELF, "nArea");
    int nLevel = GetLocalInt(OBJECT_SELF, "nLevel");
    DebugMessage("Plot is " + IntToString(nPlot) + ", area is " + IntToString(nArea) + ", level is " + IntToString(nLevel));

    string sPlot = "Plot" + IntToString(nPlot);
    int nPlotLevel = GetLocalInt(oDungeon, "n" + sPlot + "Level_" + IntToString(nLevel));
    string sPlotLevel = sPlot + "Level" + IntToString(nPlotLevel);
    int nPlotArea = GetLocalInt(oDungeon, "n" + sPlotLevel + "Area_" + IntToString(nArea));
    string sPlotArea = sPlotLevel + "Area" + IntToString(nPlotArea);
    DebugMessage("  sPlotArea is " + sPlotArea);

    if (GetLocalInt(oDungeon, "b" + sPlotArea + "Explored") == FALSE)
    {
        DebugMessage("Area explored.");

        // mark area as completed
        SetLocalInt(oDungeon, "b" + sPlotArea + "Explored", TRUE);

        // create microprocess to inform all quest recipients
        object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU96");
        SetLocalInt(oMicroCPU, "nPlot", nPlot);
        SetLocalString(oMicroCPU, "sMessage", "Plot area explored.");

        DelayCommand(0.01, ExecuteScript("exe_id1_micplot", oMicroCPU));

        // check to see if plot is completed
        int nXLevelNum = GetLocalInt(oDungeon, "n" + sPlot + "LevelNum");
        int nXAreaNum;
        int nXLevel = 1;
        int nXArea;
        string sXLevel;
        int bCompleted = TRUE;
        while ((nXLevel <= nXLevelNum) && (bCompleted == TRUE))
        {
            sXLevel = sPlot + "Level" + IntToString(nXLevel);

            // each area
            nXAreaNum = GetLocalInt(oDungeon, "n" + sXLevel + "AreaNum");
            nXArea = 1;
            while ((nXArea <= nXAreaNum) && (bCompleted == TRUE))
            {
                if (GetLocalInt(oDungeon, "b" + sXLevel + "Area" + IntToString(nXArea) + "Explored") == FALSE)
                {
                    bCompleted = FALSE;
                }

                nXArea++;
            }

            if (bCompleted == TRUE)
            {
                nXLevel++;
            }
        }

        if (nXLevel > nXLevelNum)
        {
            SetLocalInt(oDungeon, "b" + sPlot + "Completed", TRUE);

            // April 4, 2006 - GM: Award points for plot completion.
            AwardPlotCompletedPoints();

            // create microprocess to inform all quest recipients
            object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU97");
            SetLocalInt(oMicroCPU, "nPlot", nPlot);
            SetLocalString(oMicroCPU, "sMessage", "All plot areas explored.");

            DelayCommand(0.01, ExecuteScript("exe_id1_micplot", oMicroCPU));
        }
    } else
    {
        DebugMessage("Area already explored.");
    }

    DelayCommand(0.01, DestroyObject(OBJECT_SELF));
}
