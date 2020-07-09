// sparrow runs away to hide after stealing from the player

#include "hf_in_plot"

void main()
{
    PlotLevelSet("Sparrow", 2);
    object oWP = GetWaypointByTag("WP_ZKEP_SPARROW_HIDE");
    ClearAllActions();
    ActionMoveToObject(oWP, TRUE, 0.5);
}
