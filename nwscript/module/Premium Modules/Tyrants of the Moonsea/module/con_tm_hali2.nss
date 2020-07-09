//Has Captain Haliator been left to kill Merrik?

#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("MerrikExecution") == 2)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
