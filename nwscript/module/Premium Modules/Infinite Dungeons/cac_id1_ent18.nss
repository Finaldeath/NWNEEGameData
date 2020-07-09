#include "inc_id1_utility"
#include "inc_id1_text"

void main()
{
    // store current dungeon
    DebugMessage("");

    // reset the current level
    int nCurrentLevel = GetLocalInt(GetModule(), "nCurrentLevel");
    DebugMessage("Current level is " + IntToString(nCurrentLevel));
    DebugMessage("Set nCurrentLevel to 0. Point 1.");
    SetLocalInt(GetModule(), "nCurrentLevel", 0);

    // save the state of the current dungeon and unmark it
    int nDungeonNumber = GetLocalInt(GetModule(), "nDungeonNumber");
    DebugMessage("Current dungeon number is " + IntToString(nDungeonNumber));
    if (nDungeonNumber != 0)
    {
        object oDungeon = GetLocalObject(GetModule(), "oCurrentDungeon");
        string sName = "Dungeon" + IntToString(nDungeonNumber);
        int bSuccess = StoreCampaignObject("ID_DATABASE", sName, oDungeon);
        DebugMessage("Success of storing of " + sName + " is " + IntToString(bSuccess));
        DestroyObject(oDungeon);
    }

    SetLocalInt(GetModule(), "nDungeonNumber", 0);
    SetLocalObject(GetModule(), "oCurrentDungeon", OBJECT_INVALID);

    int nLineNumber = GetLocalInt(OBJECT_SELF, "nDungeonNumber");
    string sName = "Dungeon-" + IntToString(nLineNumber);
    location lLocation = GetLocation(GetObjectByTag("CPU"));
    object oDungeon = RetrieveCampaignObject("ID_DATABASE", sName, lLocation);
    SetLocalObject(GetModule(), "oCurrentDungeon", oDungeon);
    SetLocalInt(GetModule(), "nDungeonNumber", -1 * nLineNumber);
    SetLocalInt(OBJECT_SELF, "nDungeonState", 1);
}
