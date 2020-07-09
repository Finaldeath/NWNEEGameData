//Kornah guided tour
#include "x0_i0_walkway"

#include "hf_in_plot"

void main()
{
    SetLocalInt(OBJECT_SELF, "nBusy", 1);
    ActionForceMoveToObject(GetWaypointByTag("WP_ZK_GUIDE_3"), FALSE, 0.5, 45.0);
    ActionDoCommand(SetFacing(DIRECTION_EAST));
    ActionDoCommand(PlotLevelSet(GetTag(OBJECT_SELF), 5));
    ActionDoCommand(SetLocalInt(OBJECT_SELF, "nBusy", 0));
}
