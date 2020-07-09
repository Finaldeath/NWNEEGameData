//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_bghunt_k1
//:: DATE: January 13, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt - Karim Ninetrees
//:: PC accepts Karim's suggestions to fool
//:: Baerdeth with the a bear pelt
//:: This will activate an encounter to make sure
//:: a bear pelt is actually available
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet("biggamehunt_status_were", 1);
    AddJournalQuestEntry("BigGameHunt-Werebear", 30, oPC);

    object oBearEncounter = GetObjectByTag("ENC_corm_misty_cavebear");
    SetEncounterActive(TRUE, oBearEncounter);
}
