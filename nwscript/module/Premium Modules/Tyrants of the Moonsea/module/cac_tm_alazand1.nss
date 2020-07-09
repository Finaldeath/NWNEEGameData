// the Dukes of Daggerford kindly reveal the last 3 world map areas in Thar
// after this point, the player can buy horses in thentia

#include "hf_in_worldmap"
#include "hf_in_plot"

void main()
{
    RevealMapLocation("TharScar");
    RevealMapLocation("TharIyrath");
    RevealMapLocation("TharKurSMG");
    PlotLevelSet("DukesOfDaggerFordDone", 1);
}
