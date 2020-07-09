//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_bghunt_v1
//:: DATE: January 10, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt - Vaporandir
//:: Shows Vaporandir the green dragon tongue
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string ITEM_REWARD = "item034";

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet("tm_cr_vaporandir0", 2); // For dialog branch
    PlotLevelSet("biggamehunt_status_vapo", 2); // Quest status only
    AddJournalQuestEntry("BigGameHunt-Vaporandir", 40, oPC);

    CreateItemOnObject(ITEM_REWARD, oPC, 1);
}
