//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script for "Astars Widow"
//::////////////////////////////////////////////////////
//:: Checks whether the PC knows about Lana living
//:: in the Zhent Quarter from Rikard.
//:: Used to determine if PC can ask about the exact
//:: location in:
//:: - Old Jeffers dialog
//:: - Sylar dialog
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    int nCurrentPlotLevel = PlotLevelGet("AstarsWidow-Status");

    return (nCurrentPlotLevel == 4);
}
