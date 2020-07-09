// the player fills a jar with piranhas from the pool in AR1800

#include "hf_in_plot"

void main()
{
    // flag that the player has filled a jar already
    string sTag = GetTag(OBJECT_SELF);
    PlotLevelSet(sTag, 1);

    // give the player a jar filled with fish
    object oPC = GetPCSpeaker();
    CreateItemOnObject("ks_it_piranhas", oPC, 1);
}
