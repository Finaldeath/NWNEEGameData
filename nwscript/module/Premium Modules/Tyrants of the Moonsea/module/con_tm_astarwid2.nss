//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script for "Astars Widow"
//::////////////////////////////////////////////////////
//:: Player hasn't spoken to Lana or Rikard yet.
//:: Used in Chesslyn dialog ("tm_chesslyn") to
//:: determine whether the PC can ask about Lana
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    int nPlotLevel = PlotLevelGet("AstarsWidow-Status");

    return (nPlotLevel < 4);
}
