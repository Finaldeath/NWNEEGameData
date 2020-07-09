// is the player's stronghold ready to be decorated?

#include "hf_in_plot"

int StartingConditional()
{
    return(PlotLevelGet("ks_yani") >= 2);
}
