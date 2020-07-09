//::///////////////////////////////////////////////
//:: con_id_ltnofirst
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC hasn't finished the first level of dungeon yet
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"

int StartingConditional()
{
    int iResult;

    iResult = lt_GetDungeonLevel() < ID_LOCAL_FIRST_DUNGEON_COMPLETED;
    return iResult;
}
