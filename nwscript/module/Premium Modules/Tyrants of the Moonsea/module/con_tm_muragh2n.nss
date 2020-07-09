// returns true when the player has not given muragh all ingredients

#include "hf_in_plot"

int StartingConditional()
{
    if (PlotLevelGet("MuraghMithril") < 10)
        return TRUE;
    if (PlotLevelGet("MuraghDiamond") < 2)
        return TRUE;
    if (PlotLevelGet("MuraghSapphire") < 1)
        return TRUE;
    return FALSE;
}
