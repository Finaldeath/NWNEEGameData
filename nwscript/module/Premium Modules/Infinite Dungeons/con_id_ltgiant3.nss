//::///////////////////////////////////////////////
//:: con_id_ltgiant3
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC faced the giantess as the third lieutenant
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"

int StartingConditional()
{
    int iResult;

    iResult = lt_GetThirdLieutenant() == ID_LOCAL_LIEUTENANT_GIANTESS;
    return iResult;
}
