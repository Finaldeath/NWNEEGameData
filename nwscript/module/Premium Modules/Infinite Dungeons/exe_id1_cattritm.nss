#include "inc_id1_debug"

// object GetNextCPU()
#include "inc_id1_utility"
#include "inc_id1_items"
#include "x2_inc_itemprop"

const int ID1_STEP_SIZE = 100;
const int ID1_LOOK_AHEAD = 50;

void main()
{
    // starting position
    int nStart = GetLocalInt(GetModule(), "nQueueMin");
    int nCount = 0;

    string s2DA = "specific_items";

    object oMicroCPU;

    // if there is a valid item
    string sResRef = "default";
    while ((sResRef != "") && (nCount < ID1_STEP_SIZE))
    {
        sResRef = Get2DAString(s2DA, "ITEM_RESREF", nStart + nCount);

        if (sResRef != "")
        {
//            DebugMessage("  Specific item 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);

            oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU63");
            SetLocalString(oMicroCPU, "sResRef", sResRef);
            DelayCommand(0.01, ExecuteScript("exe_id1_cattrit2", oMicroCPU));

            nCount++;
        }
    }

    // if a null string was returned
    if (sResRef == "")
    {
//        DebugMessage("  Specific item 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);

        // reset starting point
        nStart = nStart + nCount;

        // look ahead to see if any more exist
        nCount = 0;
        while ((sResRef == "") && (nCount < ID1_LOOK_AHEAD))
        {
            // increment counter
            nCount++;

            sResRef = Get2DAString(s2DA, "ITEM_RESREF", nStart + nCount);
//            DebugMessage("    Specific item 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);
        }

        // if another entry was found
        if (sResRef != "")
        {
//            DebugMessage("    Item found at entry " + IntToString(nStart + nCount));

            // set new start point
            SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

            // examine entries at new start point
            DelayCommand(0.01, ExecuteScript("exe_id1_cattritm", GetNextCPU()));
        } else // if no entry was found
        {
//            DebugMessage("    No more specific items found.");

            SetLocalInt(GetModule(), "nQueueMin", 0);

            // return to the catalog
            DelayCommand(0.01, ExecuteScript("exe_id1_cathold", GetNextCPU()));
        }
    } else // if all examined entries were used
    {
//        DebugMessage("    Examining next set of entries.");

        // set new starting point
        SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

        // examine entries at new start point
        DelayCommand(0.01, ExecuteScript("exe_id1_cattritm", GetNextCPU()));
    }
}

