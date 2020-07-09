#include "inc_id1_utility"

int StartingConditional()
{
    string sString = "";

    // get dungeon name
    object oDungeon = GetCurrentDungeon();
    string sDungeonName = GetLocalString(oDungeon, "sDungeonName");
    sString += sDungeonName + " is no longer the target of this entrance.";

    SetCustomToken(5200, sString);

    return TRUE;
}
