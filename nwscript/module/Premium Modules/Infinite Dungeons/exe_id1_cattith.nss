#include "inc_id1_debug"
// object GetNextCPU()
#include "inc_id1_utility"

const int ID1_STEP_SIZE = 100;

void main()
{
    // get the current tileset being examined
    int nTileset = GetLocalInt(GetModule(), "nQueueMin");
    int nCount = 0;

    int nTilesetNum = GetLocalInt(GetModule(), "nTileset");

    object oMicroCPU;
    int nMicroNum;

    // get the number of tilesets available
    string sTileset = "default";
    while ((nTileset <= nTilesetNum) && (nCount < ID1_STEP_SIZE))
    {
        DebugMessage("  Creating theme information for tileset " + IntToString(nTileset));

        // create a subprocess to search for linkings for this tileset
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU61");
        SetLocalInt(oMicroCPU, "nTileset", nTileset);

        nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
        nMicroNum++;
        SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

        DelayCommand(0.01, ExecuteScript("exe_id1_cattith2", oMicroCPU));

        nCount++;
        nTileset++;
    }

    // if all tilesets have been run through
    if (nTileset > nTilesetNum)
    {
        DebugMessage(" No more tilesets found.");

        SetLocalInt(GetModule(), "nQueueMin", 0);

        // return to catalog generation
        DelayCommand(0.01, ExecuteScript("exe_id1_cathold", GetNextCPU()));
    } else // if tilesets remain
    {
        DebugMessage("  Checking next set of tilesets.");

        // set new area to examine
        SetLocalInt(GetModule(), "nQueueMin", nTileset);

        // examine next area
        DelayCommand(0.01, ExecuteScript("exe_id1_cattith", GetNextCPU()));
    }
}
