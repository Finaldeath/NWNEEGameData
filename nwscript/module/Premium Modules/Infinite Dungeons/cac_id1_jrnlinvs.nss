#include "inc_id1_utility"
#include "inc_id1_score"

void main()
{
    // only do this once
    if (GetLocalInt(OBJECT_SELF, "bSetup") == FALSE)
    {
        SetLocalInt(OBJECT_SELF, "bSetup", TRUE);

        // catalogue all plots
        object oDungeon = GetCurrentDungeon();

        object oPC = GetPCSpeaker();
        string sPC = GetPCIdentifier(oPC);
        DebugMessage("Player is " + sPC);

        string sPlot;
        int nTotal = 0;
        int nFailed = 0;
        int nCompleted = 0;
        int nActivated = 0;

        int nPlot = 1;
        int nPlotNum = GetLocalInt(oDungeon, "nPlotNum");
        DebugMessage("There are " + IntToString(nPlotNum) + " plots.");
        while (nPlot <= nPlotNum)
        {
            DebugMessage("  Checking journal for plot " + IntToString(nPlot) + " of " + IntToString(nPlotNum));

            sPlot = "Plot" + IntToString(nPlot);
            DebugMessage("  Checking for b" + sPlot + "Player_" + sPC);
            if (GetLocalInt(oDungeon, "b" + sPlot + "Player_" + sPC) == TRUE)
            {
                DebugMessage("    Player is active in this plot.");

                // add to appropriate list (failed > completed > activated)
                if (GetLocalInt(oDungeon, "b" + sPlot + "Failed") == TRUE)
                {
                    DebugMessage("    Plot is failed.");
                    nFailed++;
                    SetLocalInt(OBJECT_SELF, "nPlotFailed" + IntToString(nFailed), nPlot);
                    DebugMessage("    Setting nPlotFailed" + IntToString(nFailed));

                    nTotal++;
                    SetLocalInt(OBJECT_SELF, "nPlotTotal" + IntToString(nTotal), nPlot);
                    SetLocalInt(OBJECT_SELF, "nPlotTotalType" + IntToString(nTotal), 4);
                    DebugMessage("    Setting nPlotTotal" + IntToString(nTotal));
                } else if (GetLocalInt(oDungeon, "b" + sPlot + "Completed") == TRUE)
                {
                    DebugMessage("    Plot is completed.");
                    nCompleted++;
                    SetLocalInt(OBJECT_SELF, "nPlotCompleted" + IntToString(nCompleted), nPlot);
                    DebugMessage("    Setting nPlotCompleted" + IntToString(nCompleted));

                    nTotal++;
                    SetLocalInt(OBJECT_SELF, "nPlotTotal" + IntToString(nTotal), nPlot);
                    SetLocalInt(OBJECT_SELF, "nPlotTotalType" + IntToString(nTotal), 3);
                    DebugMessage("    Setting nPlotTotal" + IntToString(nTotal));
                } else if (GetLocalInt(oDungeon, "b" + sPlot + "Activated") == TRUE)
                {
                    DebugMessage("    Plot is activated.");
                    nActivated++;
                    SetLocalInt(OBJECT_SELF, "nPlotActivated" + IntToString(nActivated), nPlot);
                    DebugMessage("    Setting nPlotActivated" + IntToString(nActivated));

                    nTotal++;
                    SetLocalInt(OBJECT_SELF, "nPlotTotal" + IntToString(nTotal), nPlot);
                    SetLocalInt(OBJECT_SELF, "nPlotTotalType" + IntToString(nTotal), 2);
                    DebugMessage("    Setting nPlotTotal" + IntToString(nTotal));
                }
            } else
            {
                DebugMessage("    Player is not active in this plot.");
            }

            // check the next plot
            nPlot++;
        }

        SetLocalInt(OBJECT_SELF, "nPlotTotal", nTotal);
        SetLocalInt(OBJECT_SELF, "nPlotActivated", nActivated);
        SetLocalInt(OBJECT_SELF, "nPlotCompleted", nCompleted);
        SetLocalInt(OBJECT_SELF, "nPlotFailed", nFailed);
    }
}
