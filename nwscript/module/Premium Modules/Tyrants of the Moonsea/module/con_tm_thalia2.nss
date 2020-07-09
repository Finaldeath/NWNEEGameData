// sidequest: shadovar search party
// player knows the location of dominion in thar (as told by the dukes)

#include "hf_in_plot"

int StartingConditional()
{
    int nDukes = PlotLevelGet("DukesOfDaggerFordDone");
    if (nDukes > 0)
        return TRUE;
    return FALSE;
}
