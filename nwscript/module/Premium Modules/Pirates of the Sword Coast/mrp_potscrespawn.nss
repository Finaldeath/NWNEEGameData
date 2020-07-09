//::///////////////////////////////////////////////
//:: mrp_potscrespawn
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The respawn event for a PC in the PotSC module
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_safepoint"

void main()
{
    object oPlayer = GetLastRespawnButtonPresser();
    SpawnPlayer(oPlayer);
}
