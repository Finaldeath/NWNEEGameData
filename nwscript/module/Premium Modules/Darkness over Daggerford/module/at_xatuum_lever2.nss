// the player pulls a lever to return from the vault to the main temple

#include "hf_in_npc"

void main()
{
    object oPC = GetLastUsedBy();
    TeleportToWaypoint(oPC, "WP_AR1301A_TEMPLE", TRUE);
}
