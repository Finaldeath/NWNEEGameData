//Kornah guided tour
#include "x0_i0_walkway"

#include "hf_in_plot"

void main()
{
    SetLocalInt(OBJECT_SELF, "nBusy", 1);
    ActionForceMoveToObject(GetWaypointByTag("WP_ZK_GUIDE_2"), FALSE, 0.5, 40.0);
    ActionForceMoveToObject(GetWaypointByTag("WP_ZK_GUIDE_1"), FALSE, 0.5, 40.0);
    ActionForceMoveToObject(GetWaypointByTag("WP_ZK_GUIDE_4"), FALSE, 0.5, 40.0);
    ActionDoCommand(SetFacing(DIRECTION_SOUTH));
    ActionDoCommand(PlotLevelSet(GetTag(OBJECT_SELF), 6));
    ActionDoCommand(SetLocalInt(OBJECT_SELF, "nBusy", 0));
}
