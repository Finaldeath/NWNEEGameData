void main()
{
    int nLineNumber = GetLocalInt(OBJECT_SELF, "nDungeonNumber");
    int nCurrentPage = GetLocalInt(OBJECT_SELF, "nCurrentPage");
    int nDungeon = nLineNumber + ((nCurrentPage - 1) * 10);
    int nDungeonNum = GetLocalInt(OBJECT_SELF, "nDungeonList" + IntToString(nDungeon));
    string sName = "Dungeon" + IntToString(nDungeonNum);
    location lLocation = GetLocation(GetObjectByTag("CPU"));
    object oDungeon = RetrieveCampaignObject("ID_DATABASE", sName, lLocation);
    SetLocalObject(GetModule(), "oCurrentDungeon", oDungeon);
    SetLocalInt(GetModule(), "nDungeonNumber", nDungeonNum);
    SetLocalInt(OBJECT_SELF, "nDungeonState", 1);
}
