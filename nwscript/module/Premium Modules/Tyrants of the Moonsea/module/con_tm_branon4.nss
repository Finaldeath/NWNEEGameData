// returns true when the player has the "figure of wonderous power" item
// this item can be found via a search check at a specific place in elventree

#include "hf_in_plot"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (PlotLevelGet("Branon_Secret") > 0)
        return FALSE;
    object oItem = GetItemPossessedBy(oPC, "animalfigure1");
    if (GetIsObjectValid(oItem))
        return TRUE;
    return FALSE;
}
