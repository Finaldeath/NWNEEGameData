// returns true after gideon tells the player that bale has changed

#include "hf_in_plot"

int StartingConditional()
{
    return PlotLevelGet("Gideon") >= 2;
}
