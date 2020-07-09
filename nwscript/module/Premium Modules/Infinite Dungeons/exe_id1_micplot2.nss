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

    if (GetLocalInt(oDungeon, "b" + sPlotArea + "Cleared") == FALSE)
    {
        int bFailed = FALSE;
        int nObjectType;
        int bClean;

        string sTag;

        object oSelf = GetLocalObject(OBJECT_SELF, "oSelf");

        object oArea = GetLocalObject(OBJECT_SELF, "oArea");
        object oObject = GetFirstObjectInArea(oArea);
        while ((oObject != OBJECT_INVALID) && (bFailed == FALSE))
        {
            nObjectType = GetObjectType(oObject);
            if (nObjectType == OBJECT_TYPE_CREATURE)
            {
                sTag = GetTag(oObject);
                DebugMessage("Found creature with tag " + sTag);

                if (oObject != oSelf)
                {
                    DebugMessage("This creature is not me.");

                    // determine if this is a normal clean operation
                    bClean = GetLocalInt(oObject, "bClean");
                    if (bClean == FALSE)
                    {
                        DebugMessage("Creature is not being cleaned.");

                        // determine if creature is hostile
                        if (GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oObject) > 50)
                        {
                            DebugMessage("  Creature is hostile.");

                            if (GetIsDead(oObject) == FALSE)
                            {
                                DebugMessage("  Creature is not dead.");

                                bFailed = TRUE;
                            }
                        }
                    } else
                    {
                        DebugMessage("Creature is being cleaned.");
                    }
                } else
                {
                    DebugMessage("This is me, so I'll ignore it.");
                }
            }

            // check next object
            oObject = GetNextObjectInArea(oArea);
        }

        // if all creatures are dead
        if (bFailed == FALSE)
        {
            DebugMessage("All hostile creatures are dead.");

            // mark area as completed
            SetLocalInt(oDungeon, "b" + sPlotArea + "Cleared", TRUE);

            // create microprocess to inform all quest recipients
            object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU93");
            SetLocalInt(oMicroCPU, "nPlot", nPlot);
            SetLocalString(oMicroCPU, "sMessage", "Plot area cleared.");

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
                    if (GetLocalInt(oDungeon, "b" + sXLevel + "Area" + IntToString(nXArea) + "Cleared") == FALSE)
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
                object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU94");
                SetLocalInt(oMicroCPU, "nPlot", nPlot);
                SetLocalString(oMicroCPU, "sMessage", "All plot areas cleared.");

                DelayCommand(0.01, ExecuteScript("exe_id1_micplot", oMicroCPU));
            }
        } else
        {
            DebugMessage("Not all creatures are dead.");
        }
    } else
    {
        DebugMessage("Area already cleared.");
    }

    DelayCommand(0.01, DestroyObject(OBJECT_SELF));
}
