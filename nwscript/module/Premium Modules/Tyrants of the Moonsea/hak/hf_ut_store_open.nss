// open the nearest store

#include "nw_i0_plot"
#include "x0_i0_common"

void main()
{
    object oPC = GetPCSpeaker();
    object oStore = GetNearestObject(OBJECT_TYPE_STORE);
    if (GetIsObjectValid(oStore) == TRUE)
    {
        int nAdjust = GetLocalInt(OBJECT_SELF, "HF_STORE_PRICE_ADJUST");
        gplotAppraiseOpenStore(oStore, oPC, -nAdjust, nAdjust);
    }
    else
    {
        PlayVoiceChat(VOICE_CHAT_CUSS);
    }
}

