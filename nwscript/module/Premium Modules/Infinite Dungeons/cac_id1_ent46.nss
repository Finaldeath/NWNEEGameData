#include "inc_id1_utility"

void main()
{
    int nLineNumber = GetLocalInt(OBJECT_SELF, "nDungeonNumber");
    int nCurrentPage = GetLocalInt(OBJECT_SELF, "nCurrentPage");
    int nDungeon = nLineNumber + ((nCurrentPage - 1) * 10);
    int nDungeonListNum = GetLocalInt(OBJECT_SELF, "nDungeonListNum");
    int nDungeonNum = GetLocalInt(OBJECT_SELF, "nDungeonList" + IntToString(nDungeon));
    object oDungeon = GetCurrentDungeon();

    int nExport = GetLocalInt(OBJECT_SELF, "nExport");
    string sFileName = "ID_" + IntToStringDigits(nExport, 3);
    SetLocalString(OBJECT_SELF, "sFileName", sFileName);

   // DestroyCampaignDatabase(sFileName);

    location lLocation = GetLocation(GetWaypointByTag("CPU"));
    StoreCampaignObject(sFileName, "oDungeon", oDungeon);
}
