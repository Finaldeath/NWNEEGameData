#include "inc_id1_utility"
#include "inc_id_liltimmy"
#include "inc_id1_text"

// 1 = active, but unoccupied
// 2 = active and occupied
// 3 = plot dungeon
// 4 = no dungeon

void main()
{
    string sString = "";

    // get dungeon name
    object oDungeon = GetCurrentDungeon();
    string sDungeonName = GetLocalString(oDungeon, "sDungeonName");
    sString += sDungeonName + " is no longer the target of this entrance.";

    // store dungeon information and delete
    int nDungeonNumber = GetLocalInt(GetModule(), "nDungeonNumber");
    if (nDungeonNumber != 0)
    {
        string sName = "Dungeon" + IntToString(nDungeonNumber);
        int bSuccess = StoreCampaignObject("ID_DATABASE", sName, oDungeon);
        DebugMessage("Success of storing of " + sName + " is " + IntToString(bSuccess));
    }

    SetLocalObject(GetModule(), "oCurrentDungeon", OBJECT_INVALID);
    SetLocalInt(GetModule(), "nDungeonNumber", 0);
    DestroyObject(oDungeon);

    SetLocalInt(OBJECT_SELF, "nDungeonState", 4);

    SetCustomToken(5200, sString);
}
