//Has Jeffers told PC about Maganus?
#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("JeffersMaganus") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
