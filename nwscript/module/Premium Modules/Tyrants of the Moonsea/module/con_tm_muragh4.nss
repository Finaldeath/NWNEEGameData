// returns true when the player knows about kur-tharsu

#include "hf_in_plot"

int StartingConditional()
{
    int nDukes = PlotLevelGet("DukesOfDaggerFordDone");
    if (nDukes > 0)
        return TRUE;
    return FALSE;
}
