// October 2005
// B W-Husey
// Generic store open script for tavern stores.

#include "nw_i0_plot"
void main()
{
    object oStore = GetNearestObjectByTag("TavernStore");
    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
