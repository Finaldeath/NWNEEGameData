//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script for "Astar's Widow"
//::////////////////////////////////////////////////////
//:: Player now knows about Rikard after
//:: speaking to Chesslyn.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    int nCurrentPlotLevel = PlotLevelGet("AstarsWidow-Status");
    
    if (nCurrentPlotLevel < 3)
    {
        PlotLevelSet("AstarsWidow-Status", 3);
        AddJournalQuestEntry("AstarsWidow", 20, oPC);
    }
}
