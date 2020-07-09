#include "inc_id_liltimmy"

void main()
{
    if (lt_GetFirstBoss() == 2)
    {
        lt_SetDungeonLevel(ID_LOCAL_FIRST_BOSS_DEFEATED);
    } else if (lt_GetSecondBoss() == 2)
    {
        lt_SetDungeonLevel(ID_LOCAL_SECOND_BOSS_DEFEATED);
    } else
    {
        lt_SetDungeonLevel(ID_LOCAL_THIRD_BOSS_DEFEATED);
    }
}
