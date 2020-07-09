#include "inc_id1_debug"
// object GetNextCPU()
#include "inc_id1_utility"

const int ID1_STEP_SIZE = 100;
const int ID1_LOOK_AHEAD = 50;

void main()
{
    // get the current area being examined
    int nStart = GetLocalInt(GetModule(), "nQueueMin");
    int nCount = 0;

    string s2DA = "themesets";

    // if this is the first time starting, set up the THEME_SET_ALL
    if (nStart == 0)
    {
        SetLocalInt(GetModule(), "nThemeSet", 1);
        SetLocalString(GetModule(), "sThemeSet1Name", "THEME_SET_ALL");
        SetLocalInt(GetModule(), "nThemeSet_THEME_SET_ALL", 1);
        SetLocalInt(GetModule(), "nThemeSet1Primary", 1);
        SetLocalInt(GetModule(), "nThemeSet1Primary1", 1);
    }

    object oMicroCPU;
    int nThemeSet;
    int nMicroNum;

    // get the number of tilesets available
    string sThemeSet = "default";
    while ((sThemeSet != "") && (nCount < ID1_STEP_SIZE))
    {
        sThemeSet = Get2DAString(s2DA, "SET_NAME", nStart + nCount);

        if (sThemeSet != "")
        {
            DebugMessage("  Themeset 2DA entry " + IntToString(nStart + nCount) + " is " + sThemeSet);

            // create a subprocess to search for linkings for this tileset
            oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU60");
            SetLocalInt(oMicroCPU, "nLine", nStart + nCount);

            nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
            nMicroNum++;
            SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

            DelayCommand(0.01, ExecuteScript("exe_id1_catsets2", oMicroCPU));

            nCount++;
        }
    }

    if (sThemeSet == "")
    {
        DebugMessage("  Themeset 2DA entry " + IntToString(nStart + nCount) + " is " + sThemeSet);

        nStart = nStart + nCount;

        // check the next set of areas for anything
        nCount = 0;
        while ((nCount < ID1_LOOK_AHEAD) && (sThemeSet == ""))
        {
            nCount++;

            // get the next tileset to check
            sThemeSet = Get2DAString(s2DA, "SET_NAME", nStart + nCount);
            DebugMessage("  Themeset 2DA entry " + IntToString(nStart + nCount) + " is " + sThemeSet);
        }

        if (sThemeSet == "")
        {
            DebugMessage(" No more themesets found.");

            SetLocalInt(GetModule(), "nQueueMin", 0);

            // return to catalog generation
            DelayCommand(0.01, ExecuteScript("exe_id1_cathold", GetNextCPU()));
        } else
        {
            DebugMessage("  New entry found at " + IntToString(nStart + nCount));

            // set new area to examine
            SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

            // examine next area
            DelayCommand(0.01, ExecuteScript("exe_id1_catsets", GetNextCPU()));
        }
    } else
    {
        DebugMessage("  Checking next set of themesets.");

        // set new area to examine
        SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

        // examine next area
        DelayCommand(0.01, ExecuteScript("exe_id1_catsets", GetNextCPU()));
    }
}
