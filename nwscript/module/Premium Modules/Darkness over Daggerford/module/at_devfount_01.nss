// player used oil on the fountain and started it

#include "hf_in_plot"

void main()
{
    object oSnd = GetNearestObjectByTag("ks_snd_fountain");
    SoundObjectPlay(oSnd);
    PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
}
