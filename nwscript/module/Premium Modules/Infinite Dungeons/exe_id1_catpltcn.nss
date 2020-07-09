#include "inc_id1_debug"
// object GetNextCPU()
#include "inc_id1_utility"

const int ID1_STEP_SIZE = 100;
const int ID1_LOOK_AHEAD = 50;

void main()
{
    // starting position
    int nStart = GetLocalInt(GetModule(), "nQueueMin");
    int nCount = 0;

    // number of plot containers
    int nPlotContainer;

    int nTilesetNum = GetLocalInt(GetModule(), "nTileset");
    int nTileset;
    string sTilesetName;
    int bUsed;
    int nPlotContainerNum;

    string s2DA = "plotplaceable";

    // is this a valid object
    string sResRef = "default";
    while ((sResRef != "") && (nCount <= ID1_STEP_SIZE))
    {
        sResRef = Get2DAString(s2DA, "PLACEABLE_RESREF", nStart + nCount);

        // is this a valid item
        if (sResRef != "")
        {
            DebugMessage("  Plot placeable 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);

            // add container to list
            nPlotContainer = GetLocalInt(GetModule(), "nPlotContainer");
            nPlotContainer++;
            SetLocalInt(GetModule(), "nPlotContainer", nPlotContainer);
            SetLocalInt(GetModule(), "nPlotContainer" + IntToString(nPlotContainer) + "Line", nStart + nCount);
            SetLocalString(GetModule(), "sPlotContainer" + IntToString(nPlotContainer) + "ResRef", sResRef);

            string sName = Get2DAString(s2DA, "PLACEABLE_NAME", nStart + nCount);
            SetLocalString(GetModule(), "sPlotContainer" + IntToString(nPlotContainer) + "Name", sName);
            DebugMessage("  Plot placeable name is " + sName + " with resref " + sResRef + " at sPlotContainer" + IntToString(nPlotContainer));
        }

        nCount++;
    }

    // if a null string was returned
    if (sResRef == "")
    {
        DebugMessage("  Plot container 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);

        // reset starting point
        nStart = nStart + nCount;

        // look ahead to see if any more exist
        nCount = 0;
        while ((sResRef == "") && (nCount < ID1_LOOK_AHEAD))
        {
            // increment counter
            nCount++;

            // grab resref
            sResRef = Get2DAString(s2DA, "CONTAINER_RESREF", nStart + nCount);
            DebugMessage("  Plot container 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);
        }

        // if another entry was found
        if (sResRef != "")
        {
            DebugMessage("  Item found at entry " + IntToString(nStart + nCount));

            // set new start point
            SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

            // examine entries at new start point
            DelayCommand(0.01, ExecuteScript("exe_id1_catpltcn", GetNextCPU()));
        } else // if no entry was found
        {
            DebugMessage("  No more plot containers found.");

            SetLocalInt(GetModule(), "nQueueMin", 0);

            // return to the catalog
            DelayCommand(0.01, ExecuteScript("exe_id1_cathold", GetNextCPU()));
        }
    } else // if all examined entries were used
    {
        DebugMessage("  Examining next set of entries.");

        // set new starting point
        SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

        // examine entries at new start point
        DelayCommand(0.01, ExecuteScript("exe_id1_catpltcn", GetNextCPU()));
    }
}
