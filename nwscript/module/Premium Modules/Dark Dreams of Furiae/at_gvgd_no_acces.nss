#include "ddf_journal"
void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(GetModule(), "ddf_guvner_guard_no_access", TRUE);
    UpdateJournal(oPC);

    // Teleport the player outside the records building
    object oPlayerWaypoint = GetWaypointByTag("NW_Midtown_Records");
    location locPWP = GetLocation( oPlayerWaypoint );
    AssignCommand(oPC, ActionJumpToLocation(locPWP));

}
