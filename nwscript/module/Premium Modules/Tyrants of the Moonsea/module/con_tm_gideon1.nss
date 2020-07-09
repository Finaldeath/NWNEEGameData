// returns true when the player knows that the shadovar are searching the ruins

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelGet("MoavartheInnkeep") >= 2);
}
