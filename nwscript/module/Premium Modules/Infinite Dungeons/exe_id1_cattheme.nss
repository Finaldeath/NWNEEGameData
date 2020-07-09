#include "inc_id1_debug"
// object GetNextCPU()
#include "inc_id1_utility"

const int ID1_STEP_SIZE = 100;
const int ID1_LOOK_AHEAD = 50;

void main()
{
    // get starting point
    int nStart = GetLocalInt(GetModule(), "nQueueMin");
    int nCount = 0;

    string s2DA = "themes";

    // number of themes
    int nTheme;

    // if this is the first time starting, set up the THEME_ALL
    if (nStart == 0)
    {
        SetLocalInt(GetModule(), "nTheme", 1);
        SetLocalString(GetModule(), "sTheme1Name", "THEME_ALL");
        SetLocalInt(GetModule(), "nTheme_THEME_ALL", 1);
    }

    // go through theme 2da
    string sTheme = "default";
    while ((sTheme != "") && (nCount < ID1_STEP_SIZE))
    {
        // grab theme name
        sTheme = Get2DAString(s2DA, "THEME_NAME", nStart + nCount);

        if (sTheme != "")
        {
            DebugMessage("  Theme 2DA entry " + IntToString(nStart + nCount) + " is " + sTheme);

            // set themes
            nTheme = GetLocalInt(GetModule(), "nTheme");
            nTheme++;
            SetLocalInt(GetModule(), "nTheme", nTheme);
            SetLocalString(GetModule(), "sTheme" + IntToString(nTheme) + "Name", sTheme);
            SetLocalInt(GetModule(), "nTheme_" + sTheme, nTheme);
            DebugMessage("    nTheme" + IntToString(nTheme) + " assigned " + sTheme);

            // increment counter
            nCount++;
        }
    }

    // if a null string was returned
    if (sTheme == "")
    {
        DebugMessage("  Theme 2DA entry " + IntToString(nStart + nCount) + " is " + sTheme);

        // reset starting point
        nStart = nStart + nCount;

        // check the next set of entries to see if any more exist
        nCount = 0;
        while ((sTheme == "") && (nCount < ID1_LOOK_AHEAD))
        {
            // increment counter
            nCount++;

            // grab resref
            sTheme = Get2DAString(s2DA, "THEME_NAME", nStart + nCount);
            DebugMessage("  Theme 2DA entry " + IntToString(nStart + nCount) + " is " + sTheme);
        }

        // if another entry was found
        if (sTheme != "")
        {
            DebugMessage("  Theme found at entry " + IntToString(nStart + nCount));

            // set new start point
            SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

            // examine entries at new start point
            DelayCommand(0.01, ExecuteScript("exe_id1_cattheme", GetNextCPU()));
        } else // if no entry was found
        {
            DebugMessage("    No more themes found.");

            SetLocalInt(GetModule(), "nQueueMin", 0);

            // return to the catalog
            DelayCommand(0.01, ExecuteScript("exe_id1_catalog", GetNextCPU()));
        }
    } else // if all examined entries were used
    {
        DebugMessage("  Examining next set of entries.");

        // set new starting point
        SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

        // examine entries at new start point
        DelayCommand(0.01, ExecuteScript("exe_id1_cattheme", GetNextCPU()));
    }
}

