#include "inc_id1_debug"

void main()
{
    int nCurrentTileset = GetLocalInt(OBJECT_SELF, "nTileset");

    string sLinking = GetLocalString(GetModule(), "sTileset" + IntToString(nCurrentTileset) + "Linking");
    DebugMessage("Linking string for tileset " + IntToString(nCurrentTileset) + " is " + sLinking);

    string sSubString;
    int nDistance;
    int nDistanceListNum;

    int nTilesetNum = GetLocalInt(GetModule(), "nTileset");
    int nTileset = 1;
    while (nTileset <= nTilesetNum)
    {
        // reading in the row of this tileset and record
        sSubString = GetSubString(sLinking, nTileset - 1, 1);
        nDistance = StringToInt(sSubString);
        SetLocalInt(GetModule(), "nTileset" + IntToString(nCurrentTileset) + "Distance" + IntToString(nTileset), nDistance);
        DebugMessage("  Distance between " + IntToString(nCurrentTileset) + " and " + IntToString(nTileset) + " is " + IntToString(nDistance) + " with substring " + sSubString);

        // create distance lists
        nDistanceListNum = GetLocalInt(GetModule(), "nTileset" + IntToString(nCurrentTileset) + "DistanceList" + IntToString(nDistance));
        nDistanceListNum++;
        SetLocalInt(GetModule(), "nTileset" + IntToString(nCurrentTileset) + "DistanceList" + IntToString(nDistance), nDistanceListNum);
        SetLocalInt(GetModule(), "nTileset" + IntToString(nCurrentTileset) + "DistanceList" + IntToString(nDistance) + "_" + IntToString(nDistanceListNum), nTileset);
        DebugMessage("  Set nTileset" + IntToString(nCurrentTileset) + "DistanceList" + IntToString(nDistance) + "_" + IntToString(nDistanceListNum) + " to " + IntToString(nTileset));

        nTileset++;
    }

    int nMicroDead = GetLocalInt(GetModule(), "nMicroDead");
    nMicroDead++;
    SetLocalInt(GetModule(), "nMicroDead", nMicroDead);

    DestroyObject(OBJECT_SELF);
}
