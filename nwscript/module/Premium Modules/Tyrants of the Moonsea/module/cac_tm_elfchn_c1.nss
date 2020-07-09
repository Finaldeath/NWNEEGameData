//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script fo "Elf In Chains" Quest
//::////////////////////////////////////////////////////
//:: Player now knows about Creels whip marks (from Elf)
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    int nCurrentPlotLevel = PlotLevelGet("ElfInChains-Creel-Status");

    if (nCurrentPlotLevel < 1)
    {
        PlotLevelSet("ElfInChains-Creel-Status", 1);
        AddJournalQuestEntry("ElfinChains", 4, oPC);
    }
}
