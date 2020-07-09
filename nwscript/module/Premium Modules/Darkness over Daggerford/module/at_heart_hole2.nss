// the player swims from the heart hold back to the mines

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "WP_AR2501_HOLE_EXIT", TRUE);
}
