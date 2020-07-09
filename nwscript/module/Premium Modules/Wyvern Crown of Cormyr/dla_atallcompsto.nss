// B W-Husey
// October 2005
// Opens Alice's component store (it's a knock shop, so there's an alignment hit)

#include "nw_i0_plot"
#include "cu_functions"
void main()
{
    object oStore = GetNearestObjectByTag("CompStore");
    object oPC = GetPCSpeaker();
    AligXP("sAligCompStoreXP",oPC,"CHAOTIC",25,2);
    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
