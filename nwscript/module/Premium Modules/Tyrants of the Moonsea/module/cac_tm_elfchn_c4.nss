//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script fo "Elf In Chains" Quest
//::////////////////////////////////////////////////////
//:: Player blackmails Creel, but fails skill check
//:: (50,000 gp for all slaves)
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    int nCurrentPlotLevel = PlotLevelGet("ElfInChains-Creel-Status");
    
    if (nCurrentPlotLevel < 4)
    {
        PlotLevelSet("ElfInChains-Creel-Status", 4);
    } 
}
