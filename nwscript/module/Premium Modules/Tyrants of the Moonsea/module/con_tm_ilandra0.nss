// pirates of the moonsea
// player has the quest and has not settle with ilandra yet

#include "hf_in_plot"

int StartingConditional()
{
    if (PlotLevelGet("AdmiralMeldonder") == 2)
    {
        if (PlotLevelGet("IlandraPirate") == 0)
        {
            return TRUE;
        }
    }
    return FALSE;
}

