#include "inc_id_liltimmy"

void main()
{
    if (lt_GetFirstBoss() == 3)
    {
        lt_SetDungeonLevel(ID_LOCAL_FIRST_BOSS_DEFEATED);
    } else if (lt_GetSecondBoss() == 3)
    {
        lt_SetDungeonLevel(ID_LOCAL_SECOND_BOSS_DEFEATED);
    } else
    {
        lt_SetDungeonLevel(ID_LOCAL_THIRD_BOSS_DEFEATED);
    }
}
