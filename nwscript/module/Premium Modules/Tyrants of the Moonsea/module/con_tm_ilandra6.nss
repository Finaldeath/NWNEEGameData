//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_ilandra6
//:: DATE: March14, 2019
//::////////////////////////////////////////////////////
//:: Returns true when all quest involving Ilandra have
//;: been finished.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    int nPlotElfInChains = PlotLevelGet("ElfInChains-Status");  // >= 4
    int nPlotPirates     = PlotLevelGet("IlandraPirate"); // >= 5

    return ( (nPlotElfInChains >= 4) && (nPlotPirates >= 5) );
}
