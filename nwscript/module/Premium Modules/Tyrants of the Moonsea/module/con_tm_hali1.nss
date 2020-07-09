//Has Captain Haliator been told to kill Merrik?

#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("MerrikExecution") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
