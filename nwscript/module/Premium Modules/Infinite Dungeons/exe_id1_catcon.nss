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

    // number of container objects
    int nContainer;

    string s2DA = "container";

    string sTilesets;

    // cycle through the first set of entries in the list
    string sResRef = "default";
    while ((sResRef != "") && (nCount < ID1_STEP_SIZE))
    {
        // get the resref of the current object
        sResRef = Get2DAString(s2DA, "OBJECT_RESREF", nStart + nCount);

        // is this a valid item
        if (sResRef != "")
        {
            DebugMessage("    Container 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);

            // add container to list
            nContainer = GetLocalInt(GetModule(), "nContainer");
            nContainer++;
            SetLocalInt(GetModule(), "nContainer", nContainer);

            // set the resref string
            SetLocalString(GetModule(), "sContainer" + IntToString(nContainer) + "ResRef", sResRef);

            sTilesets = Get2DAString(s2DA, "TILESETS", nStart + nCount);
            SetLocalString(GetModule(), "sContainer" + IntToString(nContainer) + "Tilesets", sTilesets);

            // increment counter
            nCount++;
        }
    }

    // if a null string was returned
    if (sResRef == "")
    {
        DebugMessage("    Container 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);

        // reset starting point
        nStart = nStart + nCount;

        // check the next set of entries to see if any more exist
        nCount = 0;
        while ((sResRef == "") && (nCount < ID1_LOOK_AHEAD))
        {
            // increment counter
            nCount++;

            // grab resref
            sResRef = Get2DAString(s2DA, "OBJECT_RESREF", nStart + nCount);
            DebugMessage("    Container 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);
        }

        // if another entry was found
        if (sResRef != "")
        {
            DebugMessage("    Object found at entry " + IntToString(nStart + nCount));

            // set new start point
            SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

            // examine entries at new start point
            DelayCommand(0.01, ExecuteScript("exe_id1_catcon", GetNextCPU()));
        } else // if no entry was found
        {
            DebugMessage("    No more containers found.");

            SetLocalInt(GetModule(), "nQueueMin", 0);

            // return to the catalog
            DelayCommand(0.01, ExecuteScript("exe_id1_catalog", GetNextCPU()));
        }
    } else // if all examined entries were used
    {
        DebugMessage("    Examining next set of entries.");

        // set new starting point
        SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

        // examine entries at new start point
        DelayCommand(0.01, ExecuteScript("exe_id1_catcon", GetNextCPU()));
    }
}
