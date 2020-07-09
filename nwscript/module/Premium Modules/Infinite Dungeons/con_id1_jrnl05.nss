#include "inc_id1_utility"
#include "inc_id1_text"

int StartingConditional()
{
    location lLocation = GetLocation(GetObjectByTag("CPU"));
    int nDungeon = GetLocalInt(OBJECT_SELF, "nDungeonNumber");
    string sName = "Dungeon-" + IntToString(nDungeon);
    object oDungeon = RetrieveCampaignObject("ID_DATABASE", sName, lLocation);
    SetLocalObject(GetModule(), "oCurrentDungeon", oDungeon);
    SetLocalInt(GetModule(), "nDungeonNumber", -1 * nDungeon);

    // get dungeon name
    string sString = "";

    string sDungeonName = GetLocalString(oDungeon, "sDungeonName");
    sString += sDungeonName + " has been set as the active dungeon.";

    SetCustomToken(5200, sString);

    return TRUE;
}
