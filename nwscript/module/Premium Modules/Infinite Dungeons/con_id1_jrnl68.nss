#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_flags"

int StartingConditional()
{
    string sString = "";
    int nTemp;

    if (GetModuleFlag(ID1_FLAG_DEATH_PLAYER_HENCHMEN) == ID1_DEATH_PLAYER_HENCHMEN_DIE)
    {
        sString += "A player's henchmen will die when the player dies.";
    } else
    {
        sString += "A player's henchmen will not die when the player dies.";
    }

    SetCustomToken(5100, sString);

    return TRUE;
}
