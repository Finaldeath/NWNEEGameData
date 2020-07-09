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

    // number of plot items
    int nPlotItem;

    string s2DA = "plotitems";

    // is this a valid item
    string sResRef = "default";
    while ((sResRef != "") && (nCount <= ID1_STEP_SIZE))
    {
        // get the resref of the current object
        sResRef = Get2DAString(s2DA, "ITEM_RESREF", nStart + nCount);

        // is this a valid item
        if (sResRef != "")
        {
            DebugMessage("  Plot item 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);

            // add container to list
            nPlotItem = GetLocalInt(GetModule(), "nPlotItem");
            nPlotItem++;
            SetLocalInt(GetModule(), "nPlotItem", nPlotItem);

            // set the resref string
            SetLocalString(GetModule(), "sPlotItem" + IntToString(nPlotItem) + "ResRef", sResRef);

            string sName = Get2DAString(s2DA, "ITEM_NAME", nStart + nCount);
            SetLocalString(GetModule(), "sPlotItem" + IntToString(nPlotItem) + "Name", sName);
            DebugMessage("  Plot item name is " + sName + " with resref " + sResRef + " at sPlotItem" + IntToString(nPlotItem));
        }

        nCount++;
    }

    // if a null string was returned
    if (sResRef == "")
    {
        DebugMessage("  Plot item 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);

        // reset starting point
        nStart = nStart + nCount;

        // look ahead to see if any more exist
        nCount = 0;
        while ((sResRef == "") && (nCount < ID1_LOOK_AHEAD))
        {
            // increment counter
            nCount++;

            // grab resref
            sResRef = Get2DAString(s2DA, "ITEM_RESREF", nStart + nCount);
            DebugMessage("  Plot item 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);
        }

        // if another entry was found
        if (sResRef != "")
        {
            DebugMessage("  Item found at entry " + IntToString(nStart + nCount));

            // set new start point
            SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

            // examine entries at new start point
            DelayCommand(0.01, ExecuteScript("exe_id1_catpltit", GetNextCPU()));
        } else // if no entry was found
        {
            DebugMessage("  No more plot items found.");

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
        DelayCommand(0.01, ExecuteScript("exe_id1_catpltit", GetNextCPU()));
    }
}
