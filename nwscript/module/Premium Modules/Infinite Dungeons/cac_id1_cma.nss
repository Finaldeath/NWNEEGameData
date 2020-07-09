#include "inc_id1_flags"
#include "inc_id1_text"

void main()
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

    SetCustomToken(5100, sString);
}
