//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_grazdead
// DATE: November 9, 2005
// AUTH: Luke Scull
// NOTE: Appears if player has just killed Grazkahn
//       after agreeing to.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("Grazkahn") == 4)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
