// returns true when PC has learned of Kur-Tharsu from Dukes of Daggerford
// and Kur-Tharsu gate has not yet been breached

#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("DukesOfDaggerFordDone") > 0 &&
       PlotLevelGet("KTGateDestroyed") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
