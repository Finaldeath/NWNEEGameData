//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Checks Blizzards attitude towards PC
//::////////////////////////////////////////////////////
//:: Blizzard was left alive during arena, but player
//:: was hostile in dialogs
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelCheckEquals("Blizzard-Arena-Outcome", 1));
}
