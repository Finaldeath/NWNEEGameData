#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if (nListType == 4)
    {
        string sString = "";
        int nTemp;

        // get levels
        sString += "The dungeon is ";
        if (GetModuleFlag(ID1_FLAG_DUNGEON_DEPTH) == ID1_DUNGEON_DEPTH_RANDOM)
        {
            sString += "up to ";
        }
        nTemp = GetModuleFlagValue(ID1_FLAG_DUNGEON_DEPTH);
        sString += IntToString(nTemp) + " ";
        if (nTemp == 1)
        {
            sString += "level deep.";
        } else
        {
            sString += "levels deep.";
        }

        SetCustomToken(5100, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
