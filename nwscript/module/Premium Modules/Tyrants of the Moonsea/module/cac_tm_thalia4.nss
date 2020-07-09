// sidequest: shadovar search party
// player has talked to thalia but maybe hasn't agreed to anything yet

#include "hf_in_plot"

void main()
{
    if (PlotLevelGet("Thalia") <= 0)
        PlotLevelSet("Thalia", 1);
}
