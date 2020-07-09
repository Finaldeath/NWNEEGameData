//Has Jeffers not yet told PC about Maganus?
#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("JeffersMaganus") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
