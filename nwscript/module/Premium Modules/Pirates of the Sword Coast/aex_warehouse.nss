//::///////////////////////////////////////////////
//:: Warehouse OnEnter script
//:: aoe_warehouse.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    OnExit script for the warehouse.
    Make sure the PC's are not plot/immortal

    If player was fighting Redtip, he'll assume
    they are a coward. Well, I don't think he
    currently has dialogue for that, but we
    can still set the variable.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 10, 2005
//:://////////////////////////////////////////////
#include "inc_redtip"


void main()
{
    object oPC = GetExitingObject();
    if(GetIsPCNotDM(oPC))
    {
        SetImmortal(oPC, FALSE);
        SetPlotFlag(oPC, FALSE);

        // if the brawl is on, and the person leaving is the person from
        // the fight, then the brawl is over
        object oRedtip = GetObjectByTagInArea(a2c_tag_Redtip);
        if( (GetLocalInt(oRedtip, l_n_REDTIP_BRAWL_ON)) &&
            (GetLocalObject(oRedtip, l_o_REDTIP_BRAWL_PLAYER_OBJECT) == oPC) )
        {
            RedtipEndBrawl(l_nv_REDTIP_BRAWL_OUTCOME_FLED, oRedtip);
        }
    }

}
