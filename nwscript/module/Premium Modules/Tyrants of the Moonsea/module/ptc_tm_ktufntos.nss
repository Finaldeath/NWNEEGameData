//Transition Player from North to South of Kur-Tharsu Upper Ground

#include "hf_in_npc"

void main()
{
    object oClicker=GetClickingObject();

     // move the player
    TeleportToWaypoint(oClicker, "WP_THKTUF_FROM_NORTH");
}
