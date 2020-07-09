//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script fo "Elf In Chains" Quest
//::////////////////////////////////////////////////////
//:: Player blackmails Creel without skill check
//:: (25,000 gp for all slaves)
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    int nCurrentPlotLevel = PlotLevelGet("ElfInChains-Creel-Status");
    
    if (nCurrentPlotLevel < 3)
    {
        PlotLevelSet("ElfInChains-Creel-Status", 3);
    }    
}
