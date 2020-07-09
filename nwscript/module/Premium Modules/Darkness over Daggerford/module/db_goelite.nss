// debug script to move the player into chateau elite

#include "hf_in_npc"

void main()
{
    object oPC = GetFirstPC();
    TeleportToWaypoint(oPC, "db_spawn_astriel", FALSE);
}
