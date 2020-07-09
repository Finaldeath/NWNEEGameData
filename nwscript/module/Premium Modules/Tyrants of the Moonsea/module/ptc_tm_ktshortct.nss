//Transition Player through Kur-Tharsu Upper Ground shortcut

#include "hf_in_npc"

void main()
{
    object oClicker=GetClickingObject();
    object oTarget=GetTransitionTarget(OBJECT_SELF);

     // move the player
    TeleportToObject(oClicker, oTarget);
}
