//Has Ulblyn not yet told PC about Dukes?
#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("UlblynDukes") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
