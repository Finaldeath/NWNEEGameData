//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_unseen5
//:: DATE: January 24, 2019
//:: AUTHOR: Rich Barker
//::////////////////////////////////////////////////////
//:: Quest: The Unseen
//:: Checks whether the PC has completed the quest
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelCheckEquals("theunseen_status", 5));
}
