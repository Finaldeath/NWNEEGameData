// random beacon inn patron line before bale goes all hostile

#include "hf_in_plot"

int StartingConditional()
{
    if (PlotLevelGet("Bale") >= 3) return FALSE;
    return (d2() == 1);
}
