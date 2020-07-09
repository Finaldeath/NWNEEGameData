// the player uses the shipwreck's window to enter the ship

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "WP_AR2009_SHIP_ENTER", TRUE);
}
