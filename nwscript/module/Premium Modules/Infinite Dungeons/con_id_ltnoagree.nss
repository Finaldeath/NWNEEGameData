//::///////////////////////////////////////////////
//:: con_id_ltnoagree
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC hasn't agreed to enter the dungeon yet
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"

int StartingConditional()
{
    int iResult;

    iResult = lt_GetIsEntryAgreed() == FALSE;
    return iResult;
}
