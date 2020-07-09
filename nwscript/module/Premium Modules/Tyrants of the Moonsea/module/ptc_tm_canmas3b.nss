//Transition Player down the spiral staircase in Candlemas Ruins

#include "hf_in_npc"

void main()
{
    object oClicker=GetClickingObject();

     // move the player
    TeleportToWaypoint(oClicker, "WP_ART_ROC_03b_DST");
}
