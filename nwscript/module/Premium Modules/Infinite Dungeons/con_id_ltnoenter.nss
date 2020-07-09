//::///////////////////////////////////////////////
//:: con_id_ltnoenter
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC hasn't entered the dungeon yet
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"

int StartingConditional()
{
    int iResult;

    iResult = lt_GetDungeonLevel() == ID_LOCAL_DUNGEON_NOT_ENTERED;
    return iResult;
}
