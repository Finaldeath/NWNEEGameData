// ship navi cabin in door sets variables in case player exits the cabin
// - EXIT_AREA = tag of current area
// - EXIT_WAYPOINT = waypoint in current area

#include "inc_navicabi"

void main()
{
    object oPC = GetClickingObject();
    if (GetIsPC(oPC))
    {
        NaviCabiClear(oPC);
        string sArea = GetLocalString(OBJECT_SELF, "EXIT_AREA");
        string sWaypoint = GetLocalString(OBJECT_SELF, "EXIT_WAYPOINT");
        NaviCabiEnter(oPC, sArea, sWaypoint);
    }
}
