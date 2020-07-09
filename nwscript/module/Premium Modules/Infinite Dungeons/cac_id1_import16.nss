#include "inc_id1_utility"

void main()
{
    // find which dungeon this should be and assign
    int nDungeonNum = 1;
    string sFileName = "Dungeon" + IntToString(nDungeonNum);
    location lLocation = GetLocation(GetObjectByTag("CPU"));
    object oDungeon = RetrieveCampaignObject("ID_DATABASE", sFileName, lLocation);
    while ((oDungeon != OBJECT_INVALID) && (nDungeonNum < 100))
    {
        DestroyObject(oDungeon);
        nDungeonNum++;
        sFileName = "Dungeon" + IntToString(nDungeonNum);
        oDungeon = RetrieveCampaignObject("ID_DATABASE", sFileName, lLocation);
    }
    DestroyObject(oDungeon);

    // set as the current dungeon
    SetLocalInt(GetModule(), "nDungeonNumber", nDungeonNum);
    DebugMessage("Dungeon number selected was " + IntToString(nDungeonNum));
    SetLocalInt(OBJECT_SELF, "nDungeonState", 1);
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    SetLocalObject(GetModule(), "oCurrentDungeon", oImport);
    SetLocalObject(OBJECT_SELF, "oImport", OBJECT_INVALID);
}
