// player tells millie about plan to use ferry to escape

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "nPlayCheeseScene", 1);
    TeleportToWaypoint(oPC, "wp_ef_pcarrive", FALSE);
}
