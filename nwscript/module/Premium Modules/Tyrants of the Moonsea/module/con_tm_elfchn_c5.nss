//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script fo "Elf In Chains" Quest
//::       Status of Creel the slave Master
//::////////////////////////////////////////////////////
//:: Player blackmailed Creel succesfully
//:: (Slaves freed at no cost, quest finished
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelCheckEquals("ElfInChains-Creel-Status", 5));
}
