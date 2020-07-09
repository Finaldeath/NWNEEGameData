//::///////////////////////////////////////////////
//:: cac_a2_redtip_rr
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Redtip has responded to the result of the
    last fight, so we can now reset it. This
    way he'll go back to a neutral greeting
    next time.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 11/05
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    SetLocalInt(OBJECT_SELF, l_n_REDTIP_BRAWL_OUTCOME, l_nv_REDTIP_BRAWL_OUTCOME_RESET);
}
