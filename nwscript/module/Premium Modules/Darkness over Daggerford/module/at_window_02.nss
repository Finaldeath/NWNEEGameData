// the player leaves the ship's hold via the window

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "WP_AR2000_SHIP_EXIT", TRUE);
}
