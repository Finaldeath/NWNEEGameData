#include "inc_id1_flags"
#include "inc_id1_text"

void main()
{
    string sString = "";

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

    SetCustomToken(5100, sString);
}
