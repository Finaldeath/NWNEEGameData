// player climbs up the rope in ar2501b

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "WP_AR2501A_ROPE_TOP", TRUE);
}
