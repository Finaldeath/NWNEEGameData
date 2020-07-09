// returns true when PC has learned of Kur-Tharsu from Dukes of Daggerford
// and Tusk has not yet been met

#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("DukesOfDaggerFordDone") > 0 &&
       PlotLevelGet("Tusk") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
