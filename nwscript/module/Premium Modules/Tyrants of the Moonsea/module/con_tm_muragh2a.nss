// returns true when the player has given muragh all ingredients

#include "hf_in_plot"

int StartingConditional()
{
    if (PlotLevelGet("MuraghMithril") < 10)
        return FALSE;
    if (PlotLevelGet("MuraghDiamond") < 2)
        return FALSE;
    if (PlotLevelGet("MuraghSapphire") < 1)
        return FALSE;
    return TRUE;
}
