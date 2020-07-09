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

    iResult = lt_GetDungeonLevel() == ID_LOCAL_FIRST_BOSS_CREATED
        || lt_GetDungeonLevel() == ID_LOCAL_FIRST_BOSS_DEFEATED
        || lt_GetDungeonLevel() == ID_LOCAL_SECOND_BOSS_CREATED
        || lt_GetDungeonLevel() == ID_LOCAL_SECOND_BOSS_DEFEATED
        || lt_GetDungeonLevel() == ID_LOCAL_THIRD_BOSS_CREATED
        || lt_GetDungeonLevel() == ID_LOCAL_THIRD_BOSS_DEFEATED;
    return iResult;
}
