//::///////////////////////////////////////////////
//:: Name nsp_potsc_hrbvr
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Spawn script (FOR Herbavores)
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
#include "inc_balance"
#include "NW_I0_GENERIC"
#include "NW_O2_CONINCLUDE"
#include "x0_i0_anims"

void main()
{
    object oOmnivore = OBJECT_SELF;

    // Creature will only attack those that close within 5m
    // and are not friends, Rangers or Druids.
    SetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL);
    SetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE);

    LevelUpNPC(oOmnivore);
    ExecuteScript("exe_gen_loot", oOmnivore);

    // Goes through and sets up which shouts the NPC will listen to.
    SetListeningPatterns();
    WalkWayPoints();
}
