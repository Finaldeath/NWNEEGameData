//Kornah guided tour begins
#include "x0_i0_walkway"

#include "hf_in_plot"

void main()
{
    SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE);
    SetWalkCondition(NW_WALK_FLAG_INITIALIZED,FALSE);
    SetLocalInt(OBJECT_SELF, "nBusy", 1);
    ActionForceMoveToObject(GetWaypointByTag("WP_ZK_GUIDE_1"), FALSE, 0.5, 30.0);
    ActionDoCommand(SetFacing(DIRECTION_SOUTH));
    ActionDoCommand(PlotLevelSet(GetTag(OBJECT_SELF), 3));
    ActionDoCommand(SetLocalInt(OBJECT_SELF, "nBusy", 0));
}
