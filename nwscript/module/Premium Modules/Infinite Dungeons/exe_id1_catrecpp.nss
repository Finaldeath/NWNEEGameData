#include "inc_id1_debug"
// object GetNextCPU()
#include "inc_id1_utility"

const int ID1_STEP_SIZE = 1;
const int ID1_LOOK_AHEAD = 50;

void main()
{
    // starting position
    int nStart = GetLocalInt(GetModule(), "nQueueMin");

    // current position variable
    int nCount = 0;

    int nRecipePropertyNum;

    // get the resref of the current object
    string sResRef = Get2DAString("itemprops", "22_Recipe", nStart);

    // is this a valid item
    if (sResRef != "")
    {
        DebugMessage("  Line " + IntToString(nStart) + ": Object " + sResRef);

        // if a valid recipe property
        if (StringToInt(sResRef) == 1)
        {
            // add to recipe property list
            nRecipePropertyNum = GetLocalInt(GetModule(), "nRecipePropertyNum");
            nRecipePropertyNum++;
            SetLocalInt(GetModule(), "nRecipePropertyNum", nRecipePropertyNum);
            SetLocalInt(GetModule(), "nRecipeProperty" + IntToString(nRecipePropertyNum), nStart);

            DebugMessage("    There were " + IntToString(nRecipePropertyNum) + " recipe properties found.");
        }
    }

    // if a null string was returned
    if (sResRef == "")
    {
        // EDIT: add look ahead back in?
        DebugMessage("    End of recipe properties found.");

        // return to the catalog
        DelayCommand(0.01, ExecuteScript("exe_id1_catalog", GetNextCPU()));
    } else // if all examined entries were used
    {
        DebugMessage("    Examining next set of entries.");

        // set new starting point
        SetLocalInt(GetModule(), "nQueueMin", nStart + 1);

        // examine entries at new start point
        DelayCommand(0.01, ExecuteScript("exe_id1_catrecpp", GetNextCPU()));
    }
}
