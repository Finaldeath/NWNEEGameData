// the player uses the door to exit the secure shelter

#include "hf_in_npc"

void main()
{
    object oClicker = GetClickingObject();

    if (GetIsPC(oClicker))
    {
        object oDoor = GetObjectByTag("ks_pl_shelter");
        TeleportToObject(oClicker, oDoor, TRUE);
        DestroyObject(oDoor, 3.0);

        DelayCommand(2.0, ActionCloseDoor(OBJECT_SELF));
    }
}
