#include "inc_id1_debug"
// object GetNextCPU()
#include "inc_id1_utility"

const int ID1_STEP_SIZE = 1;
const int ID1_LOOK_AHEAD = 50;

void main()
{
    // get the number of themes available
    int nThemeNum = GetLocalInt(GetModule(), "nTheme");

    // if there are themes available
    if (nThemeNum > 0)
    {
        // EDIT: testing
        DebugMessage("  There are tilesets available.");
        //

        // tileset name
        string sTileset = "default";

        // get starting point
        int nStart = GetLocalInt(GetModule(), "nQueueMin");

        // counting variable
        int nCount = 0;

        // individual tileset names
        string sTilesetName;

        // if a theme is present in a tileset
        int nStatus;

        // tileset boolean
        int bTileset;

        // current tileset number
        int nTileset;

        // current theme number
        int nTheme;

        // individual theme names
        string sThemeName;

        int nTilesetNum = GetLocalInt(GetModule(), "nTileset");

        // go through entire 2da
        while ((sTileset != "") && (nCount < ID1_STEP_SIZE))
        {
            // EDIT: testing
            DebugMessage("    Examining entry " + IntToString(nStart + nCount));
            //

            // grab theme name
            sTileset = Get2DAString("tilesettheme", "TILESET_NAME", nStart + nCount);

            if (sTileset != "")
            {
                // increment counter
                nCount++;

                // find the number of this tileset
                nTileset = 1;
                bTileset = FALSE;
                while ((nTileset <= nTilesetNum) && (bTileset == FALSE))
                {
                    // get the tileset in the list
                    sTilesetName = GetLocalString(GetModule(), "sTileset" + IntToString(nTileset) + "Name");

                    // EDIT: testing
                    DebugMessage("      Checking match between " + sTileset + " and " + sTilesetName);
                    //

                    // if that is the current tileset
                    if (sTilesetName == sTileset)
                    {
                        // EDIT: testing
                        DebugMessage("        Match found.");
                        //

                        bTileset = TRUE;
                    } else
                    {
                        // EDIT: testing
                        DebugMessage("        Match not found. Incrementing.");
                        //

                        nTileset++;
                    }
                }

                // if a match was found
                if (bTileset == TRUE)
                {
                    // loop through all themes available and store their relationship information
                    nTheme = 1;
                    while (nTheme <= nThemeNum)
                    {
                        // get the tileset name
                        sThemeName = GetLocalString(GetModule(), "sTheme" + IntToString(nTheme) + "Name");

                        // EDIT: testing
                        DebugMessage("      Checking theme column " + sThemeName);
                        //

                        // if this is the generic theme
                        if (sThemeName == "THEME_ALL")
                        {
                            // EDIT: testing
                            DebugMessage("        This is the generic theme. Automatic match.");
                            //

                            // match
                            nStatus = 1;
                        } else // if its not the generic theme
                        {
                            // get the relationship between the tileset and theme
                            nStatus = StringToInt(Get2DAString("tilesettheme", sThemeName, nStart + nCount - 1));
                        }

                        // if this tileset and theme go together
                        if (nStatus > 0)
                        {
                            SetLocalInt(GetModule(), "bTileset" + IntToString(nTileset) + "Theme" + IntToString(nTheme), TRUE);
                            SetLocalInt(GetModule(), "bTheme" + IntToString(nTheme) + "Tileset" + IntToString(nTileset), TRUE);

                            // EDIT: testing
                            DebugMessage("        Tileset and theme match.");
                            //
                        }

                        nTheme++;
                    }
                }
            }
        }

        // EDIT: testing
        DebugMessage("    There were " + IntToString(nCount) + " tilesets found.");
        //

        // if a null string was returned
        if (sTileset == "")
        {
            // EDIT: testing
            DebugMessage("    Null string returned.");
            //

            // reset starting point
            nStart = nStart + nCount;

            // check the next set of entries to see if any more exist
            nCount = 0;
            while ((sTileset == "") && (nCount < ID1_LOOK_AHEAD))
            {
                // increment counter
                nCount++;

                //EDIT: testing
                DebugMessage("      Checking entry " + IntToString(nStart + nCount));
                //

                // grab resref
                sTileset = Get2DAString("tilesettheme", "TILESET_NAME", nStart + nCount);
            }

            // if another entry was found
            if (sTileset != "")
            {
                // EDIT: testing
                DebugMessage("    Theme found at entry " + IntToString(nStart + nCount));
                //

                // set new start point
                SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

                // examine entries at new start point
                DelayCommand(0.01, ExecuteScript("exe_id1_cattithe", GetNextCPU()));
            } else // if no entry was found
            {
                // EDIT: testing
                DebugMessage("      No more tilesets found.");
                //

                // return to the catalog
                DelayCommand(0.01, ExecuteScript("exe_id1_catalog", GetNextCPU()));
            }
        } else // if all examined entries were used
        {
            // EDIT: testing
            DebugMessage("    Examining next set of entries.");
            //

            // set new starting point
            SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

            // examine entries at new start point
            DelayCommand(0.01, ExecuteScript("exe_id1_cattithe", GetNextCPU()));
        }
    } else // there are no themes listed
    {
        // EDIT: testing
        DebugMessage("  There are no themes available.");
        //

        // return to the catalog
        DelayCommand(0.01, ExecuteScript("exe_id1_catalog", GetNextCPU()));
    }
}

