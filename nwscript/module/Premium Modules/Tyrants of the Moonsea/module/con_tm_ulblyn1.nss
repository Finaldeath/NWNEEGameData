//Has Ulblyn told PC about Dukes?
#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("UlblynDukes") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
