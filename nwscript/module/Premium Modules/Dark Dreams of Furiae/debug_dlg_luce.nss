#include "ddf_journal"

void main()
{
    debug("-- debug Lucenna's dialog in Guard HQ.");

    object oNPC = GetObjectByTag("DDF_NPC_Lucenna");
    object oTeleportWaypoint = GetWaypointByTag("GuardHQ_Lucenna");
    location locTeleportWP = GetLocation( oTeleportWaypoint );
    AssignCommand(oNPC, ActionJumpToLocation(locTeleportWP));

    IncrementDay(); // get us to day 2.

    UpdateJournal(GetFirstPC());
}
