//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script fo "Elf In Chains" Quest
//::       Status of Creel the slave Master
//::////////////////////////////////////////////////////
//:: Player blackmailed Creel, but failed skill check
//:: (50,000 gp for all slaves)
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelCheckEquals("ElfInChains-Creel-Status", 4));
}
