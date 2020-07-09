// the player stuffed a bag of dirt in the generator

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oDirt = GetItemPossessedBy(oPC, "ks_it_dirtbag");
    DestroyObject(oDirt);
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    PlaySound("it_materialsoft");
}
