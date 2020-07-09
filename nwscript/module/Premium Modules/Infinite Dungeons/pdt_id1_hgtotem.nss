//::////////////////////////////////////////////////////////////////////////////
//:: pdt_id1_hgtotem
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Death event script for the totems in Widow Hagatha's area. When a totem
    is destroyed the waypoint it is located on should be flagged as empty.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 09, 2006
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_hagatha"

void main()
{
    int nWaypoint = GetLocalInt(OBJECT_SELF, TOTEM_WP_NUM);

    object oWaypoint = DB_GetWaypointByTag(TOTEM_WP_PRFX + IntToString(nWaypoint));

    SetLocalInt(oWaypoint, TOTEM_DESTROYED, TRUE);
}
