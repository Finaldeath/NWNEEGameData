//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script for "Astar's Widow"
//::////////////////////////////////////////////////////
//:: PC talked to Lana and may or may not have
//:: given her the letter.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string ITM_TAG_ASTARSLETTER = "AstarsLetter";
const string ITM_RESREF_ASTARSLETTER = "item014";

const string ITM_RESREF_ASTARSRING = "it_tm_astar_ring";

void main()
{
    object oPC = GetPCSpeaker();
    object oLana = OBJECT_SELF;
    int nGivenLetter = GetLocalInt(oLana, "HF_ARG");
    int nCurrentPlotLevel = PlotLevelGet("AstarsWidow-Status");
    
    // Set dialog branch for Lana
    PlotLevelSet(GetTag(oLana), 2);
    
    //Set quest Status    
    if (nCurrentPlotLevel < 5)
    {
        PlotLevelSet("AstarsWidow-Status", 5);
        if (nGivenLetter)
        {
            AddJournalQuestEntry("AstarsWidow", 50, oPC);
            
            // Get by tag, player doesn't actually need to have the letter in inventory
            // Quest status is tracked by variable.
            object oLetter = GetObjectByTag(ITM_TAG_ASTARSLETTER);
            if (GetIsObjectValid(oLetter))
            {
                DestroyObject(oLetter);
            }
        }
        else
        {
            AddJournalQuestEntry("AstarsWidow", 60, oPC);
        }
    }

    // PC gets Lana's wedding ring
    CreateItemOnObject(ITM_RESREF_ASTARSRING, oPC);
}
