#include "inc_id1_utility"
#include "inc_id1_text"

int StartingConditional()
{
    if (GetLocalInt(OBJECT_SELF, "nCurrentPage") < 100)
    {
        int nCurrentPage = GetLocalInt(OBJECT_SELF, "nCurrentPage");
        int nDungeon = nCurrentPage * 10;
        int nDungeonListNum = GetLocalInt(OBJECT_SELF, "nDungeonListNum");
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
        SetCustomToken(5210, sString);

        DestroyObject(oDungeon);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
