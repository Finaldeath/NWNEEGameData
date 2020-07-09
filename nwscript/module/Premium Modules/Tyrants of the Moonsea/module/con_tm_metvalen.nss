//Has PC talked with Valen about Ezril's animal companions
#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("Valen") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
