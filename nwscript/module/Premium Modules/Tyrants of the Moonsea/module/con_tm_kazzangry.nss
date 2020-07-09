//Has Kazz-Temmet been angered by the player

#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("KazzAngered") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
