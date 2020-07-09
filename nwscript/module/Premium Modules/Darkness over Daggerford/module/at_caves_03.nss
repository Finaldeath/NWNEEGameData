#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "WP_AR2000_CAVE_EXIT", TRUE);
}
