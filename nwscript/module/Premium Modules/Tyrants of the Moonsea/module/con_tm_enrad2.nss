//Has Enrad told PC about Ezril's relationship with Elanawen?

#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("Enrad") == 2)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
