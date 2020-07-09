#include "ddf_util"

// Exposed variable
const string WAYPOINT = "WAYPOINT";

void main()
{
    object oPC = GetPlaceableLastClickedBy();
    if (GetIsObjectValid(oPC))
    {
        // Get the waypoint variable
        string sWaypoint = GetLocalString(OBJECT_SELF, WAYPOINT);

        if (sWaypoint != "")
        {
            // Get the waypoint object and teleport
            object oWaypoint = GetWaypointByTag(sWaypoint);
            location locWP = GetLocation( oWaypoint );
            AssignCommand(oPC, ActionJumpToLocation(locWP));
        }
        else
        {
            debug("P_TELEPORT: Missing var [" + WAYPOINT + "]");
        }
    }
}
