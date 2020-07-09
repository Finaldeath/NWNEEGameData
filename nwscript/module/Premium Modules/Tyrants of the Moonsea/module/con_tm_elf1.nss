//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Checks Hillsfar arena outcome for Elf
//::////////////////////////////////////////////////////
//:: Elf was killed during arena sequence 4
//:: No matter whether in combat or the player cchose to
//:: buff himself (over healing Elf)
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelCheckEquals("Elf-Arena-Outcome", 1));
}
