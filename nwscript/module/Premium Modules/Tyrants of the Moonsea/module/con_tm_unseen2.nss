//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_unseen2
//:: DATE: January 24, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: The Unseen
//:: Checks whether the quest "A Merchant's tale"
//:: has been finished.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    return (PlotLevelCheckEquals("amerchantstale_status", 5));
}
