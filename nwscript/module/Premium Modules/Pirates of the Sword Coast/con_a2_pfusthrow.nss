//::///////////////////////////////////////////////
//:: con_a2_pfusthrow
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is it okay to enhance to a universal saving throw?
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: April 2005
//:://////////////////////////////////////////////
#include "inc_potscforge"

int StartingConditional()
{
    object oItem = wsGetRegisteredItem();

    if (IsOkToAdd(oItem, IP_CONST_WS_SAVING_THROW) == FALSE)
    {
        return TRUE;
    }
    return FALSE;
}



