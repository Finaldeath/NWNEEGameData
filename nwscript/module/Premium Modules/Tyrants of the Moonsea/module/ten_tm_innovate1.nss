//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_innovate1
// DATE: February 21, 2006
// AUTH: Luke Scull
// NOTE: Innovator of Pain starts conversation with PC.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "cut_tm_arena_inc"

void main()
{
    object oPC = GetEnteringObject();
    object oDoor = OBJECT_INVALID;
    object oTarget = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    if (GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "fired") == 0))
    {
        SetLocalInt(OBJECT_SELF, "fired", 1);

        // Close and lock cell door.
        oDoor = GetObjectByTag(DOOR_TAG_CELL_INNER);
        AssignCommand(oDoor, ActionCloseDoor(OBJECT_SELF));
        AssignCommand(oDoor, SetLocked(OBJECT_SELF, TRUE));

        oDoor = GetObjectByTag(DOOR_TAG_CELL_OUTER);
        AssignCommand(oDoor, ActionCloseDoor(OBJECT_SELF));
        AssignCommand(oDoor, SetLocked(OBJECT_SELF, TRUE));

        // Briefly stun player and have Innovator of Pain initiate dialog.
        oTarget = GetNearestObjectByTag(NPC_TAG_INNOVATOR, oPC);
        if (!GetIsObjectValid(oTarget))
            oTarget = GetObjectByTag(NPC_TAG_INNOVATOR);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oPC, 6.0);
        AssignCommand(oTarget, ActionForceMoveToObject(oPC));
        AssignCommand(oTarget, ActionStartConversation(oPC, ""));

        // Jump Father Garth to non-accesible area.
        oTarget = GetNearestObjectByTag(NPC_TAG_GARTH, oPC);
        if (!GetIsObjectValid(oTarget))
            oTarget = GetObjectByTag(NPC_TAG_GARTH);
        oWaypoint = GetObjectByTag(WP_TAG_GARTH_OFFSCREEN);
        AssignCommand(oTarget, JumpToObject(oWaypoint));
    }
}
