#include "inc_id_liltimmy"

int StartingConditional()
{
    if (lt_GetDungeonLevel() == 15)
    {
        lt_SetDungeonLevel(16);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
