// player removes a bag of dirt from the generator

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("ks_it_dirtbag", oPC, 1);
    PlaySound("it_materialsoft");
    PlotLevelSet(GetTag(OBJECT_SELF), 0);
}
