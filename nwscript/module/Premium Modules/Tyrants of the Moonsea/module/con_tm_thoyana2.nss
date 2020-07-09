//Has PC resolved murder for Thoyana?

#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("Thoyana") == 2)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
