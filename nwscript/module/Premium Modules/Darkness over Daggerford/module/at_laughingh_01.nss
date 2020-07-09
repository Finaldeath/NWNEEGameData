// the player enters illefarn from laughing hollow

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "wp_ar2501a_entry", TRUE);
}
