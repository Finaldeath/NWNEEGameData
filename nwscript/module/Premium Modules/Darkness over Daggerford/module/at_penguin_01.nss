// penguin tells player to free her (get key from Nagnorm)

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    PlotLevelSet("ks_nagnorm", 2);
}
