//Has PC discovered Ezril's body?
#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("Ezril") == 5)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
