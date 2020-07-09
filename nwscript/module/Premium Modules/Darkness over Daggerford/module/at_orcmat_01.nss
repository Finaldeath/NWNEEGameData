#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    GiveGoldToCreature(oPC, d6(3));
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
}
