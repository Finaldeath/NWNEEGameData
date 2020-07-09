//::///////////////////////////////////////////////
//:: con_a2_redtip_ch
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    PC cheated in the fight with redtip.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 10/05
//:://////////////////////////////////////////////
#include "inc_global"

int StartingConditional()
{
    // if the player cheated in the last brawl, return true, otherwise false
    if(GetLocalInt(OBJECT_SELF, l_n_REDTIP_BRAWL_OUTCOME)==l_nv_REDTIP_BRAWL_OUTCOME_CHEATED)
    {
        return TRUE;
    }
    else return FALSE;
}
