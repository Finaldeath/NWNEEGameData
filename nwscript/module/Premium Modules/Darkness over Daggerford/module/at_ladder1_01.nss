// player climbs the ladder under the tree of blood

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "WP_AR0900_LADDER_TOP", TRUE);
}
