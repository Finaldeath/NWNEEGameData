#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if (nListType == 3)
    {
        string sString = "";
        int nTemp;

        // get stairs
        sString += "The dungeon has ";
        if (GetModuleFlag(ID1_FLAG_STAIRS_NUMBER) == ID1_STAIRS_NUMBER_RANDOM)
        {
            sString += "up to ";
        }
        nTemp = GetModuleFlagValue(ID1_FLAG_STAIRS_NUMBER);
        sString += IntToString(nTemp) + " staircases down per level.";

        SetCustomToken(5100, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
