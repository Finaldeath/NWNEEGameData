//::///////////////////////////////////////////////
//:: nhb_hook
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Hook the Cook's Heartbeat script.
    Calls nhb_fightclub.nss
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 11/05
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    // if I'm still trying to get to my waypoint
    // this is just in case he gets interrupted before getting there
    if(GetLocalInt(OBJECT_SELF, "GOING_TO_WP"))
    {
        // this will be run at least once, so let's make sure he's
        // at full health
        int nCurrentHP = GetCurrentHitPoints();
        int nMaxHP = GetMaxHitPoints();
        int nHeal = nMaxHP - nCurrentHP;
        if(nHeal>0)
        {
            effect eHeal = EffectHeal(nHeal);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
        }

        object oWP = GetObjectByTag(a2w_Warehouse_Redtip_Opponent_End);
        if(GetDistanceBetween(OBJECT_SELF, oWP) > 1.0)
        {
            // try getting to waypoint again, but only if not in conversation
            if(!IsInConversation(OBJECT_SELF))
            {
                ActionMoveToObject(oWP);
                ActionDoCommand(SetFacing(GetFacing(oWP)));
            }
        }
        else
        {
            // I'm there, reset variable
            SetLocalInt(OBJECT_SELF, "GOING_TO_WP", FALSE);
        }
    }
    else ExecuteScript("nhb_fightclub", OBJECT_SELF);
}
