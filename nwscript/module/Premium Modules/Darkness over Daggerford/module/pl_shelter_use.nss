// the player has used the secure shelter doorway

#include "hf_in_npc"

void main()
{
    object oPC = GetLastUsedBy();

    if (GetIsPC(oPC))
    {
        if (!GetIsOpen(OBJECT_SELF))
        {
            // play animation of user opening it
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID));
            DelayCommand(1.0, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
        }
        else
        {
            // it's open -- go through
            AssignCommand(oPC, PlaySound("as_mg_telepout1"));
            TeleportToWaypoint(oPC, "WP_AR0090_SHELTER", TRUE);
        }
    }
}
