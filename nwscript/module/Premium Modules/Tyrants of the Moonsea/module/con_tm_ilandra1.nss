// pirates of the moonsea
// returns true when before the player has dealt with ilandra-as-a-pirate

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelGet("IlandraPirate") == 0);
}
