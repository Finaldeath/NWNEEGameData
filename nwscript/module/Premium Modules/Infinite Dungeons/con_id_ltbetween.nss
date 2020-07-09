//::///////////////////////////////////////////////
//:: con_id_ltbtwboss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC is between bosses on the levels
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"

int StartingConditional()
{
    int iResult;

    iResult = lt_GetDungeonLevel() == ID_LOCAL_FIRST_DUNGEON_CREATED
        || lt_GetDungeonLevel() == ID_LOCAL_FIRST_DUNGEON_COMPLETED
        || lt_GetDungeonLevel() == ID_LOCAL_SECOND_DUNGEON_CREATED
        || lt_GetDungeonLevel() == ID_LOCAL_SECOND_DUNGEON_COMPLETED
        || lt_GetDungeonLevel() == ID_LOCAL_THIRD_DUNGEON_CREATED
        || lt_GetDungeonLevel() == ID_LOCAL_THIRD_DUNGEON_COMPLETED;
    return iResult;
}
