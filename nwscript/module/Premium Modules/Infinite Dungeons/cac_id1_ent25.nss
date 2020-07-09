#include "inc_id1_utility"

void main()
{
    // rebuild database
    // rebuild dungeon list

    int nLineNumber = GetLocalInt(OBJECT_SELF, "nDungeonNumber");
    int nCurrentPage = GetLocalInt(OBJECT_SELF, "nCurrentPage");
    int nDungeon = nLineNumber + ((nCurrentPage - 1) * 10);
    int nDungeonListNum = GetLocalInt(OBJECT_SELF, "nDungeonListNum");
    int nDungeonNum = GetLocalInt(OBJECT_SELF, "nDungeonList" + IntToString(nDungeon));

    location lLocation = GetLocation(GetObjectByTag("CPU"));
    object oDungeon = CreateObject(OBJECT_TYPE_ITEM, "dungeonobject", lLocation);
    StoreCampaignObject("ID_DATABASE", "Dungeon" + IntToString(nDungeonNum), oDungeon);
    DebugMessage("Destroying Dungeon" + IntToString(nDungeonNum));
    DestroyObject(oDungeon);

    // adjust dungeon list
    while (nDungeon < nDungeonListNum)
    {
        nDungeonNum = GetLocalInt(OBJECT_SELF, "nDungeonList" + IntToString(nDungeon + 1));
        DebugMessage("  Getting nDungeonList" + IntToString(nDungeon + 1) + " which is " + IntToString(nDungeonNum));
        SetLocalInt(OBJECT_SELF, "nDungeonList" + IntToString(nDungeon), nDungeonNum);
        DebugMessage("  Setting nDungeonList" + IntToString(nDungeon) + " to " + IntToString(nDungeonNum));

        nDungeon++;
    }

    nDungeonListNum--;
    SetLocalInt(OBJECT_SELF, "nDungeonListNum", nDungeonListNum);
    DebugMessage("  Setting nDungeonListNum to " + IntToString(nDungeonListNum));
}
