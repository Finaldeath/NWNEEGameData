// Murder in Elmwood
// climb up rope from Elmwood Subterranean Lair to Elmwood well

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "WP_EL_WELL", TRUE);
}
