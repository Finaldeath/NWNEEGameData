// area transition for areas within the same area
// .. fixes the silly henchmen don't follow bug

#include "hf_in_npc"

void main()
{
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);

    if (GetIsPC(oClicker))
    {
        TeleportToObject(oClicker, oTarget, TRUE);
    }
}
