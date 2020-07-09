#include "ddf_util"
void main()
{
    RemoveHenchperson(OBJECT_SELF);

    // Set the flag that quill is not on the street anymore
    SetLocalInt(GetModule(), "ddf_quill_on_street", FALSE);

    // Teleport Quill
    object oWaypoint = GetWaypointByTag("DDF_QUILL_START");
    location locWP = GetLocation( oWaypoint );
    ActionJumpToLocation(locWP);
}
