//::///////////////////////////////////////////////
//:: FileName con_ac_mazeconvo
//:: Jonas Sr. now starts maze convo
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 3:25:02 PM
//:://////////////////////////////////////////////

void main()
{
    object oJonas = GetObjectByTag("ac_jonas1");
    object oJunior = GetObjectByTag("ac_jonas2");
    object oJonasWaypoint = GetWaypointByTag("wp_jonas_maze");
    object oJuniorWaypoint = GetWaypointByTag("wp_junior_maze");
    object oPC = GetPCSpeaker();
    object oPrisonDoor = GetObjectByTag("maze_prison_pc");

    AssignCommand(oJonas, ClearAllActions());
    AssignCommand(oJunior, ClearAllActions());
    AssignCommand(oJonas, ActionJumpToObject(oJonasWaypoint));
    AssignCommand(oJunior, ActionJumpToObject(oJuniorWaypoint));

    AssignCommand(oPC, SetLocked(oPrisonDoor, FALSE));
    AssignCommand(oPC, SetCameraFacing(DIRECTION_SOUTH, 15.0, -1.0, CAMERA_TRANSITION_TYPE_FAST));
    AssignCommand(oPC, SetFacing(DIRECTION_SOUTH));

    AssignCommand(oJonas, ActionOpenDoor(oPrisonDoor));
    AssignCommand(oJonas, ActionWait(2.5));
    AssignCommand(oJonas, ActionStartConversation(oPC));
}
