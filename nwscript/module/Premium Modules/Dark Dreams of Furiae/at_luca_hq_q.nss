#include "ddf_util"

void main()
{
    // Set the flag that quill is in jail
    SetLocalInt(GetModule(), "ddf_quill_in_jail", TRUE);

    // Remove Quill as a henchman
    object oQuill = GetObjectByTag("DDF_NPC_Quillian");
    RemoveHenchperson(oQuill);

    // Teleport Quill
    object oWaypoint = GetObjectByTag("QuillianJailed");
    if(GetIsObjectValid(oWaypoint))
    {
        debug("-- trying to teleport quill to jail...");
        AssignCommand(oQuill, ClearAllActions());
        AssignCommand(oQuill, JumpToObject(oWaypoint, FALSE));
    }
    else
    {
        debug("!! Unable to find `QuillianJailed` waypoint by tag...");
    }

    // COPIED FROM AT_LUCA_HQ

    // Conversed with player
    SetLocalInt(GetModule(), "luce_001_done", TRUE);


    if(GetCurrentArea(GetPCSpeaker()) == AREA_GUARD_POST) return;

    // Walk towards the first waypoint
    object oMoveWaypoint = GetWaypointByTag("path_to_guardhq_02");
    ActionMoveToObject(oMoveWaypoint);

    // After a certain amount of time, teleport into the HQ
    object oTeleportWaypoint = GetWaypointByTag("GuardHQ_Lucenna");
    location locTeleportWP = GetLocation( oTeleportWaypoint );
    DelayCommand(5.0, ActionJumpToLocation(locTeleportWP));

}
