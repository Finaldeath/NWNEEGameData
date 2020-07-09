//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script fo "Elf In Chains" Quest
//::       Status of Creel the slave Master
//::////////////////////////////////////////////////////
//:: Player blackmailed Creel without skill check
//:: (25,000 gp for all slaves)
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelCheckEquals("ElfInChains-Creel-Status", 3));
}
