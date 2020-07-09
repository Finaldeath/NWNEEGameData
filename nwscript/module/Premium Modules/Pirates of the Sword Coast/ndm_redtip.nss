//::///////////////////////////////////////////////
//:: ndm_redtip
//:: Based on x2_def_ondamage
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Redtip's OnDamaged script
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: June 30, 2004
//:://////////////////////////////////////////////
#include "inc_redtip"

void main()
{
    //--------------------------------------------------------------------------
    // GZ: 2003-10-16
    // Make Plot Creatures Ignore Attacks
    //--------------------------------------------------------------------------
    if (GetPlotFlag(OBJECT_SELF))
    {
        return;
    }

    // brawl is on
    if(GetLocalInt(OBJECT_SELF, l_n_REDTIP_BRAWL_ON))
    {
        if(GetCurrentHitPoints() < 2)
        {
            // Redtip has been beaten.
            RedtipEndBrawl(l_nv_REDTIP_BRAWL_OUTCOME_WON);
            return;
        }
    }


    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------
    ExecuteScript("nw_c2_default6", OBJECT_SELF);
}
