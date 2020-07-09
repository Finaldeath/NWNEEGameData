#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "WP_AR2001_CAVES_ENTER", TRUE);
}
