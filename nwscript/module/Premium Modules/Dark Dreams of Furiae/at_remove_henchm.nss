#include "ddf_util"

void main()
{
    object oNPC = GetMaster(OBJECT_SELF);
    object oPC = GetPCSpeaker();

    RemoveHenchperson(OBJECT_SELF);
    // teleport OBJECT_SELF (Luicil to FOVOR shop...)

    string sWaypointName = GetLocalString(OBJECT_SELF, "unhench_spawnpoint");

    object waypoint;
    if(sWaypointName == "")
    {
        waypoint = GetWaypointByTag("SpawnLuicil");
    }
    else
    {
        waypoint = GetWaypointByTag(sWaypointName);
    }

    //AssignCommand(OBJECT_SELF, ActionJumpToObject(waypoint));
    AssignCommand(OBJECT_SELF, ActionForceMoveToObject(waypoint, FALSE, 1.0f, 3.0f));
}
