//::////////////////////////////////////////////////////////////////////////////
//:: nhb_id1_hrtmnn
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Heartbeat Event script for Harat's Erinyes minions. Should they sray too
    far from the levers they gaurd they should be teleported back.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 16, 2006
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_harat"

void main()
{
    object oThis = OBJECT_SELF;
    object oLever = GetLocalObject(oThis, GAURDED_LEVER);

    if (GetDistanceBetween(oThis, oLever) > 4.0)
    {
        ActionTeleportToLever();
    }

    // Update Oct 20, 2005 for Infinite Dungeons.
    // Determine if the creature is currently a follower.
    // If so run the henchmen AI otherwise run the default.
    // - Grant Mackay
    if (GetLocalInt(OBJECT_SELF, "bFollower"))
    {
        ExecuteScript("x0_ch_hen_heart", OBJECT_SELF);
    }
    else
    {
        ExecuteScript("nw_c2_default1", OBJECT_SELF);
    }
}
