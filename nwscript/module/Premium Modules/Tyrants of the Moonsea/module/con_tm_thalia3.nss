// sidequest: shadovar search party
// player has learned about fake dominion in kur-tharsu (after magnus battle)

#include "hf_in_plot"

int StartingConditional()
{
    if (PlotLevelGet("StrongholdMaganus") >= 3)
        return TRUE;
    return FALSE;
}
