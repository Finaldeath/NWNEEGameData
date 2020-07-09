//::///////////////////////////////////////////////
//:: con_a2_redtip_hc
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Return TRUE ifPC has challenged Redtip to
    a fight (result of fight not important)
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 10/05
//:://////////////////////////////////////////////
#include "inc_global"

int StartingConditional()
{
    if (GetLocalInt(OBJECT_SELF, l_n_REDTIP_BRAWL_OUTCOME) != l_nv_REDTIP_BRAWL_OUTCOME_NONE) return TRUE;
    else return FALSE;
}
