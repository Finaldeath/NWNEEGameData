//::///////////////////////////////////////////////
//:: con_a2_redtip_lo
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    PC lost in the fight with redtip.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 11/05
//:://////////////////////////////////////////////
#include "inc_global"

int StartingConditional()
{
    // if the player lost or fled in the last brawl, return true, otherwise false
    int nOutcome = GetLocalInt(OBJECT_SELF, l_n_REDTIP_BRAWL_OUTCOME);
    if(nOutcome == l_nv_REDTIP_BRAWL_OUTCOME_LOST ||
       nOutcome == l_nv_REDTIP_BRAWL_OUTCOME_FLED)
    {
        return TRUE;
    }
    else return FALSE;
}
