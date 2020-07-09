#include "hf_in_friend"

void main()
{
    object oPC = FriendGetMaster(OBJECT_SELF);
    if (GetIsObjectValid(oPC))
    {
        FriendDeath(OBJECT_SELF);
    }

    ExecuteScript("x2_def_ondeath", OBJECT_SELF);
}
