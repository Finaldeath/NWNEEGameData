// returns true when the player has not spoken with jeeves
// sidequest: dragoth the bone mage

#include "hf_in_plot"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (PlotLevelGet("DragothTheBoneMage") < 2)
    {
        return TRUE;
    }
    return FALSE;
}
