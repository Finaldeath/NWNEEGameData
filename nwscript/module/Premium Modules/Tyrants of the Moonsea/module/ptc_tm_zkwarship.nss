//Transition Player to ship from Zhentil Keep war zone and switch off VFX

#include "hf_in_npc"
#include "hf_in_plot"

void main()
{
    object oClicker=GetClickingObject();
    object oTarget=GetTransitionTarget(OBJECT_SELF);

    PlotLevelSet("ZKWarTransitioned", 0);

     // move the player
    TeleportToWaypoint(oClicker, "WP_ZK2_TO_SHIP");
}
