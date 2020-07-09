#include "inc_id1_utility"

void main()
{
    int nCurrentPage = GetLocalInt(OBJECT_SELF, "nCurrentPage");
    int nDungeonNumber = GetLocalInt(OBJECT_SELF, "nDungeonNumber");
    int nDungeon = nDungeonNumber + ((nCurrentPage - 1) * 10);
    string sFileName = "ID_" + IntToStringDigits(nDungeon, 3);
    DebugMessage("Testing dungeon " + sFileName + " for import.");
    location lLocation = GetLocation(GetWaypointByTag("CPU"));
    object oImport = RetrieveCampaignObject(sFileName, "oDungeon", lLocation);
    SetLocalObject(OBJECT_SELF, "oImport", oImport);
}
