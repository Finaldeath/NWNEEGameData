//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_unseen3
//:: DATE: January 24, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: The Unseen
//:: Checks whether the PC known about the password to
//:: the Melvaunt warehouse.
//:: Set by picking up the note in Laris Curios.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int StartingConditional()
{
    object oMissive = GetItemPossessedBy(GetPCSpeaker(), "tag_tm_hlaavinm0");

    return ((PlotLevelGet("theunseen_status") >= 3) || GetIsObjectValid(oMissive));
}
