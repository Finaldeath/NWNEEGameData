void main()
{
    // Move teddy to kitchen
    object oTeddy = GetObjectByTag("DDF_NPC_Teddy");

    object oTeddyWaypoint = GetWaypointByTag("AladaraAptTeddySentry");
    location locTWP = GetLocation( oTeddyWaypoint );
    AssignCommand(oTeddy, ActionMoveToLocation(locTWP));
}
