//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script fo "Elf In Chains" Quest
//::////////////////////////////////////////////////////
//:: Player blackmails Creel succesfully
//:: (Slaves freed at no cost, also ends quest)
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    int nCurrentPlotLevel = PlotLevelGet("ElfInChains-Creel-Status");
    
    if (nCurrentPlotLevel < 5)
    {
        PlotLevelSet("ElfInChains-Creel-Status", 5);
    }     

}
