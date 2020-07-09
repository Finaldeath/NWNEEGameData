#include "hf_in_plot"

void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 400);
    PlotLevelSet(GetTag(OBJECT_SELF), 3);
}
