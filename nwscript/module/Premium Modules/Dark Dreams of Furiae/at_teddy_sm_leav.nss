void main()
{
    // Walk towards the first waypoint
    object oMoveWaypoint = GetWaypointByTag("path_to_guardhq_02");
    ActionMoveToObject(oMoveWaypoint);

    // After a certain amount of time, teleport into the HQ
    object oTeleportWaypoint = GetWaypointByTag("NW_LIMBO_TEDDY");
    location locTeleportWP = GetLocation( oTeleportWaypoint );
    DelayCommand(5.0, ActionJumpToLocation(locTeleportWP));
}
