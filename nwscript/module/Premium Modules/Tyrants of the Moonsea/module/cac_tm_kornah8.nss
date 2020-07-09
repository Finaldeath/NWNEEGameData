//Kornah guided tour completes
#include "x0_i0_walkway"

#include "hf_in_plot"

void main()
{
    //Give Zhentil Keep Guide to Slang to PC
    CreateItemOnObject("aguidetozhentilk", GetPCSpeaker());

    SetLocalInt(OBJECT_SELF, "nBusy", 1);
    ActionForceMoveToObject(GetWaypointByTag("WP_ZK_GUIDE_6"), FALSE, 0.5, 30.0);
    ActionDoCommand(SetFacing(DIRECTION_SOUTH));
    ActionDoCommand(PlotLevelSet(GetTag(OBJECT_SELF), 8));
    ActionDoCommand(SetLocalInt(OBJECT_SELF, "nBusy", 0));
}
