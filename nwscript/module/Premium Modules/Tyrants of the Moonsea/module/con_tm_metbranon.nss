//Has PC talked with the druid Branon in Hillsfar?
#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("BranonOakheart") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
