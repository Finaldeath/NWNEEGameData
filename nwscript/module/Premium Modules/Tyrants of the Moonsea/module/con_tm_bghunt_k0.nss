//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_bghunt_k0
//:: DATE: January 10, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt - Karim Ninetree
//:: Returns true when the Big Game Hunt quest is active
//:: but the player hasn't agreed to fetch the bear pelt
//:. yet.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    return ( (PlotLevelGet("biggamehunt_status_main") == 1) &&
             (PlotLevelGet("biggamehunt_status_were") == 0) );
}

