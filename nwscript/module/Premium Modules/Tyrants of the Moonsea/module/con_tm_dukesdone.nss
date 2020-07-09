// returns true when PC has learned of Kur-Tharsu from Dukes of Daggerford

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelGet("DukesOfDaggerFordDone") > 0);
}
