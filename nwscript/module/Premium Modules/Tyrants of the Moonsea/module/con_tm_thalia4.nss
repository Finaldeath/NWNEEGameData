// sidequest: shadovar search party
// player has been to kur-tharsu and learned that dominion was a fake (after magnus battle)
// AND has not already spoken with thalia about this quest

#include "hf_in_plot"

int StartingConditional()
{
    if (PlotLevelGet("StrongholdMaganus") >= 3)
    {
        if (PlotLevelGet("Thalia") < 2)
        {
            return TRUE;
        }
    }
    return FALSE;
}
