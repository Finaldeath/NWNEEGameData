#include "inc_id1_debug"
// object GetNextCPU()
#include "inc_id1_utility"

const int ID1_STEP_SIZE = 100;
const int ID1_LOOK_AHEAD = 50;

int GetIsOpenDecor(int nDecorType);
int GetIsWallDecor(int nDecorType);

void main()
{
    // starting position
    int nStart = GetLocalInt(GetModule(), "nQueueMin");
    int nCount = 0;

    string s2DA = "decor";

    int nDecor;
    string sDecorType;
    int nDecorType;
    string sTilesets;

    // cycle through entries in the list
    string sResRef = "default";
    while ((sResRef != "") && (nCount < ID1_STEP_SIZE))
    {
        // get the resref of the current object
        sResRef = Get2DAString(s2DA, "OBJECT_RESREF", nStart + nCount);

        // is this a valid item
        if (sResRef != "")
        {
            DebugMessage("  Decor 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);

            // what kind of decor is this
            sDecorType = Get2DAString(s2DA, "DECOR_TYPE", nStart + nCount);
            nDecorType = StringToInt(sDecorType);

            if ((GetIsOpenDecor(nDecorType) == TRUE) || (GetIsWallDecor(nDecorType) == TRUE))
            {
                // add this decor item to the list
                nDecor = GetLocalInt(GetModule(), "nDecor");
                nDecor++;
                SetLocalInt(GetModule(), "nDecor", nDecor);
                SetLocalString(GetModule(), "sDecor" + IntToString(nDecor) + "ResRef", sResRef);
                DebugMessage("    Assigned as decor item " + IntToString(nDecor));

                sTilesets = Get2DAString(s2DA, "TILESETS", nStart + nCount);
                SetLocalString(GetModule(), "sDecor" + IntToString(nDecor) + "Tilesets", sTilesets);
//                DebugMessage("    Set tilesets string to " + sTilesets);

                if (GetIsOpenDecor(nDecorType) == TRUE)
                {
//                    DebugMessage("    Open decor.");

                    // record the state of this object
                    SetLocalInt(GetModule(), "bDecor" + IntToString(nDecor) + "Open", TRUE);
                }

                if (GetIsWallDecor(nDecorType) == TRUE)
                {
//                    DebugMessage("    Wall decor.");

                    // record the state of this object
                    SetLocalInt(GetModule(), "bDecor" + IntToString(nDecor) + "Wall", TRUE);
                }
            } else
            {
//                DebugMessage("    Decor object is not used.");
            }

            // increment counter
            nCount++;
        }
    }

    // if a null string was returned
    if (sResRef == "")
    {
//        DebugMessage("  Decor 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);

        // reset starting point
        nStart = nStart + nCount;

        // look ahead to see if any more exist
        nCount = 0;
        while ((sResRef == "") && (nCount < ID1_LOOK_AHEAD))
        {
            // increment counter
            nCount++;

            sResRef = Get2DAString("decor", "OBJECT_RESREF", nStart + nCount);
//            DebugMessage("    Decor 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);
        }

        // if another entry was found
        if (sResRef != "")
        {
//            DebugMessage("    Object found at entry " + IntToString(nStart + nCount));

            // set new start point
            SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

            // examine entries at new start point
            DelayCommand(0.01, ExecuteScript("exe_id1_catdecor", GetNextCPU()));
        } else // if no entry was found
        {
//            DebugMessage("    No more decor items found.");

            SetLocalInt(GetModule(), "nQueueMin", 0);

            // return to the catalog
            DelayCommand(0.01, ExecuteScript("exe_id1_catalog", GetNextCPU()));
        }
    } else // if all examined entries were used
    {
//        DebugMessage("    Examining next set of entries.");

        // set new starting point
        SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

        // examine entries at new start point
        DelayCommand(0.01, ExecuteScript("exe_id1_catdecor", GetNextCPU()));
    }
}

int GetIsOpenDecor(int nDecorType)
{
    if (nDecorType >= 10)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}

int GetIsWallDecor(int nDecorType)
{
    if (nDecorType >= 10)
    {
        nDecorType -= 10;
    }
    return nDecorType;
}

