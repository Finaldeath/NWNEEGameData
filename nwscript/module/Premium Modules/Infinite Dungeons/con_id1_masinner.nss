#include "inc_id_liltimmy"

int StartingConditional()
{
    // if masterius is the third boss
    if (lt_GetThirdBoss() == ID_LOCAL_BOSS_LICH)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
