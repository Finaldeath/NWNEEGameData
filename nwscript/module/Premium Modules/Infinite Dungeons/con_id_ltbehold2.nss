//::///////////////////////////////////////////////
//:: con_id_ltbehold2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC faced the beholder as the second boss
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"

int StartingConditional()
{
    int iResult;

    iResult = lt_GetSecondBoss() == ID_LOCAL_BOSS_BEHOLDER;
    return iResult;
}