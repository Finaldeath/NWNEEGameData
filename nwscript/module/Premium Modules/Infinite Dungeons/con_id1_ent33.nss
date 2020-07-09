// 1 = active, but unoccupied
// 2 = active and occupied
// 3 = plot dungeon
// 4 = no dungeon

#include "inc_id1_debug"

int StartingConditional()
{
    int nDungeonListNum = GetLocalInt(OBJECT_SELF, "nDungeonListNum");
    int nCurrentPage = GetLocalInt(OBJECT_SELF, "nCurrentPage");
    int nDungeon = 3 + ((nCurrentPage - 1) * 10);
    if (nDungeonListNum >= nDungeon)
    {
        int nDungeonNum = GetLocalInt(OBJECT_SELF, "nDungeonList" + IntToString(nDungeon));
        DebugMessage("nDungeonList" + IntToString(nDungeon) + " is " + IntToString(nDungeonNum));
        location lLocation = GetLocation(GetObjectByTag("CPU"));
        string sName = "Dungeon" + IntToString(nDungeonNum);
        object oDungeon = RetrieveCampaignObject("ID_DATABASE", sName, lLocation);
        if (oDungeon != OBJECT_INVALID)
        {
            string sDungeonName = GetLocalString(oDungeon, "sDungeonName");
            int nMaxX = GetLocalInt(oDungeon, "nMaxX");
            int nMaxY = GetLocalInt(oDungeon, "nMaxY");
            int nDungeonDepth = GetLocalInt(oDungeon, "nDungeonDepth");

            string sString = sDungeonName + " [" + IntToString(nMaxX) + "x" + IntToString(nMaxY) + "x" + IntToString(nDungeonDepth) + "]";

            SetCustomToken(5203, sString);

            DestroyObject(oDungeon);

            return TRUE;
        } else
        {
            return FALSE;
        }
    } else
    {
        return FALSE;
    }
}
