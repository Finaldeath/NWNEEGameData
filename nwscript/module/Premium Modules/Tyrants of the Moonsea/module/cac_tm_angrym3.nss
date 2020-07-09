// returns true when angrym can sell horses to the player

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelGet("DukesOfDaggerFordDone") > 0);
}
