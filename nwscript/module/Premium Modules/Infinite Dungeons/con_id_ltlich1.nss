//::///////////////////////////////////////////////
//:: con_id_ltlich1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC faced the lich as the first boss
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"

int StartingConditional()
{
    int iResult;

    iResult = lt_GetFirstBoss() == ID_LOCAL_BOSS_LICH;
    return iResult;
}
