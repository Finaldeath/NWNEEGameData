// returns true if the "resistance army" is still around in the beacon inn

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelGet("Bale") < 3);
}
