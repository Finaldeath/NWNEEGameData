//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_innovate9
// DATE: February 27, 2006
// AUTH: Luke Scull
// NOTE: See below for detailed comments.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "cut_tm_arena_inc"

void main()
{
    object oDoor = OBJECT_INVALID;
    object oTarget = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    // Close and lock cell door.
    oDoor = GetObjectByTag(DOOR_TAG_CELL_INNER);
    AssignCommand(oDoor, ActionCloseDoor(OBJECT_SELF));
    AssignCommand(oDoor, SetLocked(OBJECT_SELF, TRUE));

    oDoor = GetObjectByTag(DOOR_TAG_CELL_OUTER);
    AssignCommand(oDoor, ActionCloseDoor(OBJECT_SELF));
    AssignCommand(oDoor, SetLocked(OBJECT_SELF, TRUE));

    // Jump Garth back into cell
    // Try getting nearest first, as there may be multiple
    // instances in the module    
    oTarget = GetNearestObjectByTag(NPC_TAG_GARTH, OBJECT_SELF);
    if (!GetIsObjectValid(oTarget))
        oTarget = GetObjectByTag(NPC_TAG_GARTH);    
    oWaypoint = GetObjectByTag(WP_TAG_GARTH_CELLS);
    AssignCommand(oTarget, JumpToObject(oWaypoint));

    // Jump Blizzard to safe location
    // Try getting nearest first, as there may be multiple
    // instances in the module
    oTarget = GetNearestObjectByTag(NPC_TAG_BLIZZARD, OBJECT_SELF);
    if (!GetIsObjectValid(oTarget))
        oTarget = GetObjectByTag(NPC_TAG_BLIZZARD);
    oWaypoint = GetObjectByTag(WP_TAG_BLIZZARD_OFFSCREEN);
    AssignCommand(oTarget, JumpToObject(oWaypoint));
}
