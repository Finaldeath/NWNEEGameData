#include "ddf_util"

void main()
{
    debug("Clicked on door thingie.");
    object oPC = GetPlaceableLastClickedBy();
    if(oPC == OBJECT_INVALID)
    {
        debug("called get placeable incorrectly...");
        return;
    }

    object oWaypoint = GetWaypointByTag("NW_ALAD_CHOP_SHOP");
    MovePlayerToObject(oPC, oWaypoint, TRUE);

    //location locWP = GetLocation(oWaypoint);
    //MovePartyToObject(GetFirstPC(), oWaypoint);
}
