#include "inc_id_liltimmy"

void main()
{
    if (lt_GetFirstBoss() == 1)
    {
        lt_SetDungeonLevel(ID_LOCAL_FIRST_BOSS_DEFEATED);
    } else if (lt_GetSecondBoss() == 1)
    {
        lt_SetDungeonLevel(ID_LOCAL_SECOND_BOSS_DEFEATED);
    } else
    {
        lt_SetDungeonLevel(ID_LOCAL_THIRD_BOSS_DEFEATED);
    }
}
