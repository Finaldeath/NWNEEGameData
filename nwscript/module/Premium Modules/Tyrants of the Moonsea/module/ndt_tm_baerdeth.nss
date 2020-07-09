//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ndt_tm_baerdeth
//:: DATE: January 09, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt - Main (Baerdeth)
//:: Death script for Huntsmaster Baerdeth.
//:: Finishes quest.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetFirstPC();

    AddJournalQuestEntry("BigGameHunt", 130, oPC, TRUE, FALSE, FALSE);
    PlotLevelSet("biggamehunt_status_main", 3);

    GiveXPToCreature(oPC, GetJournalQuestExperience("BigGameHunt"));

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
