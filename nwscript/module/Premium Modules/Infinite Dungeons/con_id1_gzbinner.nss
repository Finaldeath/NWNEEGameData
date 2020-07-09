#include "inc_id_liltimmy"

int StartingConditional()
{
    // if masterius is the third boss
    if (lt_GetThirdBoss() == ID_LOCAL_BOSS_BEHOLDER)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
