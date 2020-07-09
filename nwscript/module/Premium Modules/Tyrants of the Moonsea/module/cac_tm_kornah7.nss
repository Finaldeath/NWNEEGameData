//Kornah guided tour
#include "hf_in_plot"

void main()
{
    SetLocalInt(OBJECT_SELF, "nBusy", 1);
    ActionForceMoveToObject(GetWaypointByTag("WP_ZK_GUIDE_5"), FALSE, 0.5, 45.0);
    ActionDoCommand(SetFacing(DIRECTION_SOUTH));
    ActionDoCommand(PlotLevelSet(GetTag(OBJECT_SELF), 7));
    ActionDoCommand(SetLocalInt(OBJECT_SELF, "nBusy", 0));
}
