// tatham will sell players druid goods at good prices

#include "nw_i0_plot"

void main()
{
    object oStore = GetNearestObjectByTag("STO_TATHAM");
    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
