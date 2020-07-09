// the player enters the pyramid portal to the nine hells

#include "hf_in_npc"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    TeleportToWaypoint(oPC, "WP_AR1110_CUT1_START", FALSE);
}
