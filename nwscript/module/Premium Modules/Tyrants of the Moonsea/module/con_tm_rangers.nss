#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("ElmwoodRangers") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
