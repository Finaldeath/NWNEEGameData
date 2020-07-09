//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Checks Blizzards attitude towards PC
//::////////////////////////////////////////////////////
//:: Blizzard was left alive during arena and departed
//:: on friendly terms
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelCheckEquals("Blizzard-Arena-Outcome", 0));
}
