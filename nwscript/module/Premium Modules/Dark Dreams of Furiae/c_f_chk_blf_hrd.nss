// Returns whether the player PASSED a hard-difficulty bluff check

#include "nw_i0_plot"

int StartingConditional()
{
    if(AutoDC(DC_HARD, SKILL_BLUFF, GetPCSpeaker()))
        return FALSE;

    return TRUE;
}
