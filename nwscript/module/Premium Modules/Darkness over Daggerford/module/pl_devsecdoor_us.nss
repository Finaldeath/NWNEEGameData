// player uses a secret door and teleports to waypoint: LOC+<door tag>

#include "hf_in_npc"

void main()
{
    object oPC = GetLastUsedBy();

    if (!GetIsOpen(OBJECT_SELF))
    {
        // play animation of user opening it
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID));
        DelayCommand(1.0, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
    }
    else
    {
        // it's open -- go through and then close
        string sDest = "LOC_" + GetTag(OBJECT_SELF);
        TeleportToWaypoint(oPC, sDest);
        ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE);
    }
}
