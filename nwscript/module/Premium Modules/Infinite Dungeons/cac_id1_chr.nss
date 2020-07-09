#include "inc_id1_flags"
#include "inc_id1_text"
#include "inc_id1_utility"

void main()
{
    string sString = "";
    int nTemp;

    // respawn location
    nTemp = GetModuleFlag(ID1_FLAG_DEATH_PLAYER);
    if (nTemp == ID1_DEATH_PLAYER_PERMANENT)
    {
        sString += "Player death is permanent.";
    } else if (nTemp == ID1_DEATH_PLAYER_RESPAWN_INSTANT)
    {
        sString += "Players respawn where they died.";
    } else if (nTemp == ID1_DEATH_PLAYER_RESPAWN_AREA)
    {
        sString += "Players respawn at the entrance to the area in which they died.";
    } else if (nTemp == ID1_DEATH_PLAYER_RESPAWN_LEVEL)
    {
        sString += "Players respawn at the entrance to the level in which they died.";
    } else if (nTemp == ID1_DEATH_PLAYER_RESPAWN_DUNGEON)
    {
        sString += "Players will respawn in Little Timmy's warehouse.";
    }

    SetCustomToken(5100, sString);
}
