#include "ddf_util"

void main()
{
    int iCurrentDay = GetCurrentDay();

    if(iCurrentDay > 1) return;

    object oTeddy = GetObjectByTag("DDF_NPC_Teddy");

    if(GetLocalInt(oTeddy, "teddy_arrived_warehouse") == TRUE) return;
    if(GetLocalInt(oTeddy, "teddy_run_warehouse") == TRUE) return;

    SetLocalInt(oTeddy, "teddy_run_warehouse", TRUE);

    debug("Starting Teddy on his way to the Warehouse...");

    AssignCommand(oTeddy, JumpToObject(GetWaypointByTag("seamarket_arrival_teddy"), FALSE));

    object oWaypoint = GetWaypointByTag("Sea_Market_Teddy");

    AssignCommand(oTeddy, ActionMoveToObject(oWaypoint, FALSE));
}
