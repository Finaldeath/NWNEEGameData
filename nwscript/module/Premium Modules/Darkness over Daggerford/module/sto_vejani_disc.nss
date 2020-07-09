#include "nw_i0_plot"
#include "hf_in_util"
#include "rb_include"

void main()
{
    object oPC = GetPCSpeaker();
    string sTag = "store_" + GetTag(OBJECT_SELF);
    object oStore = GetObjectInArea(sTag, oPC);
    if(GetLocalInt(OBJECT_SELF, "iFavourable") == 0)
    {
        gplotAppraiseOpenStore(oStore, oPC);
    }
    else
    {
        AppraiseFavOpenStore(oStore, oPC, -10);
    }
}
