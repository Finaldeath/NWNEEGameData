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

    string s2DA = "tilesets";

    int nTileset;
    string sTileset;
    string sThemes;
    string sLinking;

    // go through entire 2da
    string sResRef = "default";
    while ((sResRef != "") && (nCount < ID1_STEP_SIZE))
    {
        // grab tileset resref
        sResRef = Get2DAString(s2DA, "TILESET_RESREF", nStart + nCount);

        if (sResRef != "")
        {
            DebugMessage("  Tileset 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);

            // set tilesets
            nTileset = GetLocalInt(GetModule(), "nTileset");
            nTileset++;
            SetLocalInt(GetModule(), "nTileset", nTileset);

            sTileset = Get2DAString(s2DA, "TILESET_NAME", nStart + nCount);
            SetLocalInt(GetModule(), "nTileset_" + sResRef, nTileset);
            SetLocalString(GetModule(), "sTileset" + IntToString(nTileset) + "ResRef", sResRef);
            SetLocalString(GetModule(), "sTileset" + IntToString(nTileset) + "Name", sTileset);
            SetLocalInt(GetModule(), "nTilesetName_" + sTileset, nTileset);
            DebugMessage("    nTileset" + IntToString(nTileset) + " assigned " + sResRef + " and " + sTileset);

            sThemes = "1" + Get2DAString(s2DA, "THEMES", nStart + nCount);
            SetLocalString(GetModule(), "sTileset" + IntToString(nTileset) + "Themes", sThemes);
            DebugMessage("    sTileset" + IntToString(nTileset) + "Themes is " + sThemes);

            sLinking = Get2DAString(s2DA, "TILESET_LINKING", nStart + nCount);
            SetLocalString(GetModule(), "sTileset" + IntToString(nTileset) + "Linking", sLinking);
            DebugMessage("    sTileset" + IntToString(nTileset) + "Linking is " + sLinking);

            // increment counter
            nCount++;
        }
    }

    // if a null string was returned
    if (sResRef == "")
    {
        DebugMessage("  Tileset 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);

        // reset starting point
        nStart = nStart + nCount;

        // check the next set of entries to see if any more exist
        nCount = 0;
        while ((sResRef == "") && (nCount < ID1_LOOK_AHEAD))
        {
            // increment counter
            nCount++;

            // grab resref
            sResRef = Get2DAString(s2DA, "TILESET_RESREF", nStart + nCount);
            DebugMessage("  Tileset 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);
        }

        // if another entry was found
        if (sResRef != "")
        {
            DebugMessage("  Tileset found at entry " + IntToString(nStart + nCount));

            // set new start point
            SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

            // examine entries at new start point
            DelayCommand(0.01, ExecuteScript("exe_id1_cattile", GetNextCPU()));
        } else // if no entry was found
        {
            DebugMessage("    No more tilesets found.");

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
        DelayCommand(0.01, ExecuteScript("exe_id1_cattile", GetNextCPU()));
    }
}

