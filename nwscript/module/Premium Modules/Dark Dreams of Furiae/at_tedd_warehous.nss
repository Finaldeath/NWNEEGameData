#include "ddf_util"

void main()
{
    int iCurrentDay = GetCurrentDay();
    if(iCurrentDay > 1) return;

    object oTeddy = GetObjectByTag("DDF_NPC_Teddy");

    if(GetLocalInt(oTeddy, "teddy_run_warehouse") != TRUE) return;
    if(GetLocalInt(oTeddy, "teddy_arrived_warehouse") == TRUE) return;

    object oWaypoint = GetWaypointByTag("Sea_Market_Teddy");

    AssignCommand(oTeddy, ActionMoveToObject(oWaypoint, FALSE));
}
