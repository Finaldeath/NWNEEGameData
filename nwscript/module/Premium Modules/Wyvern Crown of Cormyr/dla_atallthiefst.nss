// B W-Husey
// October 2005
// Opens Alice's thief store (it's a knock shop, so there's an alignment hit)

#include "nw_i0_plot"
#include "cu_functions"
void main()
{
    object oStore = GetNearestObjectByTag("ThiefStore");
    object oPC = GetPCSpeaker();
    AligXP("sAligThiefStoreXP",oPC,"CHAOTIC",25,1);
    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
