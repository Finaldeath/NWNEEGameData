// sidequest: priates of the moonsea
// .. returns true when admiral meldonder's quest is active

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelGet("AdmiralMeldonder") == 2);
}
