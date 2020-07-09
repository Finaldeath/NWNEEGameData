#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if ((nListType == 5) || (nListType == 6))
    {
        string sString = "";
        int nTemp;

        // get the level size
        sString += "The maximum size of a level is ";
        nTemp = GetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_X);
        sString += IntToString(nTemp) + " areas wide by ";
        nTemp = GetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_Y);
        sString += IntToString(nTemp) + " areas long.";

        SetCustomToken(5100, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
