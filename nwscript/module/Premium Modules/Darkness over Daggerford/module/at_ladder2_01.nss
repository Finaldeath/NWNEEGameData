// player descends from AR0900 to AR0901 using a ladder

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "WP_AR0901_LADDER_BOTTOM", TRUE);
}
