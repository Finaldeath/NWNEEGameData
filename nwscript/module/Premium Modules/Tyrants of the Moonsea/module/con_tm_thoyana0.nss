//Has Thoyana told PC to talk with Enrad and Alamarayne?

#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("Thoyana") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
