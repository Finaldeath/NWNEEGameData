#include "inc_id1_utility"
#include "inc_id1_text"

int StartingConditional()
{
    int nCurrentPage = GetLocalInt(OBJECT_SELF, "nCurrentPage");
    int nDungeon = 9 + ((nCurrentPage - 1) * 10);
//    int nDungeonListNum = GetLocalInt(OBJECT_SELF, "nDungeonListNum");
    string sFileName = "ID_" + IntToStringDigits(nDungeon, 3);
    location lLocation = GetLocation(GetWaypointByTag("CPU"));
    object oDungeon = RetrieveCampaignObject(sFileName, "oDungeon", lLocation);

    string sString = "";

    if (oDungeon != OBJECT_INVALID)
    {
        string sDungeonName = GetLocalString(oDungeon, "sDungeonName");
        int nMaxX = GetLocalInt(oDungeon, "nMaxX");
        int nMaxY = GetLocalInt(oDungeon, "nMaxY");
        int nDungeonDepth = GetLocalInt(oDungeon, "nDungeonDepth");

        sString += sFileName + " - " + sDungeonName + " [" + IntToString(nMaxX) + "x" + IntToString(nMaxY) + "x" + IntToString(nDungeonDepth) + "]";
    } else
    {
        sString += MakeTextRed(sFileName + " does not exist.");
    }

    DestroyObject(oDungeon);

    SetCustomToken(5209, sString);

    return TRUE;
}
