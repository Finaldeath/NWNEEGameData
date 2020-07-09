//::///////////////////////////////////////////////
//:: nat_redtip
//:: Based on x2_def_attacked
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Redtip's On Physically attacked script
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 10/05
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
        object oPlayerInFight = GetLocalObject(OBJECT_SELF, l_o_REDTIP_BRAWL_PLAYER_OBJECT);
        object oAttacker = GetLastAttacker();
        if ( (oAttacker != oPlayerInFight) &&
             (GetMaster(oAttacker) != oPlayerInFight) )
        {
            // Whoever just attacked Redtip is neither the player in the fight,
            // nor one of their companions. Redtip not happy.
            RedtipEndBrawl(l_nv_REDTIP_BRAWL_OUTCOME_CHEATED);
            return;
        }
    }


    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------

    ExecuteScript("nw_c2_default5", OBJECT_SELF);
}
