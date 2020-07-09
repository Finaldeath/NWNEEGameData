// Returns whether the player FAILED a medium-difficulty bluff check

#include "nw_i0_plot"

int StartingConditional()
{
    if(AutoDC(DC_MEDIUM, SKILL_BLUFF, GetPCSpeaker()))
        return FALSE;

    return TRUE;
}
