// after killing the 4 fowls, stegil will sell goods to the player

#include "nw_i0_plot"

void main()
{
    object oStore = GetNearestObjectByTag("STO_STEGIL");
    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
