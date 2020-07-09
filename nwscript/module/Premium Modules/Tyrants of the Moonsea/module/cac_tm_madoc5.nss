// madoc and the player travel from the opening area to voonlar

#include "hf_in_plot"
#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet("MadoctheUncouth", 5);
    TeleportToWaypoint(oPC, "WP_VOONLAR_START");
}
