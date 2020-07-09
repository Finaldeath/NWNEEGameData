//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script for "Astar's Widow"
//::////////////////////////////////////////////////////
//:: Player now knows about Lana's location after
//:: speaking to Rikard.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    int nCurrentPlotLevel = PlotLevelGet("AstarsWidow-Status");

    if (nCurrentPlotLevel < 4)
        PlotLevelSet("AstarsWidow-Status", 4);

    AddJournalQuestEntry("AstarsWidow", 30, oPC);
}
