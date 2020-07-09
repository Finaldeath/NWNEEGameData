//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script fo "Elf In Chains" Quest
//::////////////////////////////////////////////////////
//:: Player knows about Elf being a slave
//:: (either from Creel or by talking to Elf directly)
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelCheckEquals("ElfInChains-Status", 1));
}
