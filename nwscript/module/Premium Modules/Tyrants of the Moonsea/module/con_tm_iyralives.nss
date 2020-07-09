//Is Iyrauroth alive?
#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("IyraurothDead") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
