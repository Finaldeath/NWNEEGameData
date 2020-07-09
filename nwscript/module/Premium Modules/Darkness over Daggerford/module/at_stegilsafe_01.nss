// the player removes stegil's chest from the secret vault

#include "hf_in_plot"

void main()
{
    object oWP = GetWaypointByTag("WP_AR0901_SECRET_WALL");
    object oChest = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_secretwall_pl", GetLocation(oWP));
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
}
