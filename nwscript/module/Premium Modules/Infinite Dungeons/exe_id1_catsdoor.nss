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

    // number of secret doors
    int nDoor;

    // number of tilesets
    int nTileset;
    int nTilesetNum = GetLocalInt(GetModule(), "nTileset");

    // name of the tileset
    string sTileset;

    // if the door is used in that tileset
    int bPresent;

    // door number
    int nDoorNum;

    string s2DA = "secretdoor";

    string sTilesets;

//    int nTileset;
//    int nDoorNum;
    string sSubString;

    // go through entire 2da
    string sDoor = "default";
    while ((sDoor != "") && (nCount < ID1_STEP_SIZE))
    {
        // grab tileset resref
        sDoor = Get2DAString(s2DA, "SECRET_DOOR_RESREF", nStart + nCount);

        if (sDoor != "")
        {
            DebugMessage("    Secret door 2DA line " + IntToString(nStart + nCount) + " is " + sDoor);

            // record this doors information
            nDoor = GetLocalInt(GetModule(), "nSecretDoor");
            nDoor++;
            SetLocalInt(GetModule(), "nSecretDoor", nDoor);
            SetLocalString(GetModule(), "sSecretDoor" + IntToString(nDoor) + "ResRef", sDoor);

            sTilesets = Get2DAString(s2DA, "TILESETS", nStart + nCount);
            SetLocalString(GetModule(), "sSecretDoor" + IntToString(nDoor) + "Tilesets", sTilesets);
            DebugMessage("    Tileset string is " + sTilesets);
/*
            nTileset = 1;
            while (nTileset <= 15)
            {
                sSubString = GetSubString(sTilesets, nTileset - 1, 0);
                if (sSubString == "1")
                {
                    nDoorNum = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "SecretDoor");
                    nDoorNum++;
                    SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "SecretDoor", nDoorNum);
                    SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "SecretDoor" + IntToString(nDoorNum), nDoor);
                    DebugMessage("  Set nTileset" + IntToString(nTileset) + "SecretDoor" + IntToString(nDoorNum) + " to " + IntToString(nDoor));
                }

                nTileset++;
            }*/

            // increment counter
            nCount++;
        }
    }

    // if a null string was returned
    if (sDoor == "")
    {
        DebugMessage("    Secret door 2DA line " + IntToString(nStart + nCount) + " is " + sDoor);

        // reset starting point
        nStart = nStart + nCount;

        // look ahead to see if any more exist
        nCount = 0;
        while ((sDoor == "") && (nCount < ID1_LOOK_AHEAD))
        {
            // increment counter
            nCount++;

            sDoor = Get2DAString(s2DA, "SECRET_DOOR_RESREF", nStart + nCount);
            DebugMessage("    Secret door 2DA line " + IntToString(nStart + nCount) + " is " + sDoor);
        }

        // if another entry was found
        if (sDoor != "")
        {
            DebugMessage("    Secret door found at entry " + IntToString(nStart + nCount));

            // set new start point
            SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

            // examine entries at new start point
            DelayCommand(0.01, ExecuteScript("exe_id1_catsdoor", GetNextCPU()));
        } else // if no entry was found
        {
            DebugMessage("    No more secret doors found.");

            SetLocalInt(GetModule(), "nQueueMin", 0);

            // return to the catalog
            DelayCommand(0.01, ExecuteScript("exe_id1_cathold", GetNextCPU()));
        }
    } else // if all examined entries were used
    {
        DebugMessage("    Examining next set of entries.");

        // set new starting point
        SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

        // examine entries at new start point
        DelayCommand(0.01, ExecuteScript("exe_id1_catsdoor", GetNextCPU()));
    }
}

