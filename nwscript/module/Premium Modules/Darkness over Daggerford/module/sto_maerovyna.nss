#include "nw_i0_plot"
#include "rb_test_store"
void main()
{
    object oStore = GetNearestObjectByTag("pm_maerovyna");
    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
