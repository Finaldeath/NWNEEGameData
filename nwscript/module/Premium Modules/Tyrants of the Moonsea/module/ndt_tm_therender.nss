//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ndt_tm_therender
//:: DATE: January 09, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt - The Render
//:: OnDeath script for the Render.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetFirstPC();

    AddJournalQuestEntry("BigGameHunt-Render", 20, oPC, TRUE, FALSE, FALSE);
    PlotLevelSet("biggamehunt_status_rend", 2);

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
