//Check if Pirate Blockade is in progress (i.e. Orcus summoning cutscene complete)
#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("PirateBlockade") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
