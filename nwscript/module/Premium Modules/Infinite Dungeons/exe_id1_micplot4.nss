#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_score"

void main()
{
    int nArea = GetLocalInt(OBJECT_SELF, "nAreaNum");
    object oArea = GetLocalObject(OBJECT_SELF, "oArea");
    int nCurrentLevel = GetCurrentLevel();
    object oDungeon = GetCurrentDungeon();
    int nPlotNum = GetLocalInt(oDungeon, "nPlotNum");
    int nPlot = 1;
    int nGameplayType;
    int bActivated;
    int bCompleted;
    int bFailed;
    string sPlot;
    int nPlotArea;
    object oMicroCPU;
    while (nPlot <= nPlotNum)
    {
        sPlot = "Plot" + IntToString(nPlot);
        DebugMessage("Plot is " + sPlot);
        bActivated = GetLocalInt(oDungeon, "b" + sPlot + "Activated");
        if (bActivated == TRUE)
        {
            DebugMessage("Plot is activated.");
            bCompleted = GetLocalInt(oDungeon, "b" + sPlot + "Completed");
            if (bCompleted == FALSE)
            {
                DebugMessage("Plot is not completed.");
                bFailed = GetLocalInt(oDungeon, "b" + sPlot + "Failed");
                if (bFailed == FALSE)
                {
                    DebugMessage("Plot is not failed.");

                    // check to see if this area is involved in the quest
                    nPlotArea = GetLocalInt(oDungeon, "n" + sPlot + "Level" + IntToString(nCurrentLevel) + "Area_" + IntToString(nArea));
                    DebugMessage("        Checking n" + sPlot + "Level" + IntToString(nCurrentLevel) + "Area_" + IntToString(nArea));
                    if (nPlotArea > 0)
                    {
                        DebugMessage("       Area is involved in this plot.");

                        nGameplayType = GetLocalInt(oDungeon, "n" + sPlot + "GameplayType");
                        DebugMessage("GameplayType is " + IntToString(nGameplayType));

                        if ((nGameplayType == 2) || (nGameplayType == 5))
                        {
                            // check to see if area is acceptable
                            oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU95");
                            SetLocalInt(oMicroCPU, "nPlot", nPlot);
                            SetLocalInt(oMicroCPU, "nArea", nArea);
                            SetLocalObject(oMicroCPU, "oArea", oArea);
                            SetLocalInt(oMicroCPU, "nLevel", nCurrentLevel);
                            SetLocalObject(oMicroCPU, "oSelf", OBJECT_SELF);
                            if (nGameplayType == 2)
                            {
                                // create microprocess for cleaning an area
                                DelayCommand(0.01, ExecuteScript("exe_id1_micplot2", oMicroCPU));
                            } else if (nGameplayType == 5)
                            {
                                // create microprocess for exploring an area
                                DelayCommand(0.01, ExecuteScript("exe_id1_micplot5", oMicroCPU));
                            }
                        }
                    } else
                    {
                        DebugMessage("       Area is not involved in this plot.");
                    }
                } else
                {
                    DebugMessage("Plot is failed.");
                }
            } else
            {
                DebugMessage("Plot is completed.");
            }
        } else
        {
            DebugMessage("Plot is not activated.");
        }

        // examine the next plot
        nPlot++;
    }

    DelayCommand(0.01, DestroyObject(OBJECT_SELF));
}
