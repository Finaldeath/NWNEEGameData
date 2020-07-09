// B W-Husey
// October 2005
// Any dialogue that opens a wizard store

#include "nw_i0_plot"
void main()
{
    object oStore = GetNearestObjectByTag("WizardStore");
    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
