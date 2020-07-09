#include "inc_id1_flags"
#include "inc_id1_text"

void main()
{
    string sString = "";

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

    SetCustomToken(5100, sString);
}
