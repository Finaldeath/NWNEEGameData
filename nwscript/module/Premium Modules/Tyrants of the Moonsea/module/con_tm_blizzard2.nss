//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Checks Blizzards attitude towards PC
//::////////////////////////////////////////////////////
//:: Blizzard was killed during arena
//:: (but subsequently ressurected)
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelCheckEquals("Blizzard-Arena-Outcome", 2));
}
