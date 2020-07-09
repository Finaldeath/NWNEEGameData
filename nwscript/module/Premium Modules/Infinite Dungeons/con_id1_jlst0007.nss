#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if ((nListType == 7) || (nListType == 8) || (nListType == 9) || (nListType == 10))
    {
        string sString = "";
        int nTemp;

        // get the chance of 1 exit
        sString += "The proportional chance of a one-exit area is ";
        nTemp = GetModuleFlagValue(ID1_FLAG_DUNGEON_ONE_EXIT);
        sString += IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // get the chance of 2 exit
        sString += "The proportional chance of a two-exit area is ";
        nTemp = GetModuleFlagValue(ID1_FLAG_DUNGEON_TWO_EXIT);
        sString += IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // get the chance of 3 exit
        sString += "The proportional chance of a three-exit area is ";
        nTemp = GetModuleFlagValue(ID1_FLAG_DUNGEON_THREE_EXIT);
        sString += IntToString(nTemp) + ".";
        sString = AddLineBreak(sString);

        // get the chance of 4 exit
        sString += "The proportional chance of a four-exit area is ";
        nTemp = GetModuleFlagValue(ID1_FLAG_DUNGEON_FOUR_EXIT);
        sString += IntToString(nTemp) + ".";

        SetCustomToken(5100, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
