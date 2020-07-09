//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script fo "Elf In Chains" Quest
//::       Status of Creel the slave Master
//::////////////////////////////////////////////////////
//:: Player has incriminating evidence on Creel
//:: (from Suzildara)
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelCheckEquals("ElfInChains-Creel-Status", 2));
}
