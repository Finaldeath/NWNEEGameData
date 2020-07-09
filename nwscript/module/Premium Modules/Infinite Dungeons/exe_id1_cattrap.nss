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

    int nDamageType;

    int nDamageID;

    string s2DA = "trapdamage";

    string sTilesets;

    int nTileset;
    int nDamageTypeNum;
    string sSubString;

    // go through entire 2da
    string sDamageType = "default";
    while ((sDamageType != "") && (nCount < ID1_STEP_SIZE))
    {
        // grab theme name
        sDamageType = Get2DAString(s2DA, "DAMAGE_TYPE", nStart + nCount);

        if (sDamageType != "")
        {
            DebugMessage("  Trap damage 2DA line " + IntToString(nStart + nCount) + " is " + sDamageType);

            // add damage type to list
            nDamageType = GetLocalInt(GetModule(), "nDamageType");
            nDamageType++;
            SetLocalInt(GetModule(), "nDamageType", nDamageType);

            // get damage ID
            nDamageID = StringToInt(Get2DAString("trapdamage", "DAMAGE_ID", nStart + nCount));
            SetLocalInt(GetModule(), "nDamageType" + IntToString(nDamageType) + "ID", nDamageID);
            SetLocalInt(GetModule(), "nDamageType_" + IntToString(nDamageID), nDamageType);

            sTilesets = Get2DAString(s2DA, "TILESETS", nStart + nCount);
            SetLocalString(GetModule(), "sDamageType" + IntToString(nDamageType) + "Tilesets", sTilesets);
            DebugMessage("  Tileset string set to " + sTilesets);
/*
            nTileset = 1;
            while (nTileset <= 15)
            {
                sSubString = GetSubString(sTilesets, nTileset - 1, 0);
                if (sSubString == "1")
                {
                    nDamageTypeNum = GetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "DamageType");
                    nDamageTypeNum++;
                    SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "DamageType", nDamageTypeNum);
                    SetLocalInt(GetModule(), "nTileset" + IntToString(nTileset) + "DamageType" + IntToString(nDamageTypeNum), nDamageType);
                    DebugMessage("  Set nTileset" + IntToString(nTileset) + "DamageType" + IntToString(nDamageTypeNum) + " to " + IntToString(nDamageType));
                }

                nTileset++;
            }*/

            // increment counter
            nCount++;
        }
    }

    // if a null string was returned
    if (sDamageType == "")
    {
        DebugMessage("  Trap damage 2DA line " + IntToString(nStart + nCount) + " is " + sDamageType);

        // reset starting point
        nStart = nStart + nCount;

        // check the next set of entries to see if any more exist
        nCount = 0;
        while ((sDamageType == "") && (nCount < ID1_LOOK_AHEAD))
        {
            // increment counter
            nCount++;

            // grab resref
            sDamageType = Get2DAString(s2DA, "DAMAGE_TYPE", nStart + nCount);
            DebugMessage("  Trap damage 2DA line " + IntToString(nStart + nCount) + " is " + sDamageType);
        }

        // if another entry was found
        if (sDamageType != "")
        {
            DebugMessage("    Theme found at entry " + IntToString(nStart + nCount));

            // set new start point
            SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

            // examine entries at new start point
            DelayCommand(0.01, ExecuteScript("exe_id1_cattrap", GetNextCPU()));
        } else // if no entry was found
        {
            DebugMessage("      No more trap damage types found.");

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
        DelayCommand(0.01, ExecuteScript("exe_id1_cattrap", GetNextCPU()));
    }
}
