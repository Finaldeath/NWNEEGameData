// has player spoken with feynemonee?

#include "hf_in_plot"

int StartingConditional()
{
    return(PlotLevelGet("ks_feynemonee") >= 1);
}
