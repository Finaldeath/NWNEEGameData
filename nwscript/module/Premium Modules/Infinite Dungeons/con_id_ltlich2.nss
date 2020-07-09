//::///////////////////////////////////////////////
//:: con_id_ltlich2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC faced the lich as the second boss
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"

int StartingConditional()
{
    int iResult;

    iResult = lt_GetSecondBoss() == ID_LOCAL_BOSS_LICH;
    return iResult;
}
