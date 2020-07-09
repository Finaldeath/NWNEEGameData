// the player takes the ring from the dead fish in AR2100

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("ks_it_waterring", oPC, 1);
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
}
