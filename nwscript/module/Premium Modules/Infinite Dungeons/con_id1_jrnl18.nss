#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_flags"

int StartingConditional()
{
    string sString = "";

    // get autocleanup
    if (GetModuleFlag(ID1_FLAG_MAP_AUTOCLEANUP) == ID1_ACTIVE)
    {
        sString += "The dungeon map will clean itself up when the player moves away.";
    } else
    {
        sString += "The dungeon map will remain until the player uses the map again, or leaves the area.";
    }
    sString = AddLineBreak(sString);

    // get display
    if (GetModuleFlag(ID1_FLAG_MAP_DISPLAY) == ID1_MAP_DISPLAY_ALL)
    {
        sString += "The player can see all areas in the level they are on.";
    } else if (GetModuleFlag(ID1_FLAG_MAP_DISPLAY) == ID1_MAP_DISPLAY_PARTY)
    {
        sString += "The player can see all areas that they or their party members have explored.";
    } else
    {
        sString += "The player can only see areas they have explored themselves.";
    }
    sString = AddLineBreak(sString);

    // get boundaries
    if (GetModuleFlag(ID1_FLAG_MAP_BOUNDARY) == ID1_MAP_BOUNDARY_SHOW_FULL)
    {
        sString += "The size of the map is the maximum width and length of the level.";
    } else if (GetModuleFlag(ID1_FLAG_MAP_BOUNDARY) == ID1_MAP_BOUNDARY_SHOW_EXTENTS)
    {
        sString += "The map will display only those areas that can be explored.";
    } else
    {
        sString += "The map will only show the areas that have been explored.";
    }
    sString = AddLineBreak(sString);

    SetCustomToken(5100, sString);

    return TRUE;
}
