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
    sString = AddLineBreak(sString);

    // get levels
    sString += "The dungeon is ";
    if (GetModuleFlag(ID1_FLAG_DUNGEON_DEPTH) == ID1_DUNGEON_DEPTH_RANDOM)
    {
        sString += "up to ";
    }
    nTemp = GetModuleFlagValue(ID1_FLAG_DUNGEON_DEPTH);
    sString += IntToString(nTemp) + " levels deep.";
    sString = AddLineBreak(sString);

    // get the level size
    sString += "The maximum size of a level is ";
    nTemp = GetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_X);
    sString += IntToString(nTemp) + " by ";
    nTemp = GetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_Y);
    sString += IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

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
    sString = AddLineBreak(sString);

    SetCustomToken(5100, sString);
}
