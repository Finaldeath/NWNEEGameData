//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script for "Astars Widow"
//::////////////////////////////////////////////////////
//:: PC has talked to Lana, can try to stop
//:: Rikard from gambling
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelCheckEquals("AstarsWidow-Status", 5));
}
