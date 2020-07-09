#include "ddf_util"

void main()
{
    SetLocalInt(OBJECT_SELF, "diva_001_done", TRUE);
    SetLocalInt(OBJECT_SELF, "diva_001_letpass", TRUE);

    // Need to teleport the whole party to a waypoint
    object oPC = GetFirstPC();
    if(MovePartyToObject(oPC, GetObjectByTag("NW_DIVA_PASS"), FALSE, TRUE) == FALSE)
    {
        debug("Unable to move party to NW_DIVA_PASS...");
        return;
    }

    /*
    object oPlayerWaypoint = GetWaypointByTag("NW_DIVA_PASS");
    location locPWP = GetLocation( oPlayerWaypoint );

    while (GetIsObjectValid(oPC))
    {
        AssignCommand(oPC, ActionJumpToLocation(locPWP));
        oPC = GetNextPC();
    }
    */
}
