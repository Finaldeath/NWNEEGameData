// Murder in Elmwood
// climb down rope from Elmwood to Elmwood Subterranean Lair

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "WP_EWSUB_ROPE", TRUE);
}
