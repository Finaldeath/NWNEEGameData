//Is Varda dead?

#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("Valda") == 3)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
