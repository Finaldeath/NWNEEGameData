#include "ddf_util"

void main()
{
    // Conversed with player
    SetLocalInt(GetModule(), "luce_001_done", TRUE);

    if(GetCurrentArea(GetPCSpeaker()) == AREA_GUARD_POST) return;

    // Walk towards the first waypoint
    object oMoveWaypoint = GetWaypointByTag("path_to_guardhq_02");
    ActionMoveToObject(oMoveWaypoint);

    // After a certain amount of time, teleport into the HQ
    object oTeleportWaypoint = GetWaypointByTag("GuardHQ_Lucenna");
    location locTeleportWP = GetLocation( oTeleportWaypoint );
    DelayCommand(5.0, ActionJumpToLocation(locTeleportWP));
}
