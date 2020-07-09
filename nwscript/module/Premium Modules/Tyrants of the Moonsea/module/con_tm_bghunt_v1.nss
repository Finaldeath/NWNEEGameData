//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_bghunt_v1
//:: DATE: January 10, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Bug Game Hunt - Vaporandir
//:: Returns true when the player has agreed to fool
//:: Baedeth and carries the tongue of a green dragon
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string ITM_TAG_FAKE_TONGUE = "tm_it_vaptongue1";

int StartingConditional()
{
    return (GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(), ITM_TAG_FAKE_TONGUE)) &&
            PlotLevelCheckEquals("biggamehunt_status_vapo", 1));
}
