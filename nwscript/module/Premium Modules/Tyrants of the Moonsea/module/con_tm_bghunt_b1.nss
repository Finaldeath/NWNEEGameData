//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_bghunt_b1
//:: DATE: January 10, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Bug Game Hunt - Baerdeth
//:: Returns true when the quest was accepted, but the
//:: targets haven't been caught yet.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelCheckEquals("biggamehunt_status_main", 1));
}
