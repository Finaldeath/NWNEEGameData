//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script fo "Elf In Chains" Quest
//::////////////////////////////////////////////////////
//:: Player knows Elf can't be bought without buying
//:: the other slaves as well
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelCheckEquals("ElfInChains-Status", 2));
}
