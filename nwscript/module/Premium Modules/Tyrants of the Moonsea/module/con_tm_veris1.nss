// sidequest: priates of the moonsea
// .. returns true when admiral meldonder's quest is active and veris has not given ring

#include "hf_in_plot"

int StartingConditional()
{
    if (PlotLevelGet("AdmiralMeldonder") == 2)
    {
        if (PlotLevelGet("Veris") < 2)
        {
            return TRUE;
        }
    }
    return FALSE;
}

