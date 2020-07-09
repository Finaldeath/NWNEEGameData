#include "inc_id1_flags"

void main()
{
    if (GetModuleFlag(ID1_FLAG_PLAYER_RESPAWN_RESTED) == ID1_ACTIVE)
    {
        SetModuleFlag(ID1_FLAG_PLAYER_RESPAWN_RESTED, ID1_INACTIVE);
    } else
    {
        SetModuleFlag(ID1_FLAG_PLAYER_RESPAWN_RESTED, ID1_ACTIVE);
    }
}
