//::///////////////////////////////////////////////
//:: pfp_id1_cs_door
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    OnFailToOpen event script for the doors in the
    narrator cutscene area. Hopefully this never
    fires. If it does, it means somebody got
    stuck in the area, but at least this allows
    them to get out.

    I check to see if the waypoint variable is
    valid - if so, I send them there. If not, I
    send them to the start location.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 21, 2006
//:://////////////////////////////////////////////
#include "_inc_generic"

const string TELEPORT_WAYPOINT = "oTeleportWP";

void main()
{
    object oPC = GetClickingObject();

    object oWP = GetLocalObject(OBJECT_SELF, TELEPORT_WAYPOINT);
    location lWP = GetStartingLocation();

    if(GetIsObjectValid(oWP))
    {
        // make sure the waypoint is in the same area as the start location
        // (warehouse) - if so, set lWP to that waypoint's location
        if (GetArea(oWP) == GetAreaFromLocation(lWP))
        {
            lWP = GetLocation(oWP);
        }
    }

    JumpPCsToLocation(lWP, 0, oPC);
}
