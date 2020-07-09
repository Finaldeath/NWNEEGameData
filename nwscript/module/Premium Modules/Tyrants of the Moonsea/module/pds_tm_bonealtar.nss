//Create Aumvor's Amulet if Large Bone or Skeleton's Knuckle placed in altar

#include "hf_in_plot"

void main()
{
    int nType = GetInventoryDisturbType();

    object oItem = GetInventoryDisturbItem();
    object oPC =  GetLastDisturbed();

    if(PlotLevelGet(GetTag(OBJECT_SELF)) == 0 && nType == INVENTORY_DISTURB_TYPE_ADDED)
    {
        if(GetTag(oItem) == "x2_it_cmat_bone" ||
           GetTag(oItem) == "NW_IT_MSMLMISC13")
        {
            effect eHarm = EffectVisualEffect(VFX_IMP_HARM);
            effect eSkel = EffectVisualEffect(VFX_IMP_RAISE_DEAD);

            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHarm, OBJECT_SELF);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eSkel, oPC);
            CreateItemOnObject("amuletofaumvor", OBJECT_SELF);
            DestroyObject(oItem);
            PlotLevelSet(GetTag(OBJECT_SELF), 1);
        }
    }
}
