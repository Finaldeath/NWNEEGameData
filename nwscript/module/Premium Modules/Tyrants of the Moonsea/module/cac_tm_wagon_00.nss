// player enters madoc's wagon

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "WP_VNRD_WAGON_ENTER");
}
