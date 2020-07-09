#include "inc_id1_flags"
#include "inc_id1_text"

void main()
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
}
