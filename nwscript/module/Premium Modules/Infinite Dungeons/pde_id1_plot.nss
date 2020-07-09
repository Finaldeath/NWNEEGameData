#include "inc_id1_utility"

void main()
{
    // get self
    int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
    DebugMessage("Plot for item " + GetTag(OBJECT_SELF) + " is " + IntToString(nPlot));
    object oDungeon = GetCurrentDungeon();

    // if not completed already
    if (GetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Completed") == FALSE)
    {
        SetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Failed", TRUE);

        // if the plot is active
        if (GetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Activated") == TRUE)
        {
            // create microprocess to inform all quest recipients
            object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU117");
            SetLocalInt(oMicroCPU, "nPlot", nPlot);
            SetLocalString(oMicroCPU, "sMessage", "Plot failed.");

            DelayCommand(0.01, ExecuteScript("exe_id1_micplot", oMicroCPU));
        } else
        {
            SetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Activated", TRUE);
        }
    }
}
