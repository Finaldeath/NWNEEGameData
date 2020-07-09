// sidequest: priates of the moonsea
// .. returns true when admiral meldonder's quest is active

#include "hf_in_plot"

int StartingConditional()
{
    if (PlotLevelGet("Dryden") == 1)
    {
        return (PlotLevelGet("AdmiralMeldonder") == 2);
    }
    return FALSE;
}
