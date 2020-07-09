//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script for "Astars Widow"
//::////////////////////////////////////////////////////
//:: Astar is dead, Player can receive Astars Letter
//:: in Lyressa's conversation
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelCheckEquals("AstarsWidow-Status", 1));
}
