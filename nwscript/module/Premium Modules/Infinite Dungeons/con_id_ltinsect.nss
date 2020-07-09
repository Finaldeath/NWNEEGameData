//::///////////////////////////////////////////////
//:: con_id_ltinsect
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC faced the insect as the first lieutenant
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"

int StartingConditional()
{
    int iResult;

    iResult = lt_GetFirstLieutenant() == ID_LOCAL_LIEUTENANT_INSECT;
    return iResult;
}
