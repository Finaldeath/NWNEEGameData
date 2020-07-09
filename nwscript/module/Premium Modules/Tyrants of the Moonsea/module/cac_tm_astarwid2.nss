//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script for "Astar's Widow"
//::////////////////////////////////////////////////////
//:: Player receives Astars Letter from Lyressa.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string ITM_TAG_ASTARSLETTER = "AstarsLetter";
const string ITM_RESREF_ASTARSLETTER = "item014";

void main()
{
    object oPC = GetPCSpeaker();
    int nCurrentPlotLevel = PlotLevelGet("AstarsWidow-Status");
    
    if (nCurrentPlotLevel < 2)
    {
        PlotLevelSet("AstarsWidow-Status", 2);   
        AddJournalQuestEntry("AstarsWidow", 10, oPC);
        CreateItemOnObject(ITM_RESREF_ASTARSLETTER, oPC);
    }
    
}
