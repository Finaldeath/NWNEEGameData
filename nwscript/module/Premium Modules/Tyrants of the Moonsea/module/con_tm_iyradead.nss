//Is Iyrauroth dead?
#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("IyraurothDead") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
