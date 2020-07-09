//::///////////////////////////////////////////////
//:: con_id_ltgiant
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC faced the giantess as the first lieutenant
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"

int StartingConditional()
{
    int iResult;

    iResult = lt_GetFirstLieutenant() == ID_LOCAL_LIEUTENANT_GIANTESS;
    return iResult;
}
