//Transition Player to Zhentil Keep Warzone and switch on VFX

#include "hf_in_npc"
#include "hf_in_plot"
#include "hf_in_spawn"

void main()
{
    object oClicker=GetClickingObject();
    object oTarget=GetTransitionTarget(OBJECT_SELF);

    if (GetIsPC(oClicker))
    {
        PlotLevelSet("ZKWarTransitioned", 1);
        SpawnEnter(oClicker);
        // move the player
        TeleportToWaypoint(oClicker, "WP_ZK2_FROM_SHIP");
    }
}
