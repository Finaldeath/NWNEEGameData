#include "hf_in_npc"

void main()
{
    object oClicker=GetClickingObject();
    object oTarget=GetTransitionTarget(OBJECT_SELF);

    TeleportToObject(oClicker, oTarget);
}
