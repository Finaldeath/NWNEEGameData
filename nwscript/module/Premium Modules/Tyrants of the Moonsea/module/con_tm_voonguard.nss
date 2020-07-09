// returns true when PC has fought off demon attack in Voonlar

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelGet("VoonlarGuards") > 0);
}
