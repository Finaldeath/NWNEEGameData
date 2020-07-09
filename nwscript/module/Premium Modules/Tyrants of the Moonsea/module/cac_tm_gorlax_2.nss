// sparrow unlocks the door to the thieves guild and enters

#include "hf_in_plot"

void main()
{
    PlotLevelSet(GetTag(OBJECT_SELF), 4);
    object oDoor = GetObjectByTag("ZhentOrphanIN");
    SetLocked(oDoor, FALSE);
    AssignCommand(oDoor, ActionOpenDoor(oDoor));

    object oWP = GetWaypointByTag("WP_ZKAO_SPARROW1");
    location lLoc = GetLocation(oWP);
    AssignCommand(OBJECT_SELF, JumpToLocation(lLoc));
}
