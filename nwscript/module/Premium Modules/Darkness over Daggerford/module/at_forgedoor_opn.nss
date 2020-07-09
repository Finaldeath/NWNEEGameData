// the player has found the secret lever which opens the forge door

#include "hf_in_plot"

void main()
{
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    object oWP = GetWaypointByTag("WP_AR2501_FORGE_DOOR");
    CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_forgedoor", GetLocation(oWP));
}
