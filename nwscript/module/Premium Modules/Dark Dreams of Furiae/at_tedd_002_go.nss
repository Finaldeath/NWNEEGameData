void main()
{
    // Set the flag
    SetLocalInt(GetModule(), "ddf_teddy_apt_leave", TRUE);

    // Teleport teddy to limbo
    object oTeddy = GetObjectByTag("DDF_NPC_Teddy");

    object oTeddyLimboWaypoint = GetWaypointByTag("NW_LIMBO_TEDDY");
    location locTLWP = GetLocation( oTeddyLimboWaypoint );
    DelayCommand(3.0, AssignCommand(oTeddy, ActionJumpToLocation(locTLWP)));
}
