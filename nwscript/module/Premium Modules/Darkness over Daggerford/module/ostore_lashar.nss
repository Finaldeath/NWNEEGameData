// This is a generic open store script that works for any vendor where the
// tag of the shopkeep is associated with the tag of the store.

#include "nw_i0_plot"
#include "hf_in_util"
#include "rb_include"

void main()
{
    object oPC = GetPCSpeaker();
    string sTag = "store_" + GetTag(OBJECT_SELF);
    object oStore = GetObjectByTag(sTag);
    if(GetLocalInt(OBJECT_SELF, "iFavourable") == 0)
    {
        gplotAppraiseOpenStore(oStore, oPC);
    }
    else
    {
        AppraiseFavOpenStore(oStore, oPC);
    }
}
