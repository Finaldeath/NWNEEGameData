#include "inc_id_liltimmy"

void main()
{
    if (lt_GetFirstLieutenant() == 2)
    {
        lt_SetDungeonLevel(ID_LOCAL_FIRST_DUNGEON_COMPLETED);
    } else if (lt_GetSecondLieutenant() == 2)
    {
        lt_SetDungeonLevel(ID_LOCAL_SECOND_DUNGEON_COMPLETED);
    } else
    {
        lt_SetDungeonLevel(ID_LOCAL_THIRD_DUNGEON_COMPLETED);
    }
}
