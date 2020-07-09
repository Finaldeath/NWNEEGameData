#include "inc_id_liltimmy"

int StartingConditional()
{
    // if halaster has been defeated
    if (lt_GetDungeonLevel() >= ID_LOCAL_HALASTER_TIMMY)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
