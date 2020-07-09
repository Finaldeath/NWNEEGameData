#include "inc_id1_flags"
#include "inc_id1_text"

void main()
{
    // get dimensions and height
    int nX = GetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_X);
    int nY = GetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_Y);
    int nDepth = GetModuleFlagValue(ID1_FLAG_DUNGEON_DEPTH);

    // EDIT: add fixed checks

    string sToken = "Dungeon width is FIXED at " + IntToString(nX) + ".";
    sToken = AddLineBreak(sToken);
    sToken += "Dungeon height is FIXED at " + IntToString(nY) + ".";
    sToken = AddLineBreak(sToken);
    sToken += "Dungeon depth is FIXED at " + IntToString(nDepth) + ".";

    SetCustomToken(5100, sToken);
}
