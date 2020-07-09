//::///////////////////////////////////////////////
//:: nhb_redtip
//:: Based on x2_def_heartbeat
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Redtip's Heartbeat script
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: June 30, 2004
//:://////////////////////////////////////////////
#include "inc_redtip"

void main()
{
    // brawl is on
    if(GetLocalInt(OBJECT_SELF, l_n_REDTIP_BRAWL_ON))
    {
        if(GetCurrentHitPoints() < 2)
        {
            // Redtip has been beaten.
            RedtipEndBrawl(l_nv_REDTIP_BRAWL_OUTCOME_WON);
            return;
        }
        else
        {
            object oTarget = GetLocalObject(OBJECT_SELF, l_o_REDTIP_BRAWL_PLAYER_OBJECT);
            if(GetCurrentHitPoints(oTarget) < 2)
            {
                // Player has been beaten.
                RedtipEndBrawl(l_nv_REDTIP_BRAWL_OUTCOME_LOST);
                return;
            }
        }
    }

    ExecuteScript("nw_c2_default1", OBJECT_SELF);
}
