#include "hf_in_plot"

int StartingConditional()
{
    if((GetLocalInt(GetModule(), "nXatuumKilled") == 0) &&
       PlotLevelGet("ks_xatuum") > 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
