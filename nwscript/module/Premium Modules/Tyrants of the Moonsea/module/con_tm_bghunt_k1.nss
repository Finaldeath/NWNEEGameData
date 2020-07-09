//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_bghunt_k1
//:: DATE: January 13, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt - Karim Ninetrees
//:: Returns true when the player carries a bear pelt
//:: and has started, but not finished the quest yet.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string ITM_TAG_BEAR_PELT = "tm_it_bearpelt0";

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oPelt = GetItemPossessedBy(oPC, ITM_TAG_BEAR_PELT);

    return ( GetIsObjectValid(oPelt) &&
             PlotLevelCheckEquals("biggamehunt_status_main", 1) &&
             (PlotLevelGet("biggamehunt_status_were") < 2) );
}
