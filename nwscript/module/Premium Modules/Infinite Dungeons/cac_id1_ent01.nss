#include "inc_id1_utility"
#include "inc_id_liltimmy"

// 1 = active, but unoccupied
// 2 = active and occupied
// 3 = plot dungeon
// 4 = no dungeon

void main()
{
    ActionPauseConversation();

    // assemble list of custom dungeons
    object oDungeon;
    int nDungeonNum = 0;
    int nDungeon = 1;
    location lLocation = GetLocation(GetObjectByTag("CPU"));
    string sName;
    string sDungeonName;
    while (nDungeon <= 100)
    {
        sName = "Dungeon" + IntToString(nDungeon);
        oDungeon = RetrieveCampaignObject("ID_DATABASE", sName, lLocation);
        if (oDungeon != OBJECT_INVALID)
        {
            sDungeonName = GetLocalString(oDungeon, "sDungeonName");
            DebugMessage("Name of " + sName + " is " + sDungeonName);
            if (sDungeonName != "")
            {
                nDungeonNum++;
                SetLocalInt(OBJECT_SELF, "nDungeonList" + IntToString(nDungeonNum), nDungeon);
            }
        }
        DestroyObject(oDungeon);

        // check next dungeon
        nDungeon++;
    }
    SetLocalInt(OBJECT_SELF, "nDungeonListNum", nDungeonNum);

    ActionResumeConversation();
}
