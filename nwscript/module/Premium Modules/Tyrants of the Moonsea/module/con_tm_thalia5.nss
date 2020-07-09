// sidequest: shadovar search party
// player hasn't been to kur-tharsu yet (before magnus battle)

#include "hf_in_plot"

int StartingConditional()
{
    if (PlotLevelGet("StrongholdMaganus") < 3)
    {
        return TRUE;
    }
    return FALSE;
}
