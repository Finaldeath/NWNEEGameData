//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_thayanam3
//:: DATE: January 30, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Thayan Ambassadors
//:: Returns true, when the golem battle is in progress
//:: (plot status = 3)
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelCheckEquals("thayanam_status", 3));
}

