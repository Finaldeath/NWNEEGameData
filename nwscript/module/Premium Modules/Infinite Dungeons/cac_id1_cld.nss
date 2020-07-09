#include "inc_id1_flags"
#include "inc_id1_text"

void main()
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
    sString += IntToString(nTemp) + " levels deep.";

    SetCustomToken(5100, sString);
}
