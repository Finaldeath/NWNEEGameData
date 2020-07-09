#include "inc_id1_utility"

void main()
{
    object oDungeon = GetCurrentDungeon();

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
}
